local status_ok, heirline = pcall(require, "heirline")
if not status_ok then return end
local components = require "user.heirline.components"
local colors = require "user.heirline.colors"

heirline.load_colors(colors.setup_colors())

local statusline = {
  hl = { fg = "fg", bg = "bg" },
  components.mode,
  components.cwd,
  components.git_branch,
  components.git_diff,
  components.fill,
  components.lsp_progress,
  components.diagnostics,
  components.ts,
  components.lsp_status,
  components.spaces,
  components.file_type,
  components.nav,
}

local winbar = {
  fallthrough = false,
  {
    condition = function()
      return tnvim.status.condition.buffer_matches {
        buftype = { "terminal", "prompt", "nofile", "help", "quickfix" },
        filetype = { "NvimTree", "neo-tree", "dashboard", "Outline", "aerial" },
      }
    end,
    init = function() vim.opt_local.winbar = nil end,
  },
  {
    hl = { fg = "normal_fg" },
    components.winbar_filename,
    components.breadcrumbs
  }
}

heirline.setup(statusline, winbar)

vim.api.nvim_create_augroup("Heirline", { clear = true })
vim.api.nvim_create_autocmd("ColorScheme", {
  group = "Heirline",
  desc = "Refresh heirline colors",
  callback = function()
    heirline.reset_highlights()
    heirline.load_colors(colors.setup_colors())
  end,
})
