let NERDTreeChDirMode = 2
let NERDTreeQuitOnOpen = 1
let NERDTreeIgnore=['\.rbc$', '\~$', '\.pyc$', '\.sqlite$', '__pycache__']
let NERDTreeSortOrder=['^__\.py$', '\/$', '*', '\.swp$','\.bak$', '\~$']
let NERDTreeShowBookmarks = 1
let NERDTree_tabs_focus_on_files=1
let NERDTreeMapOpenInTabSilent = '<RightMouse>'
let NERDTreeWinSize = 31
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.db,*.sqlite
"" Function to toggle NERDTree in Current Working Directory
function! NERDTreeToggleInCurDir()
    "If NERDTree is open in the current buffer
    if (exists("t:NERDTreeBufName") && bufwinnr(t:NERDTreeBufName) != -1)
        exe ":NERDTreeClose"
    else
        if (expand("%:t") != '')
            exe ":NERDTreeFind"
        else
            exe ":NERDTreeToggle"
        endif
    endif
endfunction

nnoremap <M-e> :call NERDTreeToggleInCurDir()<cr>
nnoremap <leader>nt :NERDTreeToggle<cr>
nnoremap <leader>nc :NERDTreeCWD<cr>
