local conditions = require "user..lualine.conditions"
local colors = require "user.lualine.colors"

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

local statusline_hl = tnvim.get_hlgroup("StatusLine")
local cursorline_hl = tnvim.get_hlgroup("CursorLine")
local normal_hl = tnvim.get_hlgroup("Normal")
local conditional_hl = tnvim.get_hlgroup("Conditional")

vim.api.nvim_set_hl(0, "SLGitIcon", { fg = conditional_hl.fg, bg = cursorline_hl.bg })
vim.api.nvim_set_hl(0, "SLBranchName", { fg = normal_hl.fg, bg = cursorline_hl.bg })
vim.api.nvim_set_hl(0, "SLSeparator", { fg = cursorline_hl.bg, bg = statusline_hl.bg })

local progress_color = "SLBranchName"
local branch = "%#SLGitIcon#" .. tnvim.get_icon("GitBranch") .. "%*" .. "%#SLBranchName#"
local separator = "%#SLSeparator#" .. "|" .. "%*"

return {
  mode = {
    function()
      return " " .. tnvim.get_icon("mode") .. " "
    end,
    padding = { left = 0, right = 0 },
    color = {},
    cond = nil,
  },
  branch = {
    "b:gitsigns_head",
    icon = branch,
    color = { gui = "bold" },
    separator = "",
  },
  dir = {
    function(self)
      local bufnr = self and self.bufnr or 0
      return vim.fn.fnamemodify(vim.fn.getcwd(bufnr), ":t")
    end,
    icon = "",
    color = { fg = progress_color },
    separator = separator,
  },
  filename = {
    "filename",
    color = {},
    cond = function()
      return not tnvim.status.condition.buffer_matches {
        buftype = { "nofile", "prompt", "quickfix" },
        filetype = { "^git.*", "fugitive", "toggleterm", "NvimTree" },
      }
    end,
    separator = separator,
  },
  diff = {
    "diff",
    source = diff_source,
    symbols = {
      added = tnvim.get_icon("GitAdd") .. " ",
      modified = tnvim.get_icon("GitChange") .. " ",
      removed = tnvim.get_icon("GitDelete") .. " ",
    },
    padding = { left = 2, right = 1 },
    diff_color = {
      added = { fg = colors.green },
      modified = { fg = colors.yellow },
      removed = { fg = colors.red },
    },
    cond = nil,
  },
  diagnostics = {
    "diagnostics",
    sources = { "nvim_diagnostic" },
    symbols = {
      error = tnvim.get_icon("DiagnosticError") .. " ",
      warn = tnvim.get_icon("DiagnosticWarn") .. " ",
      info = tnvim.get_icon("DiagnosticInfo") .. " ",
      hint = tnvim.get_icon("DiagnosticHint") .. " ",
    },
    -- cond = conditions.hide_in_width,
    separator = separator,
  },
  lsp = {
    function(self)
      -- return tnvim.get_icon("ActiveLSP1") .. " [LSP]"
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
  treesitter = {
    function()
      return tnvim.get_icon("ActiveTS") .. "TS"
      -- return "TS"
    end,
    cond = tnvim.status.condition.treesitter_available,
    separator = separator,
  },
  progress = {
    "progress",
    color = progress_color
  },
  spaces = {
    function()
      local shiftwidth = vim.api.nvim_buf_get_option(0, "shiftwidth")
      return " " .. shiftwidth
    end,
    separator = separator,
    padding = 1,
  },
  filetype = { "filetype", cond = nil, padding = { left = 1, right = 1 } },
}
