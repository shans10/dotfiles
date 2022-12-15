local heirline = require "heirline"
local colors = require "user.plugins.heirline.colors"
local winbar = require "user.plugins.heirline.winbar"
local statusline = require "user.plugins.heirline.doom.statusline"

heirline.load_colors(colors.setup_colors())
local heirline_opts = {
  statusline,
  winbar
}
heirline.setup(heirline_opts[1], heirline_opts[2])

vim.api.nvim_create_augroup("Heirline", { clear = true })
vim.api.nvim_create_autocmd("ColorScheme", {
  group = "Heirline",
  desc = "Refresh heirline colors",
  callback = function() require("heirline.utils").on_colorscheme(colors.setup_colors()) end,
})
