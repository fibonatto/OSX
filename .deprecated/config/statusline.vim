" =============================================================================
" Statusline Configuration
" =============================================================================

" Simple, effective statusline
function! StatuslineMode()
  let l:mode = mode()
  if l:mode ==# 'n'
    return 'NORMAL'
  elseif l:mode ==# 'i'
    return 'INSERT'
  elseif l:mode ==# 'v'
    return 'VISUAL'
  elseif l:mode ==# 'V'
    return 'V-LINE'
  elseif l:mode ==# "\<C-v>"
    return 'V-BLOCK'
  elseif l:mode ==# 'R'
    return 'REPLACE'
  else
    return 'OTHER'
  endif
endfunction

function! StatuslineGit()
  if exists('*fugitive#head')
    let branch = fugitive#head()
    return branch !=# '' ? ' '.branch.' ' : ''
  endif
  return ''
endfunction

function! StatuslineLSP() abort
  if !exists('*lsp#get_buffer_diagnostics_counts')
    return ''
  endif

  let l:counts = lsp#get_buffer_diagnostics_counts()
  let l:errors = get(l:counts, 'error', 0)
  let l:warnings = get(l:counts, 'warning', 0)

  let l:status = ''
  if l:errors > 0
    let l:status .= ' E:' . l:errors
  endif
  if l:warnings > 0
    let l:status .= ' W:' . l:warnings
  endif

  return empty(l:status) ? '' : l:status . ' '
endfunction

" Build statusline
set statusline=
set statusline+=%#DiffAdd#%{StatuslineMode()}%*
set statusline+=%#LineNr#%{StatuslineGit()}%*
set statusline+=\ %f
set statusline+=%m%r%h%w
set statusline+=%#WarningMsg#%{StatuslineLSP()}%*
set statusline+=%=
set statusline+=\ %y
set statusline+=\ [%l,%c]
set statusline+=\ %p%%
