local status = { env = {}, hl = {}, init = {}, provider = {}, condition = {}, utils = {} }
local devicons_avail, devicons = pcall(require, "nvim-web-devicons")

-- A table defining mode names and highlight groups
status.env.modes = {
  ["n"] = { "NORMAL", "normal" },
  ["no"] = { "N-PENDING", "normal" },
  ["i"] = { "INSERT", "insert" },
  ["ic"] = { "INSERT", "insert" },
  ["t"] = { "TERMINAL", "insert" },
  ["v"] = { "VISUAL", "visual" },
  ["V"] = { "V-LINE", "visual" },
  [""] = { "V-BLOCK", "visual" },
  ["R"] = { "REPLACE", "replace" },
  ["Rv"] = { "V-REPLACE", "replace" },
  ["s"] = { "SELECT", "visual" },
  ["S"] = { "S-LINE", "visual" },
  [""] = { "S-BLOCK", "visual" },
  ["c"] = { "COMMAND", "command" },
  ["cv"] = { "COMMAND", "command" },
  ["ce"] = { "COMMAND", "command" },
  ["r"] = { "PROMPT", "inactive" },
  ["rm"] = { "MORE", "inactive" },
  ["r?"] = { "CONFIRM", "inactive" },
  ["!"] = { "SHELL", "inactive" },
}

-- A table defining status separators
status.env.separators = astronvim.user_plugin_opts("heirline.separators", {
  left = { "", "  " },
  right = { "  ", "" },
  center = { "  ", "  " },
})

-- Get the highlight background color of the lualine theme for the current colorscheme
function status.hl.lualine_mode(mode, fallback)
  local lualine_avail, lualine = pcall(require, "lualine.themes." .. (vim.g.colors_name or "catppuccin"))
  local lualine_opts = lualine_avail and lualine[mode]
  return lualine_opts and type(lualine_opts.a) == "table" and lualine_opts.a.bg or fallback
end

-- Get the highlight for the current mode
function status.hl.mode() return { fg = status.hl.mode_fg() } end

-- Get the foreground color group for the current mode
function status.hl.mode_fg() return astronvim.status.env.modes[vim.fn.mode()][2] end

-- Get the foreground color group for the current filetype
function status.hl.filetype_color(self)
  if not devicons_avail then return {} end
  local _, color = devicons.get_icon_color(
    vim.fn.fnamemodify(vim.api.nvim_buf_get_name(self and self.bufnr or 0), ":t"),
    nil,
    { default = true }
  )
  return { fg = color }
end

-- An `init` function to build a set of children components for LSP breadcrumbs
function status.init.breadcrumbs(opts)
  local aerial_avail, aerial = pcall(require, "aerial")
  opts = astronvim.default_tbl(
    opts,
    { separator = " > ", icon = { enabled = true, hl = true }, padding = { left = 0, right = 0 } }
  )
  return function(self)
    local data = aerial_avail and aerial.get_location(true) or {}
    local children = {}
    -- create a child for each level
    for _, d in ipairs(data) do
      local pos = status.utils.encode_pos(d.lnum, d.col, self.winnr)
      local child = {
        { provider = string.gsub(d.name, "%%", "%%%%"):gsub("%s*->%s*", "") }, -- add symbol name
        on_click = { -- add on click function
          minwid = pos,
          callback = function(_, minwid)
            local lnum, col, winnr = status.utils.decode_pos(minwid)
            vim.api.nvim_win_set_cursor(vim.fn.win_getid(winnr), { lnum, col })
          end,
          name = "heirline_breadcrumbs",
        },
      }
      if opts.icon.enabled then -- add icon and highlight if enabled
        table.insert(child, 1, {
          provider = string.format("%s ", d.icon),
          hl = opts.icon.hl and string.format("Aerial%sIcon", d.kind) or nil,
        })
      end
      table.insert(child, 1, { provider = opts.separator }) -- add a separator
      table.insert(children, child)
    end
    if opts.padding.left > 0 then -- add left padding
      table.insert(children, 1, { provider = astronvim.pad_string(" ", { left = opts.padding.left - 1 }) })
    end
    if opts.padding.right > 0 then -- add right padding
      table.insert(children, { provider = astronvim.pad_string(" ", { right = opts.padding.right - 1 }) })
    end
    -- instantiate the new child
    self[1] = self:new(children, 1)
  end
end

