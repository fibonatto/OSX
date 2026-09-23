" =============================================================================
" Vimrc Configuration
" =============================================================================

" Source all configuration files
source ~/.vim/config/plugins.vim
source ~/.vim/config/settings.vim
source ~/.vim/config/mappings.vim
source ~/.vim/config/theme.vim
source ~/.vim/config/plugin-config.vim
source ~/.vim/config/statusline.vim

" =============================================================================
" Language-specific settings (keep minimal)
" =============================================================================

" OCaml (make this more flexible)
if isdirectory(expand('~/.opam'))
  " Find the most recent OCaml version automatically
  let opam_switch = substitute(system('opam switch show 2>/dev/null'), '\n', '', 'g')
  if !empty(opam_switch) && opam_switch !~# 'command not found'
    execute 'set rtp+=~/.opam/'.opam_switch.'/share/ocp-index/vim'
  endif
endif

" =============================================================================
" Optional: Create undo directory if it doesn't exist
" =============================================================================
if !isdirectory($HOME.'/.vim/undo')
  call mkdir($HOME.'/.vim/undo', 'p')
endif
