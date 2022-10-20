local conditions = require "user..lualine.conditions"

local function diff_source()
  local gitsigns = vim.b.gitsigns_status_dict
  if gitsigns then
    return {
      added = gitsigns.added,
      modified = gitsigns.changed,
      removed = gitsigns.removed,
    }
  end
end

local progress_color = nil
local branch = tnvim.get_icon("GitBranch")
local dir = tnvim.get_icon("Directory")
local separator = tnvim.get_icon("Bar")

if vim.g.colors_name == "tokyonight" then
  local statusline_hl = tnvim.get_hlgroup("StatusLine")
  local cursorline_hl = tnvim.get_hlgroup("CursorLine")
  local normal_hl = tnvim.get_hlgroup("Normal")
  local conditional_hl = tnvim.get_hlgroup("Conditional")
  local diagnostic_hl = tnvim.get_hlgroup("DiagnosticWarn")
  local string_hl = tnvim.get_hlgroup("String")

  vim.api.nvim_set_hl(0, "SLGitIcon", { fg = conditional_hl.fg, bg = statusline_hl.bg })
  vim.api.nvim_set_hl(0, "SLBranchName", { fg = normal_hl.fg, bg = statusline_hl.bg })
  vim.api.nvim_set_hl(0, "SLDirIcon", { fg = diagnostic_hl.fg, bg = cursorline_hl.bg })
  vim.api.nvim_set_hl(0, "SLDirName", { fg = normal_hl.fg, bg = cursorline_hl.bg })
  vim.api.nvim_set_hl(0, "SLTSIcon", { fg = string_hl.fg, bg = statusline_hl.bg })
  vim.api.nvim_set_hl(0, "SLSeparator", { fg = cursorline_hl.bg, bg = statusline_hl.bg })

  progress_color = "SLDirName"
  branch = "%#SLGitIcon#" .. branch .. "%*" .. "%#SLBranchName#"
  dir = "%#SLDirIcon#" .. dir .. "%*" .. "%#SLDirName#"
  separator = "%#SLSeparator#" .. separator .. "%*"
end

return {
  mode = {
    function()
      return tnvim.pad_string(tnvim.get_icon("Target"), { left = 1, right = 1 })
    end,
    padding = { left = 0, right = 0 },
    color = {},
    cond = nil,
  },
  branch = {
    "b:gitsigns_head",
    icon = branch,
    color = { gui = "bold" },
  },
  dir = {
    function(self)
      local bufnr = self and self.bufnr or 0
      return vim.fn.fnamemodify(vim.fn.getcwd(bufnr), ":t")
    end,
    icon = dir,
    color = { fg = progress_color },
    separator = separator,
  },
  filename = {
    "filename",
    color = {},
    cond = conditions.valid_filename,
    separator = separator,
  },
  diff = {
    "diff",
    source = diff_source,
    symbols = {
      added = tnvim.pad_string(tnvim.get_icon("GitAdd"), { right = 1 }),
      modified = tnvim.pad_string(tnvim.get_icon("GitChange"), { right = 1 }),
      removed = tnvim.pad_string(tnvim.get_icon("GitDelete"), { right = 1 }),
    },
    padding = { left = 1, right = 1 },
    cond = nil,
  },
  diagnostics = {
    "diagnostics",
    sources = { "nvim_diagnostic" },
    symbols = {
      error = tnvim.pad_string(tnvim.get_icon("DiagnosticError"), { right = 1 }),
      warn = tnvim.pad_string(tnvim.get_icon("DiagnosticWarn"), { right = 1 }),
      info = tnvim.pad_string(tnvim.get_icon("DiagnosticInfo"), { right = 1 }),
      hint = tnvim.pad_string(tnvim.get_icon("DiagnosticHint"), { right = 1 }),
    },
    cond = conditions.hide_in_width,
  },
  lsp = {
    function(self)
      local truncate = 0.25
      local buf_client_names = {}
      for _, client in pairs(vim.lsp.get_active_clients { bufnr = self and self.bufnr or 0 }) do
        if client.name == "null-ls" then
          local null_ls_sources = {}
          for _, type in ipairs { "FORMATTING", "DIAGNOSTICS" } do
            for _, source in ipairs(tnvim.null_ls_sources(vim.bo.filetype, type)) do
              null_ls_sources[source] = true
            end
          end
          vim.list_extend(buf_client_names, vim.tbl_keys(null_ls_sources))
        else
          table.insert(buf_client_names, client.name)
        end
      end
      local str = table.concat(buf_client_names, ", ")
      local max_width = math.floor(tnvim.status.utils.width() * truncate)
      if #str > max_width then str = string.sub(str, 0, max_width) .. "…" end
      if str ~= "" then
       return "[" .. str .. "]"
      else
       return "[No LS]"
      end
     end,
    color = { gui = "bold" },
    cond = conditions.hide_in_width,
    separator = separator,
  },
  lsp_progress = {
    tnvim.status.provider.lsp_progress(),
    cond = conditions.hide_in_width
  },
  treesitter = {
    function()
      return tnvim.get_icon("ActiveTS1")
    end,
    cond = tnvim.status.condition.treesitter_available,
    color = "SLTSIcon",
  },
  progress = {
    "progress",
    color = progress_color
  },
  spaces = {
    function()
      local shiftwidth = vim.api.nvim_buf_get_option(0, "shiftwidth")
      return tnvim.pad_string(tnvim.get_icon("Space"), { right = 1 }) .. shiftwidth
    end,
    separator = separator,
    padding = 1,
  },
  filetype = { "filetype", cond = nil, padding = { left = 1, right = 1 } },
}
