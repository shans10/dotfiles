""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" " Plugins " """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Auto-install vim-plug
if empty(glob('~/AppData/Local/nvim/autoload/plug.vim'))
  silent !curl -fLo C:/Users/Shan/AppData/Local/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/nvim/plugged')
Plug 'neoclide/coc.nvim',               {'branch': 'release'}
Plug 'tpope/vim-commentary',            { 'on': '<Plug>Commentary' }
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
Plug 'ryanoasis/vim-devicons'
call plug#end()

" Automatically install missing plugins on startup
autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
  \| endif

" Load Plugin Configs
source ~/AppData/Local/nvim/after/plugin/quickscope.rc.vim     " Quickscope

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" " END " """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
