""" Lazy Load
" augroup hexokinase
"     autocmd!
"     autocmd CursorHold * HexokinaseTurnOn
" augroup END
map <leader>ht :HexokinaseTurnOn<CR>   " Keybinding

""" Highlight Style
let g:Hexokinase_highlighters = [ 'backgroundfull' ]
