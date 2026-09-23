" ===================================================================
" ATOM ONE LIGHT STATUSLINE MODULE
" Mapeamento semântico baseado na paleta original do Atom One Light
" ===================================================================

" Guard para evitar conflitos
if exists('g:loaded_statusline_atom_one_light')
  finish
endif
let g:loaded_statusline_atom_one_light = 1

" Função de inicialização do statusline
function! statusline#init()
  " Cores oficiais do Atom One Light - EXATAS
  let s:bg        = "#fafafa"  " Background principal
  let s:fg        = "#383a42"  " Texto padrão (Normal, Operator)
  let s:comment   = "#a0a1a7"  " Comentários
  let s:keyword   = "#a626a4"  " Keywords (Statement, Conditional...)
  let s:string    = "#50a14f"  " Strings
  let s:number    = "#986801"  " Numbers, Boolean, Constant
  let s:function  = "#4078f2"  " Functions
  let s:variable  = "#e45649"  " Identifier, Special, Delete (git)
  let s:orange    = "#c18401"  " Tom amarelado/laranja alternativo
  let s:guide     = "#e5e5e6"  " Guias visuais (separadores)
  let s:cursor_bg = "#f0f0f0"  " CursorLine background

  " Mapeamento de cores por modo:
  " Normal    -> Function (azul)     - modo principal, cor calma
  " Insert    -> String (verde)      - inserção, cor de crescimento
  " Replace   -> Variable (vermelho) - substituição, cor de atenção
  " Visual    -> Keyword (roxo)      - seleção, cor de destaque
  " Command   -> Number (laranja)    - comando, cor de ação
  " Terminal  -> Orange (amarelo)    - terminal, cor alternativa

  " StatusLine base - usando cores corretas
  execute 'highlight StatusLine      guifg=' . s:fg . ' guibg=' . s:guide . ' gui=NONE'
  execute 'highlight StatusLineNC    guifg=' . s:comment . ' guibg=' . s:guide . ' gui=NONE'

  " Mode colors - usando a paleta oficial com melhor contraste
  execute 'highlight ModeNFGC        guifg=' . s:bg . ' guibg=' . s:function . ' gui=bold'
  execute 'highlight ModeNFGCS       guifg=' . s:function . ' guibg=' . s:guide . ' gui=NONE'
  execute 'highlight ModeIFGC        guifg=' . s:bg . ' guibg=' . s:string . ' gui=bold'
  execute 'highlight ModeIFGCS       guifg=' . s:string . ' guibg=' . s:guide . ' gui=NONE'
  execute 'highlight ModeRFGC        guifg=' . s:bg . ' guibg=' . s:variable . ' gui=bold'
  execute 'highlight ModeRFGCS       guifg=' . s:variable . ' guibg=' . s:guide . ' gui=NONE'
  execute 'highlight ModeVFGC        guifg=' . s:bg . ' guibg=' . s:keyword . ' gui=bold'
  execute 'highlight ModeVFGCS       guifg=' . s:keyword . ' guibg=' . s:guide . ' gui=NONE'
  execute 'highlight ModeCFGC        guifg=' . s:bg . ' guibg=' . s:number . ' gui=bold'
  execute 'highlight ModeCFGCS       guifg=' . s:number . ' guibg=' . s:guide . ' gui=NONE'
  execute 'highlight ModeTFGC        guifg=' . s:bg . ' guibg=' . s:orange . ' gui=bold'
  execute 'highlight ModeTFGCS       guifg=' . s:orange . ' guibg=' . s:guide . ' gui=NONE'

  " Buffer e status colors - cores oficiais com semântica correta
  execute 'highlight BufferS         guifg=' . s:comment . ' guibg=' . s:guide . ' gui=NONE'
  execute 'highlight Modified        guifg=' . s:fg . ' guibg=#ffe792 gui=bold'
  execute 'highlight ModifiedS       guifg=#ffe792 guibg=' . s:guide . ' gui=NONE'
  execute 'highlight SLGreen         guifg=' . s:fg . ' guibg=#e6ffed gui=NONE'
  execute 'highlight SLBlue          guifg=' . s:fg . ' guibg=' . s:cursor_bg . ' gui=NONE'
  execute 'highlight BufferError     guifg=' . s:bg . ' guibg=' . s:variable . ' gui=bold'
  execute 'highlight BufferErrorS    guifg=' . s:variable . ' guibg=' . s:guide . ' gui=NONE'
  execute 'highlight SLLimiter       guifg=' . s:string . ' guibg=' . s:guide . ' gui=NONE'
  execute 'highlight CursorStatus    guifg=' . s:fg . ' guibg=#e6ffed gui=NONE'
