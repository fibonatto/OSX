" =============================================================================
" Plugin Manager — vim-plug
" =============================================================================
 
call plug#begin('~/.vim/plugged')
 
" =============================================================================
" Core Functionality
" =============================================================================
 
Plug 'tpope/vim-sensible'
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'chrisbra/Colorizer'
 
" =============================================================================
" LSP + Autocomplete (replaces COC + ALE)
" — clangd for C/C++, tsserver for JS/JSX via vim-lsp-settings
" =============================================================================
 
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
 
" =============================================================================
" Code Navigation
" — gutentags auto-generates ctags; tagbar shows symbol sidebar
" =============================================================================
 
Plug 'ludovicchabant/vim-gutentags'
Plug 'majutsushi/tagbar'
 
" =============================================================================
" Build & Debug
" — dispatch runs make/cmake async into QuickFix without blocking
" — termdebug is built-in (Vim 8+); vimspector for full DAP if needed
" =============================================================================
 
Plug 'tpope/vim-dispatch'
" Plug 'puremourning/vimspector'    " uncomment for full DAP / CodeLLDB support
 
" =============================================================================
" Editing
" =============================================================================
 
Plug 'jiangmiao/auto-pairs'
Plug 'preservim/nerdcommenter'
Plug 'junegunn/vim-easy-align'
Plug 'Yggdroot/indentLine'
Plug 'hrsh7th/vim-vsnip'           " snippets (C header guards, main, structs…)
Plug 'hrsh7th/vim-vsnip-integ'
 
" =============================================================================
" Git
" =============================================================================
 
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
 
" =============================================================================
" Language Support — C / C++
" =============================================================================
 
Plug 'bfrg/vim-c-cpp-modern'       " enhanced C/C++ syntax highlighting
 
" =============================================================================
" Language Support — Assembly
" =============================================================================
 
Plug 'maxbane/vim-asm_ca65'
 
" =============================================================================
" Language Support — JavaScript (minimal, usable)
" — pangloss gives solid JS syntax; jsx-pretty covers React files
" — tsserver is handled automatically by vim-lsp-settings (no extra plugin)
" =============================================================================
 
Plug 'pangloss/vim-javascript'
Plug 'MaxMEllon/vim-jsx-pretty'
 
" =============================================================================
" Colorscheme & Visual
" =============================================================================
 
Plug 'SergioBonatto/One-Half-Matte'
Plug 'segeljakt/vim-silicon'
Plug 'vim-scripts/Microchip-Linker-Script-syntax-file' 
" =============================================================================
" Custom Plugins (SergioBonatto)
" =============================================================================
 
Plug 'SergioBonatto/VimFileType'
Plug 'SergioBonatto/Agda-vim'
Plug 'SergioBonatto/bend-vim'
Plug 'SergioBonatto/vim-run-code'
Plug 'SergioBonatto/todo-vim'
Plug 'SergioBonatto/vim-kind'
 
" =============================================================================
" Utilities
" =============================================================================
 
Plug 'sakshamgupta05/vim-todo-highlight'
Plug 'wakatime/vim-wakatime'
" Plug 'vimsence/vimsence'
Plug 'Stoozy/vimcord'

" =============================================================================
" Basal - Digital Brain
" =============================================================================
Plug 'SergioBonatto/basal.vim'
" Plug 'SergioBonatto/felca'
 
call plug#end()
