" =============================================================================
" NERDTree - Senior Setup
" =============================================================================

let NERDTreeIgnore = [
    \ 'node_modules', '^\.', '\.git', '\.cache',
    \ '\.pyc$', '\.o$', '\.swp$', 'dist', 'build'
    \ ]
let NERDTreeWinSize           = 24
let NERDTreeShowHidden        = 1
let NERDTreeRespectWildIgnore = 1

" Auto-open NERDTree on startup if no file specified
function! s:StartUp()
    if argc() == 0 && !exists("s:std_in")
        NERDTree
        wincmd p
    endif
endfunction

" =============================================================================
" LSP (Clangd) - Context Aware (C / WASM / Embedded)
" =============================================================================

let g:lsp_diagnostics_echo_cursor    = 1
let g:lsp_diagnostics_signs_enabled  = 1
let g:lsp_document_highlight_enabled = 1
let g:lsp_inlay_hints_enabled        = 1

" Virtual Text & Signs Setup
let g:lsp_diagnostics_virtual_text_enabled = 1
let g:lsp_diagnostics_virtual_text_prefix  = "  ‣ "
let g:lsp_diagnostics_signs_error   = {'text': '✘'}
let g:lsp_diagnostics_signs_warning = {'text': '⚠'}
let g:lsp_diagnostics_signs_hint    = {'text': '💡'}
let g:lsp_diagnostics_signs_information = {'text': 'ℹ'}

" Inteligência de Projetos: WASM / Emscripten / Native
let g:lsp_settings = {
    \ 'clangd': {
    \   'cmd': [
    \     '/opt/homebrew/opt/llvm/bin/clangd',
    \     '--background-index',
    \     '--clang-tidy',
    \     '--header-insertion=iwyu',
    \     '--completion-style=detailed',
    \     '--fallback-style=Google',
    \     '--query-driver=/usr/bin/arm-none-eabi-gcc,/opt/homebrew/opt/emscripten/bin/emcc,/usr/bin/gcc'
    \   ]
    \ }
    \ }

" =============================================================================
" Gutentags - DevOps Performance (No clutter)
" =============================================================================

let g:gutentags_cache_dir = expand('~/.vim/.gutentags_cache')
if !isdirectory(g:gutentags_cache_dir)
  call mkdir(g:gutentags_cache_dir, 'p')
endif

let g:gutentags_ctags_tagfile       = '.tags'
let g:gutentags_project_root        = ['Makefile', 'CMakeLists.txt', '.git', 'compile_commands.json', 'compile_flags.txt', 'build.sh']
let g:gutentags_ctags_extra_args    = ['--c-kinds=+pxzL', '--fields=+niazS', '--extras=+q']
let g:gutentags_generate_on_new     = 1
let g:gutentags_generate_on_missing = 1
let g:gutentags_generate_on_write   = 1

" =============================================================================
" Auto-commands & Workflow Optimization
" =============================================================================

augroup SergioWorkflow
  autocmd!

  " NERDTree Startup
  autocmd StdinReadPre * let s:std_in=1
  autocmd VimEnter * call s:StartUp()

  " Fechar se sobrar apenas NERDTree
  autocmd BufEnter * if winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree() | q | endif

  " Build inteligente (Senior DevOps Style)
  autocmd FileType c,cpp setlocal makeprg=make\ -j$(nproc)
  autocmd FileType c,cpp if filereadable('build.sh') | setlocal makeprg=./build.sh | endif

  " Performance: Syntax off em arquivos gigantes (>1MB)
  autocmd BufReadPre * if getfsize(expand("%")) > 1024 * 1024 | syntax off | endif

  " Custom FileTypes (Sergio Bonatto Core)
  autocmd BufNewFile,BufRead *.phi setlocal filetype=phi
  autocmd FileType c,cpp setlocal tabstop=4 shiftwidth=4 noexpandtab colorcolumn=80
  autocmd FileType javascript,javascriptreact setlocal tabstop=2 shiftwidth=2 expandtab

augroup END

" =============================================================================
" Vimsence Discord
" =============================================================================
let g:python3_host_prog = '/opt/homebrew/bin/python3'
let g:vimsence_client_id = '715372754408439852'
let g:vimsence_editing_details = 'Editing: {}'
let g:vimsence_editing_state = 'Working on: {}'

" " =============================================================================
" " Digital Brain (Basal) Logic
" " =============================================================================

" function! DBSearchEngine(query, bang)
"   if a:query =~ '^#'
"     let l:pattern = a:query . '\b'
"   else
"     let l:pattern = a:query
"   endif

"   let l:command = 'rg --column --line-number --no-heading --color=always --smart-case -e ' . shellescape(l:pattern) . ' -- '
"   let l:spec = fzf#vim#with_preview({'dir': expand($DB)})
"   call fzf#vim#grep(l:command, 1, l:spec, a:bang)
" endfunction

" command! -bang -nargs=* DBSearch call DBSearchEngine(<q-args>, <bang>0)
" nnoremap <leader>fs :DBSearch<space>

" Snippets / Asyncomplete Setup
set completeopt=menuone,noinsert,noselect

" NERDCommenter
let g:NERDSpaceDelims              = 1
let g:NERDDefaultAlign             = 'left'
let g:NERDCustomDelimiters = {
    \ 'phi'     : { 'left': '--', 'leftAlt': '{-', 'rightAlt': '-}' },
    \ 'agda'    : { 'left': '--', 'leftAlt': '{-', 'rightAlt': '-}' },
    \ 'kind'    : { 'left': '//' }
    \ }
