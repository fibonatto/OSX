" =============================================================================
" NERDTree
" =============================================================================

let NERDTreeIgnore = [
    \ 'node_modules', '^\.', '\.git', '\.cache',
    \ '\.pyc$', '\.o$', '\.swp$', 'dist', 'build'
    \ ]
let NERDTreeChDirMode         = 0
let NERDTreeWinSize           = 24
let NERDTreeShowHidden        = 1
let NERDTreeRespectWildIgnore = 1
let NERDTreeHijackNetrw       = 0

let g:NERDTreeGitStatusIndicatorMapCustom = {
    \ 'Modified'  : 'M',
    \ 'Staged'    : 'S',
    \ 'Untracked' : 'U',
    \ 'Renamed'   : 'R',
    \ 'Unmerged'  : '=',
    \ 'Deleted'   : 'D',
    \ 'Dirty'     : '*',
    \ 'Ignored'   : 'I',
    \ 'Clean'     : ' '
    \ }

function! s:SafeNERDTreeOpen()
  if isdirectory(getcwd())
    try
      NERDTree
      wincmd l
    catch /^NERDTree/
      execute 'NERDTree ' . expand('~')
      wincmd l
    endtry
  endif
endfunction

function! s:CloseIfOnlyNerdTreeLeft()
  if exists("t:NERDTreeBufName")
    if bufwinnr(t:NERDTreeBufName) != -1
      if winnr("$") == 1
        q
      endif
    endif
  endif
endfunction

" =============================================================================
" LSP — clangd (C/C++) + tsserver (JS/JSX)
" Requires: brew install llvm universal-ctags bear
"           bear generates compile_commands.json: bear -- make
" =============================================================================

let g:lsp_diagnostics_echo_cursor    = 1
let g:lsp_diagnostics_signs_enabled  = 1
let g:lsp_document_highlight_enabled = 1
let g:lsp_inlay_hints_enabled        = 1

let g:lsp_settings = {
    \ 'clangd': {
    \   'cmd': [
    \     '/opt/homebrew/opt/llvm/bin/clangd',
    \     '--background-index',
    \     '--clang-tidy',
    \     '--header-insertion=iwyu',
    \     '--completion-style=detailed',
    \     '--query-driver=/usr/bin/arm-none-eabi-gcc,/opt/homebrew/opt/emscripten/bin/emcc'
    \   ]
    \ }
    \ }
" tsserver is auto-installed by vim-lsp-settings on first JS/JSX file open


" =============================================================================
" Autocomplete (asyncomplete)
" =============================================================================

set completeopt=menuone,noinsert,noselect


" =============================================================================
" Code Navigation — gutentags
" =============================================================================

let g:gutentags_ctags_tagfile       = '.tags'
let g:gutentags_project_root        = ['Makefile', 'CMakeLists.txt', '.git', 'compile_commands.json']
let g:gutentags_ctags_extra_args    = ['--c-kinds=+pxzL', '--fields=+niazS', '--extras=+q']
let g:gutentags_generate_on_new     = 1
let g:gutentags_generate_on_missing = 1
let g:gutentags_generate_on_write   = 1


" =============================================================================
" Debug — termdebug (built-in)
" =============================================================================

packadd termdebug
let g:termdebug_wide = 1


" =============================================================================
" IndentLine
" =============================================================================

let g:indentLine_setColors     = 1
let g:indentLine_concealcursor = 'inc'
let g:indentLine_conceallevel  = 2
let g:indentLine_char          = "¦"


" =============================================================================
" DevIcons
" =============================================================================

let g:webdevicons_enable                               = 1
let g:webdevicons_enable_nerdtree                      = 1
let g:WebDevIconsUnicodeDecorateFileNodesDefaultSymbol = 'λ'
let g:WebDevIconsUnicodeDecorateFolderNodes            = 1
let g:DevIconsEnableFoldersOpenClose                   = 1


" =============================================================================
" fzf
" =============================================================================

let g:fzf_layout         = { 'down': '~30%' }
let g:fzf_preview_window = ['right:50%', 'ctrl-/']


" =============================================================================
" NERDCommenter
" =============================================================================

let g:NERDSpaceDelims              = 1
let g:NERDCompactSexyComs          = 1
let g:NERDDefaultAlign             = 'left'
let g:NERDAltDelims_java           = 1
let g:NERDCommentEmptyLines        = 1
let g:NERDTrimTrailingWhitespace   = 1
let g:NERDToggleCheckAllLines      = 1
let g:NERDBlockComIgnoreEmpty      = 0
let g:NERDCreateDefaultMappings    = 1
let g:NERDCommentWholeLinesInVMode = 1