-- An `init` function to build full file path
function status.init.file_path(self)
  local bufnr = self and self.bufnr or 0
  local os_sep = package.config:sub(1, 1)
  local pwd = vim.fn.getcwd(bufnr) -- Present working directory.
  local current_path = vim.api.nvim_buf_get_name(bufnr)

  if current_path == "" then
    pwd = vim.fn.fnamemodify(pwd, ':t')
    current_path = nil
  elseif current_path:find(pwd, 1, true) then
    current_path = vim.fn.fnamemodify(current_path, ':~:.:h')
    pwd = vim.fn.fnamemodify(pwd, ':t') .. os_sep
    if current_path == '.' then
      current_path = nil
    else
      current_path = current_path .. os_sep
    end
  else
    pwd = nil
    current_path = vim.fn.fnamemodify(current_path, ':~:.:h') .. os_sep
  end

  self.pwd = pwd
  self.current_path = current_path -- The opened file path relevant to pwd.
end

-- A provider function for the fill string
function status.provider.fill() return "%=" end

-- A provider function for showing the percentage of the current location in a document
function status.provider.percentage(opts) return astronvim.status.utils.stylize("%P", opts) end

-- A provider function for showing the current line and character in a document
function status.provider.ruler(opts)
  opts = astronvim.default_tbl(opts, { pad_ruler = { line = 0, char = 0 } })
  return status.utils.stylize(string.format("%%%dl:%%%dc", opts.pad_ruler.line, opts.pad_ruler.char), opts)
end

-- A provider function for showing the current filetype
function status.provider.filetype(opts)
  return function(self)
    local buffer = vim.bo[self and self.bufnr or 0]
    return status.utils.stylize(buffer.filetype:gsub("^%l", string.upper), opts)
  end
end

-- A provider function for showing the current filename
function status.provider.filename(opts)
  opts = astronvim.default_tbl(opts, { fname = function(nr) return vim.api.nvim_buf_get_name(nr) end, modify = ":t" })
  return function(self)
    local filename = vim.fn.fnamemodify(opts.fname(self and self.bufnr or 0), opts.modify)
    return status.utils.stylize((filename == "" and "[No Name]" or filename), opts)
  end
end

-- A provider function for showing if the current file is modifiable
function status.provider.file_modified(opts)
  return function(self)
    local buffer = vim.bo[self and self.bufnr or 0]
    return status.utils.stylize(buffer.modified and astronvim.get_icon "FileModified1" or "", opts)
  end
end

-- A provider function for showing if the current file is read-only
function status.provider.file_read_only(opts)
  return function(self)
    local buffer = vim.bo[self and self.bufnr or 0]
    return status.utils.stylize(
      (not buffer.modifiable or buffer.readonly) and astronvim.get_icon "FileReadOnly" or "",
      opts
    )
  end
end

-- A provider function for showing the current filetype icon
function status.provider.file_icon(opts)
  if not devicons_avail then return "" end
  return function(self)
    local ft_icon, _ = devicons.get_icon(
      vim.fn.fnamemodify(vim.api.nvim_buf_get_name(self and self.bufnr or 0), ":t"),
      nil,
      { default = true }
    )
    return status.utils.stylize(ft_icon, opts)
  end
end

-- A provider function for showing the current file size
function status.provider.file_size(opts)
  return function(self)
    local suffix = { 'b', 'k', 'M', 'G', 'T', 'P', 'E' }
    local fsize = vim.fn.getfsize(vim.api.nvim_buf_get_name(self and self.bufnr or 0))
    fsize = (fsize < 0 and 0) or fsize
    if fsize < 1000 then
      return status.utils.stylize(not status.condition:search() and fsize .. suffix[1], opts)
    end
    local i = math.floor((math.log(fsize) / math.log(1000)))
    return status.utils.stylize(
      not status.condition:search() and string.format("%.2g%s", fsize / 1000 ^ i, suffix[i + 1]),
      opts
    )
  end
end

-- A provider function for showing the current working directory
function status.provider.work_dir(opts)
  return function(self)
    local bufnr = self and self.bufnr or 0
    return status.utils.stylize(vim.bo[bufnr].filetype ~= "help" and self.pwd, opts)
  end
end

-- A provider function for showing the current relative path
function status.provider.current_path(opts)
  return function(self)
    local bufnr = self and self.bufnr or 0
    return status.utils.stylize(
      vim.bo[bufnr].filetype ~= "help" and self.current_path,
      opts
    )
  end
