local st = astronvim.status

-- A highlight function to return highlight for modified files
local function file_modified_hl(default)
  if vim.bo.modified then
    return { fg = "diag_ERROR" }
  else
    return { fg = default }
  end
end

-- An `init` function to build full file path
local function file_path_init(self)
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

-- A condition function if buffer is a valid file
local function is_valid_file_condition()
  return not astronvim.status.condition.buffer_matches {
    buftype = { "nofile", "prompt", "quickfix" },
    filetype = { "^git.*", "fugitive", "toggleterm", "NvimTree" },
  }
end

-- A provider function for showing the current relative path
local function current_path_provider(opts)
  return function(self)
    local bufnr = self and self.bufnr or 0
    return st.utils.stylize(
      vim.bo[bufnr].filetype ~= "help" and self.current_path,
      opts
    )
  end
end

-- A provider function for showing the current file size
local function file_size_provider(opts)
  return function(self)
    local no_search = not st.condition.is_hlsearch()
    local suffix = { 'b', 'k', 'M', 'G', 'T', 'P', 'E' }
    local fsize = vim.fn.getfsize(vim.api.nvim_buf_get_name(self and self.bufnr or 0))
    fsize = (fsize < 0 and 0) or fsize
    if fsize < 1000 then
      return st.utils.stylize(no_search and fsize .. suffix[1], opts)
    end
    local i = math.floor((math.log(fsize) / math.log(1000)))
    return st.utils.stylize(
      no_search and string.format("%.2g%s", fsize / 1000 ^ i, suffix[i + 1]),
      opts
    )
  end
end

local function filetype_provider(opts)
  return function(self)
    local buffer = vim.bo[self and self.bufnr or 0]
    return st.utils.stylize(buffer.filetype:gsub("^%l", string.upper), opts)
  end
end

-- A provider function for showing the current git branch
local function git_branch_provider(opts)
  opts = astronvim.default_tbl(opts, { truncate = 0.09 })
  return function(self)
    local branch = vim.b[self and self.bufnr or 0].gitsigns_head
    local surround = {}
    if type(opts.truncate) == "number" then
      local max_width = math.floor(st.utils.width() * opts.truncate)
      if #branch > max_width then branch = string.sub(branch, 0, max_width) .. "…" end
    end
    if st.condition.git_changed() then
      surround = { icon = astronvim.get_icon "GitBranchModified", suffix = "*" }
    else
      surround = { icon = astronvim.get_icon "GitBranch", suffix = "" }
    end
    branch = table.concat {
      surround.icon, " ", branch, surround.suffix
    }
    return st.utils.stylize(branch or "", opts)
  end
end

local function git_changes_provider(opts)
  local git_status = vim.b.gitsigns_status_dict
  local icon = astronvim.pad_string(astronvim.get_icon("GitChanges"), { right = 1 })
  local count = git_status.added + git_status.removed + git_status.changed
  return st.utils.stylize(count .. icon, opts)
end

-- A provider function for showing the current working directory
local function work_dir_provider(opts)
  return function(self)
    local bufnr = self and self.bufnr or 0
    return st.utils.stylize(vim.bo[bufnr].filetype ~= "help" and self.pwd, opts)
  end
end

