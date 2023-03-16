-- Neovide settings
if vim.g.neovide then
  vim.cmd [[
    set guifont=JetBrainsMono\ Nerd\ Font:h11
    let g:neovide_scroll_animation_length = 0
    let g:neovide_hide_mouse_when_typing = v:true
    let g:neovide_refresh_rate = 120
    let g:neovide_cursor_animation_length=0.01
    ]]
end

-- Load user autocmds
require "user.autocmds"
