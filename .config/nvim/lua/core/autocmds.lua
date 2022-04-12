local M = {}

local utils = require "core.utils"

-- Automatically run PackerCompile after new plugins install
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]]

-- Automatically run PackerSync on plugins.lua file change
vim.cmd [[
  augroup packer_conf
    autocmd!
    autocmd bufwritepost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Disable cursorline on losing file focus
vim.cmd [[
  augroup cursor_off
    autocmd!
    autocmd WinLeave * set nocursorline
    autocmd WinEnter * set cursorline
  augroup end
]]

-- Close help, references, etc. splits with 'q'
vim.cmd [[
  autocmd FileType qf,help,man nnoremap <silent> <buffer> q :close<CR>
]]

-- Disable tabline and cursorline in dashboard buffer
if utils.is_available "dashboard-nvim" and utils.is_available "bufferline.nvim" then
  vim.cmd [[
    augroup dashboard_settings
      autocmd!
      autocmd FileType dashboard set showtabline=0 | autocmd BufWinLeave <buffer> set showtabline=2
      autocmd BufEnter * if &ft is "dashboard" | set nocursorline | endif
      autocmd BufWinLeave <buffer> set cursorline
    augroup end
  ]]
end

-- Highlight yank
vim.cmd [[
  augroup highlight_yank
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank({higroup="Search", timeout=300})
  augroup END
]]

-- Autoremove trailing whitespaces on save
vim.cmd [[autocmd BufWritePre * :%s/\s\+$//e]]

-- Automatically close the tab/vim when nvim-tree is the last window in the tab
vim.cmd [[
  autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif
]]

-- Load lualine in sessions
vim.cmd [[autocmd SessionLoadPost * lua require'lualine'.setup()]]

return M