end

-- A provider function for showing the current git branch
function status.provider.git_branch(opts)
  opts = astronvim.default_tbl(opts, { truncate = 0.09 })
  return function(self)
    local branch = vim.b[self and self.bufnr or 0].gitsigns_head
    local surround = {}
    if type(opts.truncate) == "number" then
      local max_width = math.floor(status.utils.width() * opts.truncate)
      if #branch > max_width then branch = string.sub(branch, 0, max_width) .. "…" end
    end
    if status.condition.git_changed() then
      surround = { icon = astronvim.get_icon "GitBranch1", suffix = "*" }
    else
      surround = { icon = astronvim.get_icon "GitBranch", suffix = "" }
    end
    branch = table.concat {
      surround.icon, " ", branch, surround.suffix
    }
    return status.utils.stylize(branch or "", opts)
  end
end

-- A provider function for showing the current git diff count of a specific type
function status.provider.git_diff(opts)
  if not opts or not opts.type then return end
  return function(self)
    local diff = vim.b[self and self.bufnr or 0].gitsigns_status_dict
    return status.utils.stylize(
      diff and diff[opts.type] and diff[opts.type] > 0 and tostring(diff[opts.type]) or "",
      opts
    )
  end
end

-- A provider function for showing the current diagnostic count of a specific severity
function status.provider.diagnostics(opts)
  if not opts or not opts.severity then return end
  return function(self)
    local bufnr = self and self.bufnr or 0
    local count = #vim.diagnostic.get(bufnr, opts.severity and { severity = vim.diagnostic.severity[opts.severity] })
    return status.utils.stylize(count ~= 0 and tostring(count) or "", opts)
  end
end

-- A provider function for showing the current progress of loading language servers
function status.provider.lsp_progress(opts)
  return function()
    local Lsp = vim.lsp.util.get_progress_messages()[1]
    return status.utils.stylize(
      Lsp
      and string.format(
        " %%<%s %s %s (%s%%%%) ",
        astronvim.get_icon("LSP" .. ((Lsp.percentage or 0) >= 70 and { "Loaded", "Loaded", "Loaded" } or {
          "Loading1",
          "Loading2",
          "Loading3",
        })[math.floor(vim.loop.hrtime() / 12e7) % 3 + 1]),
        Lsp.title or "",
        Lsp.message or "",
        Lsp.percentage or 0
      )
      or "",
      opts
    )
  end
end

-- A provider function for showing the connected LSP client names
function status.provider.lsp_client_names(opts)
  opts = astronvim.default_tbl(opts, { expand_null_ls = true, truncate = 0.25 })
  return function(self)
    local buf_client_names = {}
    for _, client in pairs(vim.lsp.get_active_clients { bufnr = self and self.bufnr or 0 }) do
      if client.name == "null-ls" and opts.expand_null_ls then
        local null_ls_sources = {}
        for _, type in ipairs { "FORMATTING", "DIAGNOSTICS" } do
          for _, source in ipairs(null_ls_sources(vim.bo.filetype, type)) do
            null_ls_sources[source] = true
          end
        end
        vim.list_extend(buf_client_names, vim.tbl_keys(null_ls_sources))
      else
        table.insert(buf_client_names, client.name)
      end
    end
    local str = table.concat(buf_client_names, ", ")
    if type(opts.truncate) == "number" then
      local max_width = math.floor(status.utils.width() * opts.truncate)
      if #str > max_width then str = string.sub(str, 0, max_width) .. "…" end
    end
    return status.utils.stylize(str, opts)
  end
end

-- A provider function for showing if treesitter is connected
function status.provider.treesitter_status(opts)
  return function()
    local ts_avail, ts = pcall(require, "nvim-treesitter.parsers")
    return status.utils.stylize((ts_avail and ts.has_parser()) and "TS" or "", opts)
  end
end

-- A provider function for displaying search results count
function status.provider.search(opts)
  return function(self)
    local search = table.concat {
      -- " ", self.query, " ", self.count.current, "/", self.count.total, " "
      " ", self.count.current, "/", self.count.total, " "
    }
    return status.utils.stylize(search, opts)
  end
end

-- A provider function for displaying a single string
function status.provider.str(opts)
  opts = astronvim.default_tbl(opts, { str = " " })
  return status.utils.stylize(opts.str, opts)
end