endfunction

" ===================================================================
" STATUSLINE FUNCTIONS
" ===================================================================

" Símbolos powerline
function! s:GetSymbols()
  if empty($DISPLAY) || !has('gui_running')
    return ['', '']
  else
    return ['', '']
  endif
endfunction

" Set colors for statusline based on mode
function! statusline#DetectMode(mode)
  let [l:leftSymbol, l:rightSymbol] = s:GetSymbols()
  let l:statusline = ""

  " Mode section com cores apropriadas
  if a:mode == 'n'
    let l:statusline .= "%#ModeNFGCS#" . l:leftSymbol
    let l:statusline .= "%#ModeNFGC# NORMAL "
    let l:statusline .= "%#ModeNFGCS#" . l:rightSymbol . l:leftSymbol
    let l:statusline .= "%#StatusLine#[%n/%{bufnr('$')}] "
  elseif a:mode == 'i'
    let l:statusline .= "%#ModeIFGCS#" . l:leftSymbol
    let l:statusline .= "%#ModeIFGC# INSERT "
    let l:statusline .= "%#ModeIFGCS#" . l:rightSymbol . l:leftSymbol
    let l:statusline .= "%#StatusLine#[%n/%{bufnr('$')}] "
  elseif a:mode == 'R'
    let l:statusline .= "%#ModeRFGCS#" . l:leftSymbol
    let l:statusline .= "%#ModeRFGC# REPLACE "
    let l:statusline .= "%#ModeRFGCS#" . l:rightSymbol . l:leftSymbol
    let l:statusline .= "%#StatusLine#[%n/%{bufnr('$')}] "
  elseif a:mode ==# 'v'
    let l:statusline .= "%#ModeVFGCS#" . l:leftSymbol
    let l:statusline .= "%#ModeVFGC# VISUAL "
    let l:statusline .= "%#ModeVFGCS#" . l:rightSymbol . l:leftSymbol
    let l:statusline .= "%#StatusLine#[%n/%{bufnr('$')}] "
  elseif a:mode ==# 'V'
    let l:statusline .= "%#ModeVFGCS#" . l:leftSymbol
    let l:statusline .= "%#ModeVFGC# V-LINE "
    let l:statusline .= "%#ModeVFGCS#" . l:rightSymbol . l:leftSymbol
    let l:statusline .= "%#StatusLine#[%n/%{bufnr('$')}] "
  elseif a:mode ==# ''
    let l:statusline .= "%#ModeVFGCS#" . l:leftSymbol
    let l:statusline .= "%#ModeVFGC# V-BLOCK "
    let l:statusline .= "%#ModeVFGCS#" . l:rightSymbol . l:leftSymbol
    let l:statusline .= "%#StatusLine#[%n/%{bufnr('$')}] "
  elseif a:mode ==# 'c'
    let l:statusline .= "%#ModeCFGCS#" . l:leftSymbol
    let l:statusline .= "%#ModeCFGC# COMMAND "
    let l:statusline .= "%#ModeCFGCS#" . l:rightSymbol . l:leftSymbol
    let l:statusline .= "%#StatusLine#[%n/%{bufnr('$')}] "
  elseif a:mode ==# 't'
    let l:statusline .= "%#ModeTFGCS#" . l:leftSymbol
    let l:statusline .= "%#ModeTFGC# TERMINAL "
    let l:statusline .= "%#ModeTFGCS#" . l:rightSymbol . l:leftSymbol
    let l:statusline .= "%#StatusLine#[%n/%{bufnr('$')}] "
  else
    let l:statusline .= "%#ModeNFGCS#" . l:leftSymbol
    let l:statusline .= "%#ModeNFGC# NORMAL "
    let l:statusline .= "%#ModeNFGCS#" . l:rightSymbol . l:leftSymbol
    let l:statusline .= "%#StatusLine#[%n/%{bufnr('$')}] "
  endif

  " File name section com indicador de modificação
  if &modified == 1
    let l:statusline .= "%#Modified# %.20f %#ModifiedS#" . l:rightSymbol . " "
  else
    let l:statusline .= "%#StatusLine# %.20f %#BufferS#" . l:rightSymbol . " "
  endif

  " Alinhamento à direita
  let l:statusline .= "%="

  " Git information (se disponível)
  if exists('*FugitiveHead') && len(FugitiveHead()) > 0
    let l:statusline .= "%#BufferS#" . l:leftSymbol . "%#SLGreen# " . FugitiveHead() . " "
    if exists('*GitGutterGetHunkSummary')
      let l:statusline .= "%#SLBlue# %{statusline#GitGutterStatus()} %#BufferS#" . l:rightSymbol . " "
    else
      let l:statusline .= "%#BufferS#" . l:rightSymbol . " "
    endif
  elseif exists('*GitGutterGetHunkSummary')
    let l:statusline .= "%#BufferS#" . l:leftSymbol . "%#SLBlue# %{statusline#GitGutterStatus()} %#BufferS#" . l:rightSymbol . " "
  endif

  " File type
  let l:statusline .= "%#BufferS#" . l:leftSymbol . "%#StatusLine# %{statusline#GetFileType()} "

  " Error/Lint status com melhor tratamento
  if exists('*coc#status') && !empty(get(b:, 'coc_diagnostic_info', {}))
    let l:coc_status = coc#status()
    if l:coc_status != ""
      let l:statusline .= "%#BufferError# " . l:coc_status . "%{get(b:,'coc_current_function','')} %#BufferErrorS#" . l:rightSymbol . " "
    else
      let l:statusline .= "%#BufferS#" . l:rightSymbol . " "
    endif
  elseif exists('*ale#statusline#Count')
    let l:ale_status = statusline#GetAleStatus()
    if l:ale_status == "OK"
      let l:statusline .= "%#SLLimiter#✓%#CursorStatus# " . l:ale_status . " %#BufferS#" . l:rightSymbol . " "
    else
      let l:statusline .= "%#BufferError# " . l:ale_status . " %#BufferErrorS#" . l:rightSymbol . " "
    endif
  else
    let l:statusline .= "%#BufferS#" . l:rightSymbol . " "
  endif

  " Cursor position
  let l:statusline .= "%#BufferS#" . l:leftSymbol . "%#StatusLine# %-8.(%l,%c%) "

  " Final percentage section com cor do modo
  if a:mode == 'n'
    let l:statusline .= "%#ModeNFGC# %P %#ModeNFGCS#" . l:rightSymbol
  elseif a:mode == 'i'
    let l:statusline .= "%#ModeIFGC# %P %#ModeIFGCS#" . l:rightSymbol
  elseif a:mode == 'R'
    let l:statusline .= "%#ModeRFGC# %P %#ModeRFGCS#" . l:rightSymbol
  elseif a:mode ==# 'v' || a:mode ==# 'V' || a:mode ==# ''
    let l:statusline .= "%#ModeVFGC# %P %#ModeVFGCS#" . l:rightSymbol
  elseif a:mode ==# 'c'
    let l:statusline .= "%#ModeCFGC# %P %#ModeCFGCS#" . l:rightSymbol
  elseif a:mode ==# 't'
    let l:statusline .= "%#ModeTFGC# %P %#ModeTFGCS#" . l:rightSymbol
  else
    let l:statusline .= "%#ModeNFGC# %P %#ModeNFGCS#" . l:rightSymbol
  endif

  return l:statusline
