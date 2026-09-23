" =============================================================================
" Plugin Manager — vim-plug
" =============================================================================

call plug#begin('~/.vim/plugged')

" =============================================================================
" Core Workflow: Sergio Bonatto (Digital Brain & Custom)
" =============================================================================
Plug 'SergioBonatto/One-Half-Matte'
Plug 'SergioBonatto/basal.vim'
Plug 'SergioBonatto/VimFileType'
Plug 'SergioBonatto/Agda-vim'
Plug 'SergioBonatto/bend-vim'
Plug 'SergioBonatto/vim-run-code'
Plug 'SergioBonatto/todo-vim'
Plug 'SergioBonatto/vim-kind'

" =============================================================================
" Infrastructure: Basal & Essential UI
" =============================================================================
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons'

" =============================================================================
" Intelligence: LSP & Snippets (C / WASM / JS)
" =============================================================================
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'

" =============================================================================
" Performance: Lazy Loaded Support Plugins
" =============================================================================
Plug 'tpope/vim-dispatch', { 'on': ['Dispatch', 'Make'] }
Plug 'tpope/vim-fugitive', { 'on': 'G' }
Plug 'majutsushi/tagbar', { 'on': 'TagbarToggle' }
Plug 'segeljakt/vim-silicon', { 'on': 'Silicon' }
Plug 'chrisbra/Colorizer', { 'on': 'ColorHighlight' }
Plug 'junegunn/vim-easy-align', { 'on': '<Plug>(EasyAlign)' }

" Language Specific (Sob demanda)
Plug 'bfrg/vim-c-cpp-modern', { 'for': ['c', 'cpp'] }
Plug 'maxbane/vim-asm_ca65', { 'for': 'asm' }
Plug 'pangloss/vim-javascript', { 'for': ['javascript', 'javascriptreact'] }
Plug 'MaxMEllon/vim-jsx-pretty', { 'for': ['javascript', 'javascriptreact'] }
Plug 'ludovicchabant/vim-gutentags', { 'for': ['c', 'cpp'] }

" =============================================================================
" Utilities & Maintenance
" =============================================================================
Plug 'jiangmiao/auto-pairs'
Plug 'preservim/nerdcommenter'
Plug 'Yggdroot/indentLine'
Plug 'airblade/vim-gitgutter'
Plug 'sakshamgupta05/vim-todo-highlight'
Plug 'wakatime/vim-wakatime'
Plug 'vim-scripts/Microchip-Linker-Script-syntax-file', { 'for': 'ld' }

call plug#end()
