local status_ok, heirline = pcall(require, "heirline")
if not status_ok then return end
local components = require "user.heirline.components"
local colors = require "user.heirline.colors"

heirline.load_colors(colors.setup_colors())
local statuslines = {
  hl = { fg = "fg", bg = "bg" },
  components.mode,
  components.cwd,
  components.git_branch,
  components.git_diff,
  components.fill,
  components.lsp_progress,
  components.diagnostics,
  components.ts,
  components.lsp,
  components.spaces,
  components.filetype,
  components.nav,
}
heirline.setup(statuslines)

vim.api.nvim_create_augroup("Heirline", { clear = true })
vim.api.nvim_create_autocmd("ColorScheme", {
  group = "Heirline",
  desc = "Refresh heirline colors",
  callback = function()
    heirline.reset_highlights()
    heirline.load_colors(colors.setup_colors())
  end,
})
