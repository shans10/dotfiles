""" Install Extensions
let g:coc_global_extensions = [
    \ 'coc-snippets',
    \ 'coc-actions',
    \ 'coc-lists',
    \ 'coc-emmet',
    \ 'coc-pairs',
    \ 'coc-tsserver',
    \ 'coc-floaterm',
    \ 'coc-html',
    \ 'coc-css',
    \ 'coc-emoji',
    \ 'coc-cssmodules',
    \ 'coc-yaml',
    \ 'coc-python',
    \ 'coc-svg',
    \ 'coc-prettier',
    \ 'coc-vimlsp',
    \ 'coc-xml',
    \ 'coc-yank',
    \ 'coc-json',
    \ 'coc-marketplace',
    \ 'coc-clangd',
    \ 'coc-rls',
    \ 'coc-go',
    \ ]

""" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable delays and poor user experience.
set updatetime=300

""" Use tab for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

""" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

""" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position. Coc only does snippet and additional edit on confirm.
if exists('*complete_info')
    inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
    imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

""" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

""" Use K to show documentation in preview window.
nnoremap <silent> gh :call <SID>show_documentation()<CR>
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

""" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

""" Remap keys for applying codeAction to the current line.
nmap <leader>ac  <Plug>(coc-codeaction)
""" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

""" Mappings for CoCList:
"" Show all diagnostics.
nnoremap <silent> <space>ld  :<C-u>CocList diagnostics<cr>

"" Manage extensions.
nnoremap <silent> <space>lx  :<C-u>CocList extensions<cr>

"" Show commands.
" nnoremap <silent> <space>lc  :<C-u>CocList commands<cr>

"" Show yanks.
nnoremap <silent> <space>ly  :<C-u>CocList yank<cr>

"" Show files.
nnoremap <silent> <space>lf  :<C-u>CocList files<cr>

"" Show most recent used files.
nnoremap <silent> <space>lm  :<C-u>CocList mru<cr>

"" Search words in current file.
nnoremap <silent> <space>lw  :<C-u>CocList words<cr>

"" Search words in CWD.
nnoremap <silent> <space>lg  :<C-u>CocList grep<cr>

"" Show floaterms.
nnoremap <silent> <space>la  :<C-u>CocList floaterm<cr>

"" Show tags.
nnoremap <silent> <space>lt  :<C-u>CocList tags<cr>

"" Show buffers.
nnoremap <silent> <space>lb  :<C-u>CocList buffers<cr>

""" Codelens
nmap <silent> <leader>cl :CocAction codelens<CR>

""" Generate Tags
nmap <silent> <leader>gt :CocCommand tags.generate<CR>

""" Snippets
"" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)

"" Use <C-j> for select text for visual placeholder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)

"" Use 'Tab' for jump to next placeholder, default is 'Ctrl+j'
let g:coc_snippet_next = '<Tab>'

"" Use 'Shift+Tab' for jump to previous placeholder, default is 'Ctrl+k'
let g:coc_snippet_prev = '<S-Tab>'

"" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)
