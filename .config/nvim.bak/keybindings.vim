""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""  " Personal Keybindings " """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""" Term
"" Split
nmap <M-t> :15new term://fish<CR>
imap <M-t> :15new term://fish<CR>
tmap <M-t> :15new term://fish<CR>
nmap <leader>tt :15new term://fish<CR>

"" Full
nmap <M-S-t> :term<CR>
imap <M-S-t> :term<CR>
tmap <M-S-t> :term<CR>
nmap <leader>tf :term<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""" Inbuilt fuzzy finding
" Find file
noremap <leader>fd :find<space>
noremap <leader>fc :find <cword> <CR>

" Find buffer
noremap <leader>bc :<C-U><C-R>=printf("b %s", "") <CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""" Navigation
nmap <M-o> <C-o>
nmap <M-i> <C-i>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""" Change 2 split windows from vert to horiz or horiz to vert
map <Leader>th <C-w>t<C-w>H
map <Leader>tv <C-w>t<C-w>K

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""" Quit
nmap <leader>qw :q<CR>
imap <M-q> <esc>:q<CR>
nmap <M-q> :q<CR>
tmap <M-q> <esc>:q<CR>

""" Quit Without Saving
nmap <leader>qq :q!<CR>
imap <M-S-q> <esc>:q!<CR>
nmap <M-S-q> :q!<CR>
tmap <M-S-q> <esc>:q!<CR>

""" Save
nmap <leader>fs :w<CR>

""" Save and Quit
nmap <leader>wq :wq<CR>
imap <M-w> <esc>:wq<CR>
nmap <M-w> :wq<CR>
tmap <M-w> <esc>:wq<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""" Reindent the Whole File
map <leader>i gg=G

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""" Undo/Redo
""" Redo
imap <C-r> <esc><C-r>
tmap <C-r> <esc><C-r>

""" Undo
imap <C-z> <esc>u<cr>
tmap <C-z> <esc>u<cr>
nmap <C-z> u<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""" shift+arrow selection
nmap <S-Up> v<Up>
nmap <S-Down> v<Down>
nmap <S-Left> v<Left>
nmap <S-Right> v<Right>
vmap <S-Up> <Up>
vmap <S-Down> <Down>
vmap <S-Left> <Left>
vmap <S-Right> <Right>
imap <S-Up> <Esc>v<Up>
imap <S-Down> <Esc>v<Down>
imap <S-Left> <Esc>v<Left>
imap <S-Right> <Esc>v<Right>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""" BUFFERS
nmap <leader>bl :ls<CR>

""" Goto Buffer
nnoremap <M-S-b> :buffers<CR>:buffer<Space>
inoremap <M-S-b> <esc>:buffers<CR>:buffer<Space>
tmap <M-S-b> <esc>:buffers<CR>:buffer<Space>

""" Delete Current Buffer
nnoremap <M-d> :bd<CR>
nnoremap <leader>bs :bd<CR>
inoremap <M-d> <esc>:bd<CR>
tmap <M-d> <esc>:bd<CR>

""" Delete Current Buffer without saving
nnoremap <M-S-d> :bd!<CR>
nnoremap <leader>bd :bd!<CR>
inoremap <M-S-d> <esc>:bd!<CR>
tmap <M-S-d> <esc>:bd!<CR>

""" Next/Previous Buffer
""" Function to skip terminal buffer
au BufEnter * if &buftype == 'terminal' | startinsert | else | stopinsert | endif
function! PrevBufferTab()
    bprev
    if &buftype == 'terminal'
        bd!
        bprev
    endif
endfunction
function! NextBufferTab()
    bnext
    if &buftype == 'terminal'
        bd!
        bnext
    endif
endfunction