endfunction

" ===================================================================
" HELPER FUNCTIONS
" ===================================================================

" Função de debug para verificar carregamento
function! statusline#debug()
  echom "=== DEBUG STATUSLINE ==="
  echom "statusline#init exists: " . exists('*statusline#init')
  echom "statusline#DetectMode exists: " . exists('*statusline#DetectMode')
  echom "statusline#GetFileType exists: " . exists('*statusline#GetFileType')
  echom "statusline#GetAleStatus exists: " . exists('*statusline#GetAleStatus')
  echom "statusline#GitGutterStatus exists: " . exists('*statusline#GitGutterStatus')
  echom "Current statusline: " . &statusline
  echom "======================="
endfunction

" Função auxiliar para filetype
function! statusline#GetFileType(...)
  if a:0 == 0
    let filetype = &filetype
  else
    let filetype = a:1
  endif

  if filetype == '' || filetype == 'nerdtree'
    return '-'
  else
    return tolower(filetype)
  endif
endfunction

" Função auxiliar para ALE status
function! statusline#GetAleStatus() abort
  if !exists('*ale#statusline#Count')
    return 'N/A'
  endif

  try
    let l:counts = ale#statusline#Count(bufnr(''))
    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors

    if l:counts.total == 0
      return 'OK'
    else
      return printf('%dW %dE', l:all_non_errors, l:all_errors)
    endif
  catch
    return 'N/A'
  endtry
