"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" " Basic Settings " """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""" SOURCE FILES

""" Plugins
source ~/.config/nvim/plugins.vim

""" Personal Keybindings
source ~/.config/nvim/keybindings.vim

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""" SETTINGS
""" Provider Settings
let g:loaded_python_provider = 0   " Disable python2 support
let g:loaded_ruby_provider = 0     " Disable ruby support
let g:loaded_node_provider = 0     " Disable nodejs support

""" Encoding
set encoding=utf-8
scriptencoding utf-8
set fileencoding=utf-8

" Colorscheme
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
set termguicolors
"set t_Co=256
"let g:rehash256 = 1
"colorscheme challenger_deep
colorscheme gruvbox

""" Bold Highlights
source ~/.config/nvim/bold-highlights.vim

" Signify Symbols Colors
highlight SignifySignAdd    ctermfg=green   guifg=#b8bb26 cterm=NONE gui=bold
highlight SignifySignDelete ctermfg=red     guifg=#fb4934 cterm=NONE gui=bold
highlight SignifySignChange ctermfg=yellow  guifg=#fabd2f cterm=NONE gui=bold

""" Enable native fuzzy file finding
set path+=**

""" Set ripgrep as default grep program
set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case

set nocompatible
filetype plugin indent on

""" Commandline Completion
set wildmenu

""" Shell
"set shell=/bin/fish

""" Split Below/Right
set splitbelow
set splitright

""" Left/Right Navigation Change Line
set whichwrap+=<,>,[,]

""" Highlight the line on which the cursor lives.
set cursorline

""" Always show at least one line above/below the cursor.
set scrolloff=15
""" Always show at least one line left/right of the cursor.
set sidescrolloff=5

""" Smart Relative line numbers(absolute numbering in insert mode)
set number relativenumber
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
augroup END

""" Highlight matching pairs of brackets. Use the '%' character to jump between them.
set matchpairs+=<:>

""" Display different types of white spaces.
set list
set listchars=tab:›\ ,trail:•,extends:#,nbsp:.

""" Use system clipboard
"set clipboard+=unnamedplus
set clipboard=unnamedplus

""" Remove timeout for partially typed commands
set notimeout

""" If lightline/airline is enabled, don't show mode under it
set noshowmode

""" Substitute live preview
set inccommand=nosplit

""" Leader Key
map <Space> <Leader>

""" Swap and Backup
set noswapfile
set nobackup
set nowritebackup
set undodir=~/.nvim/undodir
set undofile

""" Indentation
set smarttab
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set nowrap
" set smartindent
set autoindent
set cindent

""" Give more space for displaying messages.
"set cmdheight=2

""" Allow switching between buffers without saving
set hidden

""" Mouse support
set mouse=a

""" Case insensitive searching
set ignorecase

""" Will automatically switch to case sensitive if you use any capitals
set smartcase

""" netrw configuration
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_banner = 0
let g:netrw_winsize = 21
let g:netrw_altfile = 1
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+,\(^\|\s\s\)ntuser\.\S\+'
autocmd FileType netrw set nolist

""" Always Enter Terminal Buffer in Insert Mode
""" For Split Term opened with a shortcut
autocmd BufWinEnter,WinEnter term://* startinsert
""" For New Terminals Opened using :term command
autocmd TermOpen * startinsert

""" Auto toggle smart case of for ex commands
""" Assumes 'set ignorecase smartcase'
augroup dynamic_smartcase
    autocmd!
    autocmd CmdLineEnter : set nosmartcase
    autocmd CmdLineLeave : set smartcase
augroup END

""" Restore last cursor position and marks on open
au BufReadPost *
         \ if line("'\"") > 1 && line("'\"") <= line("$") && &ft !~# 'commit'
         \ |   exe "normal! g`\""
         \ | endif

""" Make ci( work like quotes do
function! New_cib()
    if search("(","bn") == line(".")
        sil exe "normal! f)ci("
        sil exe "normal! l"
        startinsert
    else
        sil exe "normal! f(ci("
        sil exe "normal! l"
        startinsert
    endif
endfunction

""" And for curly brackets
function! New_ciB()
    if search("{","bn") == line(".")
        sil exe "normal! f}ci{"
        sil exe "normal! l"
        startinsert
    else
        sil exe "normal! f{ci{"
        sil exe "normal! l"
        startinsert
    endif
endfunction

nnoremap ci( :call New_cib()<CR>
nnoremap cib :call New_cib()<CR>
nnoremap ci{ :call New_ciB()<CR>
nnoremap ciB :call New_ciB()<CR>

""" Trim Whitespaces
fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun
autocmd BufWritePre * :call TrimWhitespace()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" " END " """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