" Cycle buffers
nnoremap <M-,> :call PrevBufferTab()<CR>
nnoremap <leader>bp :call PrevBufferTab()<CR>
nnoremap <M-.> :call NextBufferTab()<CR>
nnoremap <leader>bn :call NextBufferTab()<CR>
inoremap <M-,> <esc>:call PrevBufferTab()<CR>
inoremap <M-.> <esc>:call NextBufferTab()<CR>
tmap <M-,> <esc>:call PrevBufferTab()<CR>
tmap <M-.> <esc>:call NextBufferTab()<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""" TABS
nmap <M->> gt
nmap <M-<> gT
imap <M->> <esc>gt
imap <M-<> <esc>gT

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""" Toggle vertical line
set colorcolumn=
fun! ToggleCC()
    if &cc == ''
        " set cc=1,4,21
        set cc=80
    else
        set cc=
    endif
endfun
nnoremap <silent> <F9> :call ToggleCC()<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""" Beginning and end of line
nmap <M-a> <home>
nmap <M-n> <end>
imap <M-a> <home>
imap <M-n> <end>
cmap <M-a> <home>
cmap <M-n> <end>
nmap <leader>le <end>
nmap <leader>ls <home>
vmap <leader>le <end>
vmap <leader>ls <home>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""" Controla-S Save
nmap <C-S> :w<cr>
vmap <C-S> <esc>:w<cr>
imap <C-S> <esc>:w<cr>
nmap <M-S> :w<cr>
vmap <M-S> <esc>:w<cr>
imap <M-S> <esc>:w<cr>
" Save + back into insert
" imap <C-S> <esc>:w<cr>a

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""" Copy/Paste
xnoremap p "_dP

" Alt-Shift-V Paste in insert and command mode
imap <M-V> <esc>pa
cmap <M-V> <C-r>+
nmap <M-V> p
vmap <M-V> p

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""" SPLITS

"" Create splits
map <leader>sv :vsplit <CR>             " Vertical
map <leader>sh :split <CR>              " Horizontal

""" Window Movement between splits
nmap <M-h> <C-w>h
nmap <leader>wh <C-w>h
nmap <M-left> <C-w>h
nmap <M-j> <C-w>j
nmap <leader>wj <C-w>j
nmap <M-down> <C-w>j
nmap <M-k> <C-w>k
nmap <leader>wk <C-w>k
nmap <M-up> <C-w>k
nmap <M-l> <C-w>l
nmap <leader>wl <C-w>l
nmap <M-right> <C-w>l

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""" Resizing
nmap <M-S-h> 2<C-w><
nmap <M-S-l> 2<C-w>>
nmap <M-S-j> <C-w>-
nmap <M-S-k> <C-w>+
nmap <M-=> <C-w>=

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""" Insert mode movement
" Using Alt key
imap <M-h> <left>
imap <M-j> <down>
imap <M-k> <up>
imap <M-l> <right>

" Using Ctrl key
inoremap <C-k> <up>
inoremap <C-j> <down>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""" Alt-m for creating a new line in insert mode
imap <M-m> <esc>o

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""" Command mode history
cmap <M-k> <up>
cmap <M-j> <down>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""" Back to normal mode from insert
inoremap jj <esc>
imap <M-c> <esc>
tmap <M-c> <esc>
cmap <M-c> <esc>
vmap <M-c> <esc>
map <M-c> <esc>
" inoremap JK <esc>
" Exit Insert mode in terminal
tnoremap <Esc> <C-\><C-n>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""" Manually refresh file
nmap <F5> :e!<cr>
nmap <M-r> :e!<cr>
nmap <leader>rf :e!<cr>

""" Create new file
nmap <leader>nf :e<space>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""" Select All
map <leader>sa <esc>ggVG<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""" Clear search highlighting with Escape key
nnoremap <silent><esc> :noh<return><esc>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""" PageUp/PageDown
nmap <M-b> <C-b><CR>
nmap <M-f> <C-f><CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""" Source Config
nnoremap <leader>so :so %<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""" Session Related Keybindings
nnoremap <leader>ss :SSave<CR>
nnoremap <leader>sd :SDelete<CR>
nnoremap <leader>sl :SLoad<Space>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" " END " """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
