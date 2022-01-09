""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" " Plugins " """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.local/share/nvim/plugged')
Plug 'neoclide/coc.nvim',               {'branch': 'release'}
Plug 'tpope/vim-commentary',            { 'on': '<Plug>Commentary' }
Plug 'junegunn/fzf',                    { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim',
Plug 'lambdalisue/suda.vim'
Plug 'machakann/vim-highlightedyank'
Plug 'jiangmiao/auto-pairs'
Plug 'justinmk/vim-sneak'
Plug 'unblevable/quick-scope'
Plug 'mhinz/vim-signify'
Plug 'tpope/vim-fugitive'
Plug 'voldikss/vim-floaterm',           { 'on': [ 'FloatermToggle', 'FloatermNew' ] }
Plug 'vim-airline/vim-airline'
Plug 'preservim/nerdtree',              { 'on': [ 'NERDTreeCWD', 'NERDTreeToggle', 'NERDTreeFind' ] }
Plug 'gruvbox-community/gruvbox'
Plug 'mhinz/vim-startify'
Plug 'mbbill/undotree',                 { 'on': 'UndotreeToggle' }
Plug 'rrethy/vim-hexokinase',           { 'do': 'make hexokinase' }
Plug 'ryanoasis/vim-devicons'
call plug#end()

" Automatically install missing plugins on startup
autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
  \| endif

" Load Plugin Configs
source ~/.config/nvim/after/plugin/suda.rc.vim           " Suda
source ~/.config/nvim/after/plugin/quickscope.rc.vim     " Quickscope

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" " END " """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
