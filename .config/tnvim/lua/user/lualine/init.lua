local status_ok, lualine = pcall(require, "lualine")
if not status_ok then return end

local components = require "user.lualine.components"

lualine.setup {
  options = {
    icons_enabled = true,
    theme = "auto",
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    disabled_filetypes = { "alpha" },
    globalstatus = true,
  },
  sections = {
    lualine_a = {
      -- "mode"
      components.mode
    },
    lualine_b = {
      components.dir,
    },
    lualine_c = {
      components.branch,
      components.diff
    },
    lualine_x = {
      components.lsp_progress,
      components.diagnostics,
      components.treesitter,
      components.lsp,
      components.spaces,
      components.filetype
    },
    lualine_y = {
      components.progress
    },
    lualine_z = { "location" }
  },
}