return {
  -- default highlight for the entire statusline
  hl = { fg = "fg", bg = "bg" },
  -- each element following is a component in st module

  -- add a bar on left corner before mode
  st.component.builder {
    hl = { fg = "normal" },
    st.utils.surround(st.env.separators.left, "bg",
      { provider = astronvim.get_icon("Bar") }),
  },
  -- add the vim mode component
  st.component.builder {
    hl = function()
      local mode_bg = st.env.modes[vim.fn.mode()][2]
      return { fg = mode_bg }
    end,
    st.utils.surround(st.env.separators.left, "bg",
      { provider = astronvim.get_icon("EvilMode") }),
    update = "ModeChanged",
  },
  -- add component for search results
  st.component.builder {
    condition = function() return st.condition.is_hlsearch() end,
    hl = { fg = "search_fg" },
    st.utils.surround(st.env.separators.left, "search_bg", {
      provider = st.provider.search_count { padding = { left = 1, right = 1 } }
    }),
  },
  -- add component to show current buffer size
  st.component.builder {
    condition = is_valid_file_condition,
    provider = file_size_provider { padding = { left = 1, right = 2 } },
  },
  -- add component to show full file path
  st.component.builder {
    fallthrough = false,
    {
      init = file_path_init,
      condition = is_valid_file_condition,
      hl = { fg = "file_info_fg", bold = true },
      st.utils.surround(st.env.separators.left, "file_info_bg", {
        { provider = st.provider.file_icon { padding = { right = 1 } }, hl = st.hl.filetype_color },
        { provider = st.provider.file_modified { padding = { left = 1, right = 1 } }, hl = { fg = "diag_ERROR" } },
        {
          flexible = 1,
          {
            provider = work_dir_provider(),
            hl = function() return file_modified_hl("work_dir_fg") end
          },
          { provider = "" }
        },
        {
          flexible = 1,
          {
            provider = current_path_provider(),
            hl = function() return file_modified_hl("visual") end
          },
          { provider = "" }
        },
        {
          provider = st.provider.filename { padding = { right = 1 } },
          hl = function() return file_modified_hl() end
        },
        { provider = st.provider.file_read_only(), hl = { fg = "diag_WARN" } },
        { provider = "%<" }
      })
    },
    {
      hl = { fg = "treesitter_fg", bold = true },
      provider = function(self)
        local cwd = vim.fn.getcwd(0)
        local icon = astronvim.pad_string(astronvim.get_icon("Directory"), { left = 1, right = 1 })
        self.cwd = vim.fn.fnamemodify(cwd, ":t")
        return st.utils.stylize(icon .. self.cwd, { padding = { left = 1, right = 3 } })
      end,
    }
  },
  -- add a navigation component and just display the percentage of progress in the file
  st.component.nav {
    -- add some padding for the percentage provider
    percentage = { padding = { left = 3 } },
    -- disable all other providers
    ruler = {},
    scrollbar = false,
    -- use no separator and define the background color
    surround = { separator = "none", color = "file_info_bg" },
  },
  -- fill the rest of the statusline
  -- the elements after this will appear in the right side of the statusline
  st.component.fill(),
  -- add a component for the current diagnostics if it exists
  st.component.diagnostics {
    surround = { separator = "right" },
    on_click = {
      name = "heirline_diagnostic",
      callback = function()
        if astronvim.is_available "telescope.nvim" then
          vim.defer_fn(function() require("telescope.builtin").diagnostics({ bufnr = 0 }) end, 100)
        end
      end,
    },
  },
  -- add component to show lsp progress and lsp status icon if lsp is active
  st.component.builder {
    condition = st.condition.lsp_attached,
    st.utils.surround(st.env.separators.right, "lsp_bg", {
      {
        flexible = 3,
        {
          condition = function() return vim.bo.filetype ~= "haskell" end,
          provider = st.provider.lsp_progress { padding = { right = 1 } }
        },
        { provider = "" },
        update = { "User", pattern = { "LspProgressUpdate", "LspRequest" } },
      },
      {
        provider = astronvim.pad_string(astronvim.get_icon("ActiveLSP"), { right = 1 }), hl = { fg = "treesitter_fg" },
        update = { "LspAttach", "LspDetach", "BufEnter" },
      },
    }),
    on_click = {
      name = "heirline_lsp",
      callback = function()
        vim.defer_fn(function() vim.cmd.LspInfo() end, 100)
      end,
    },
  },
  -- add a component to show filetype for current file
  st.component.builder {
    condition = st.condition.has_filetype,
    hl = { fg = "work_dir_fg" },
    st.utils.surround(st.env.separators.right, "file_info_bg", {
      provider = filetype_provider { padding = { right = 1 } },
      hl = { bold = true },
    })
  },
  -- add a component to show current git branch if it exists
  st.component.builder {
    condition = st.condition.is_git_repo,
    hl = { fg = "git_branch_fg", bold = true },
    provider = git_branch_provider { padding = { left = 1, right = 1 } },
    on_click = {
      name = "heirline_branch",
      callback = function()
        if astronvim.is_available "telescope.nvim" then
          vim.defer_fn(function() require("telescope.builtin").git_branches() end, 100)
        end
      end,
    },
    update = { "User", pattern = "GitSignsUpdate" },
    init = st.init.update_events { "BufEnter" },
  },
  -- add a component for the total git changes if there are any
  st.component.builder {
    condition = st.condition.git_changed,
    hl = { fg = "diag_WARN", bold = true },
    provider = git_changes_provider,
    on_click = {
      name = "heirline_git",
      callback = function()
        if astronvim.is_available "telescope.nvim" then
          vim.defer_fn(function() require("telescope.builtin").git_status() end, 100)
        end
      end,
    },
    update = { "User", pattern = "GitSignsUpdate" },
    init = st.init.update_events { "BufEnter" },
  }
}