-- A condition function if the window is currently active
function status.condition.is_valid_file()
  return not astronvim.status.condition.buffer_matches {
    buftype = { "nofile", "prompt", "quickfix" },
    filetype = { "^git.*", "fugitive", "toggleterm", "NvimTree" },
  }
end

-- A condition function if the current file is in a git repo
function status.condition.is_git_repo() return vim.b.gitsigns_head or vim.b.gitsigns_status_dict end

-- A condition function if there are any git changes
function status.condition.git_changed()
  local git_status = vim.b.gitsigns_status_dict
  return git_status and (git_status.added or 0) + (git_status.removed or 0) + (git_status.changed or 0) > 0
end

-- A condition function if the current file has any diagnostics
function status.condition.has_diagnostics()
  return vim.g.status_diagnostics_enabled and #vim.diagnostic.get(0) > 0
end

-- A condition function if there is a defined filetype
function status.condition.has_filetype()
  return vim.fn.empty(vim.fn.expand "%:t") ~= 1 and vim.bo.filetype and vim.bo.filetype ~= ""
end

-- A condition function if LSP is attached
function status.condition.lsp_attached() return next(vim.lsp.buf_get_clients()) ~= nil end

-- A condition function if Aerial is available
function status.condition.aerial_available() return astronvim.is_available "aerial.nvim" end

-- A condition function if treesitter is in use
function status.condition.treesitter_available()
  local ts_avail, ts = pcall(require, "nvim-treesitter.parsers")
  return ts_avail and ts.has_parser()
end

-- A condition function if there are search results
function status.condition:search()
  local lines = vim.api.nvim_buf_line_count(0)
  if lines > 50000 then return end

  local query = vim.fn.getreg("/")
  if query == "" then return end

  if query:find("@") then return end

  local search_count = vim.fn.searchcount({ recompute = 1, maxcount = -1 })
  local active = false
  if vim.v.hlsearch and vim.v.hlsearch == 1 and search_count.total > 0 then
    active = true
  end
  if not active then return end

  query = query:gsub([[^\V]], "")
  query = query:gsub([[\<]], ""):gsub([[\>]], "")

  self.query = query
  self.count = search_count
  return true
end

-- A utility function to stylize a string with an icon from lspkind, separators, and left/right padding
function status.utils.stylize(str, opts)
  opts = astronvim.default_tbl(opts, {
    padding = { left = 0, right = 0 },
    separator = { left = "", right = "" },
    icon = { kind = "NONE", padding = { left = 0, right = 0 } },
  })
  local icon = astronvim.pad_string(astronvim.get_icon(opts.icon.kind), opts.icon.padding)
  return str
      and str ~= ""
      and opts.separator.left .. astronvim.pad_string(icon .. str, opts.padding) .. opts.separator.right
      or ""
end

-- A utility function to get the width of the bar
function status.utils.width()
  return vim.o.laststatus == 3 and vim.o.columns or vim.api.nvim_win_get_width(0)
end

-- Surround component with separator and color adjustment
function status.utils.surround(separator, color, component)
  local function surround_color(self)
    local colors = type(color) == "function" and color(self) or color
    return type(colors) == "string" and { main = colors } or colors
  end

  separator = type(separator) == "string" and status.env.separators[separator] or separator
  local surrounded = {}
  if separator[1] ~= "" then
    table.insert(surrounded, {
      provider = separator[1],
      hl = function(self)
        local s_color = surround_color(self)
        if s_color then return { fg = s_color.main, bg = s_color.left } end
      end,
    })
  end
  table.insert(surrounded, {
    hl = function(self)
      local s_color = surround_color(self)
      if s_color then return { bg = s_color.main } end
    end,
    astronvim.default_tbl({}, component),
  })
  if separator[2] ~= "" then
    table.insert(surrounded, {
      provider = separator[2],
      hl = function(self)
        local s_color = surround_color(self)
        if s_color then return { fg = s_color.main, bg = s_color.right } end
      end,
    })
  end
  return surrounded
end

-- Encode a position to a single value that can be decoded later
function status.utils.encode_pos(line, col, winnr)
  return bit.bor(bit.lshift(line, 16), bit.lshift(col, 6), winnr)
end

-- Decode a previously encoded position to it's sub parts
function status.utils.decode_pos(c)
  return bit.rshift(c, 16), bit.band(bit.rshift(c, 6), 1023), bit.band(c, 63)
end

return status
