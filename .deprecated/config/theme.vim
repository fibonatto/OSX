" =============================================================================
" Theme Configuration
" =============================================================================

" True color support
if (empty($TMUX))
  if (has("nvim"))
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  if (has("termguicolors"))
    set termguicolors
  endif
endif

" Font configuration
if has('gui_running')
  if has('gui_macvim')
    set guifont=Fira\ Code:h16
  endif
endif

" Terminal font optimizations
if !has('gui_running')
  set t_ZH=
  set t_ZR=
  set conceallevel=0
  set concealcursor=""
endif

" Theme settings

if has("termguicolors")
    " Configuração específica para Vim rodando no iTerm2/Terminal
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    set termguicolors
endif

set background=light
colorscheme atomonelight_matte

" Custom highlights
highlight Comment cterm=italic

" LSP Diagnostics - Subtle messages, striking icons
highlight link LspErrorVirtualText Comment
highlight link LspWarningVirtualText Comment
highlight link LspInformationVirtualText Comment
highlight link LspHintVirtualText Comment

highlight LspErrorText guifg=#D70000 gui=bold
highlight LspWarningText guifg=#D78700 gui=bold
