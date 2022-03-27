local M = {}

local utils = require "core.utils"
local config = utils.user_settings()

-- Automatically run PackerCompile after new plugins install
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
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
if config.enabled.dashboard and config.enabled.bufferline then
  vim.cmd [[
    augroup dashboard_settings
      autocmd!
      autocmd FileType dashboard set showtabline=0 | autocmd BufWinLeave <buffer> set showtabline=2
      autocmd BufEnter * if &ft is "dashboard" | set nocursorline | endif
      autocmd BufWinLeave <buffer> set cursorline
    augroup end
  ]]
end

-- if config.enabled.dashboard and config.enabled.bufferline then
--   vim.cmd [[
--     autocmd FileType dashboard set showtabline=0 | autocmd WinLeave <buffer> set showtabline=2
--   ]]
-- end

-- Automatically run PackerSync on plugins.lua file change
vim.cmd [[
  augroup packer_conf
    autocmd!
    autocmd bufwritepost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Highlight yank
vim.cmd [[
  augroup highlight_yank
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank({higroup="Search", timeout=300})
  augroup END
]]

-- Autoremove trailing whitespaces on save
vim.cmd [[autocmd BufWritePre * :%s/\s\+$//e]]

-- Change numbering between relative/absolute in normal/insert modes
-- vim.cmd [[
--   augroup numbertoggle
--     autocmd!
--     autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
--     autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
--   augroup END
-- ]]

-- Change nvim-tree root to current buffer root
-- vim.cmd [[autocmd BufEnter * silent! lcd %:p:h]]

return M