let g:NERDCustomDelimiters = {
    \ 'phi'     : { 'left': '--', 'leftAlt': '{-', 'rightAlt': '-}' },
    \ 'agda'    : { 'left': '--', 'leftAlt': '{-', 'rightAlt': '-}' },
    \ 'haskell' : { 'left': '--', 'leftAlt': '{-', 'rightAlt': '-}' },
    \ 'kind'    : { 'left': '//' }
    \ }


" =============================================================================
" vim-c-cpp-modern
" =============================================================================

let g:cpp_member_highlight     = 1
let g:cpp_operator_highlight   = 1
let g:cpp_attributes_highlight = 1


" =============================================================================
" Silicon
" =============================================================================

let g:silicon = {
    \ 'theme':              'OneHalfLight',
    \ 'font':               'Fira Code=15',
    \ 'background':         '#6F7C8B',
    \ 'shadow-color':       '#555555',
    \ 'line-pad':           4,
    \ 'pad-horiz':          96,
    \ 'pad-vert':           32,
    \ 'shadow-blur-radius': 8,
    \ 'shadow-offset-x':    0,
    \ 'shadow-offset-y':    2,
    \ 'line-number':        v:true,
    \ 'round-corner':       v:true,
    \ 'window-controls':    v:true,
    \ }
let g:silicon['output'] = '~/Downloads/CodeSnap/vim-{time:%Y-%m-%d-%H%M%S}.png'


" =============================================================================
" Vimsence
" =============================================================================

let g:vimsence_client_id             = '715372754408439852'
let g:vimsence_editing_details       = 'Editing: {}'
let g:vimsence_editing_state         = 'Working on: {}'
let g:vimsence_file_explorer_text    = 'In NERDTree'
let g:vimsence_file_explorer_details = 'Looking for files'
let g:vimsence_custom_icons          = {'filetype': 'iconname'}


" =============================================================================
" Editor defaults
" =============================================================================

set hidden
set updatetime=300
set signcolumn=yes
set commentstring=//\ %s


" =============================================================================
" Auto-commands
" =============================================================================

augroup PluginAutoCommands
  autocmd!

  " NERDTree
  autocmd VimEnter * call s:SafeNERDTreeOpen()
  autocmd VimEnter * set number
  autocmd WinEnter * call s:CloseIfOnlyNerdTreeLeft()

  " Default comment string for unknown file types
  autocmd BufEnter * if &commentstring == '' | setlocal commentstring=//\ %s | endif
  autocmd BufEnter * if &filetype == ''      | setlocal commentstring=//\ %s | endif

  " Custom file types
  autocmd BufNewFile,BufRead *.phi setlocal filetype=phi

  " C-specific settings
  autocmd FileType c,cpp setlocal tabstop=4 shiftwidth=4 expandtab
  autocmd FileType c,cpp setlocal colorcolumn=80
  autocmd FileType c,cpp setlocal foldmethod=syntax foldlevel=99

  " JS/JSX usable defaults
  autocmd FileType javascript,javascriptreact setlocal tabstop=2 shiftwidth=2 expandtab

augroup END

" =============================================================================
" VimSence Discord
" =============================================================================
let g:python3_host_prog = '/opt/homebrew/bin/python3'

let g:vimsence_client_id = '715372754408439852'
let g:vimsence_small_text = 'Vim'
let g:vimsence_small_image = 'vim'
let g:vimsence_editing_details = 'Editing: {}'
let g:vimsence_editing_state = 'Working on: {}'
let g:vimsence_file_explorer_text = 'In NERDTree'
let g:vimsence_file_explorer_details = 'Looking for files'
let g:vimsence_custom_icons = {'filetype': 'iconname'}



" " =============================================================================
" " Digital Brain
" " =============================================================================
" function! DBSearchEngine(query, bang)
"   if a:query =~ '^#'
"     let l:pattern = a:query . '\b'
"   else
"     let l:pattern = a:query
"   endif
"
"   let l:command = 'rg --column --line-number --no-heading --color=always --smart-case -e ' . shellescape(l:pattern) . ' -- '
"   let l:spec = fzf#vim#with_preview({'dir': expand($DB)})
"   call fzf#vim#grep(l:command, 1, l:spec, a:bang)
" endfunction
"
" command! -bang -nargs=* DBSearch call DBSearchEngine(<q-args>, <bang>0)
"
" " Optional: map it to search content (not just tags)
" nnoremap <leader>fs :DBSearch<space>
