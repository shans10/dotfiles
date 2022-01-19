""" Cache changes to highliting groups
let g:airline_highlighting_cache = 1

""" Enable Powerline Symbols
let g:airline_powerline_fonts = 1

""" Tabline Settings
let g:airline#extensions#tabline#enabled = 0             " Enable Tabline
" let g:airline#extensions#tabline#show_close_button = 0   " Disable Close Button
" let g:airline#extensions#tabline#show_tab_type = 0     " Show buffers/tabs label

"" Seperators
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = ''
let g:airline#extensions#tabline#right_sep = ''
" let g:airline#extensions#tabline#right_alt_sep = ''

"" Tabs
let g:airline#extensions#tabline#show_splits = 0
" let g:airline#extensions#tabline#show_tabs = 1
" let g:airline#extensions#tabline#show_tab_nr = 0
" let g:airline#extensions#tabline#tab_nr_type = 1   " Show Tab Number
" let g:airline#extensions#tabline#tabs_label = 't'

"" Buffers
"let g:airline#extensions#tabline#buf_label_first = 1
" let g:airline#extensions#tabline#buffers_label = 'b'
" let airline#extensions#tabline#current_first = 1
"let g:airline#extensions#tabline#buffer_nr_show = 0

"" Filename
let g:airline#extensions#tabline#fnamecollapse = 1
let g:airline#extensions#tabline#fnamemod = ':t'   " Just show the file name
let g:airline#extensions#tabline#formatter = 'unique_tail'


""" Statusline Settings

"" Seperators
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''

"" Extension Settings
" let g:airline_extensions = [ 'tabline', 'coc', 'hunks', 'branch' ]
let g:airline#extensions#disable_rtp_load = 1
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#wordcount#enabled = 0
let g:airline#extensions#hunks#non_zero_only = 1
let airline#extensions#coc#warning_symbol = "\uf071 "
let airline#extensions#coc#error_symbol = "\uf05e "

"" General Appearance Tweaks
" let g:webdevicons_enable_airline_tabline = 1
" let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'
" let g:airline_section_y = '%3p%% '
" let g:airline_section_z = '%3p%%  | %l  : %-2v'

"" Mode Map
let g:airline_mode_map = {
      \ '__'     : '-',
      \ 'c'      : 'C',
      \ 'i'      : 'I',
      \ 'ic'     : 'I',
      \ 'ix'     : 'I',
      \ 'n'      : 'N',
      \ 'multi'  : 'M',
      \ 'ni'     : 'N',
      \ 'no'     : 'N',
      \ 'R'      : 'R',
      \ 'Rv'     : 'R',
      \ 's'      : 'S',
      \ 'S'      : 'S',
      \ ''     : 'S',
      \ 't'      : 'T',
      \ 'v'      : 'V',
      \ 'V'      : 'V',
      \ ''     : 'V',
      \ }