endfunction

" Função auxiliar para GitGutter status
function! statusline#GitGutterStatus()
  if !exists('*GitGutterGetHunkSummary')
    return ''
  endif

  try
    let [a,m,r] = GitGutterGetHunkSummary()
    if a == 0 && m == 0 && r == 0
      return 'clean'
    endif
    return printf('+%d ~%d -%d', a, m, r)
  catch
    return ''
  endtry
endfunction
" ===================================================================
" DOCUMENTAÇÃO DO MÓDULO
" ===================================================================
" Statusline module para Atom One Light com cores OFICIAIS
"
" USO:
" No seu .vimrc, adicione após carregar os plugins:
"   autocmd VimEnter * call statusline#init()
"   set laststatus=2
"   set statusline=%!statusline#DetectMode(mode())
"
" FUNÇÕES DISPONÍVEIS:
" • statusline#init() - Inicializa as cores do statusline
" • statusline#DetectMode(mode) - Constrói o statusline baseado no modo
" • statusline#GetFileType(...) - Retorna o tipo de arquivo formatado
" • statusline#GetAleStatus() - Status do ALE linter
" • statusline#GitGutterStatus() - Status do Git via GitGutter
"
" CORES IMPLEMENTADAS (paleta exata):
" • #fafafa - Background principal
" • #383a42 - Texto padrão (Normal, Operator)
" • #a0a1a7 - Comentários e separadores
" • #a626a4 - Keywords (modo Visual)
" • #50a14f - Strings (modo Insert)
" • #986801 - Numbers/Constants (modo Command)
" • #4078f2 - Functions (modo Normal)
" • #e45649 - Identifiers/Variables (modo Replace, erros)
" • #c18401 - Orange alternativo (modo Terminal)
" • #e5e5e6 - Guias visuais
" • #f0f0f0 - CursorLine background
"
" RECURSOS:
" • Mapeamento semântico de cores por modo
" • Suporte a símbolos powerline (quando disponível)
" • Integração com Git (fugitive + gitgutter)
" • Suporte a linters (ALE + CoC)
" • Indicação de arquivos modificados
" • Fallbacks robustos para plugins ausentes
" • Guard de carregamento para evitar conflitos
"
" DEPENDÊNCIAS OPCIONAIS:
" • vim-fugitive, vim-gitgutter, ALE/CoC, fonte powerline

" vim:set ft=vim et sw=2:
