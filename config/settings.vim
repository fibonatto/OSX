" =============================================================================
" Vim Configuration for C Development
" =============================================================================

" =============================================================================
" Core
" =============================================================================

set nocompatible
syntax enable
filetype plugin indent on

set encoding=UTF-8
set fileencoding=UTF-8

" =============================================================================
" Performance
" =============================================================================

set lazyredraw
set ttyfast
set regexpengine=0
set synmaxcol=200
set redrawtime=10000

set updatetime=300
set timeoutlen=500

" =============================================================================
" File Handling
" =============================================================================

set autoread
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * checktime

set hidden
set history=1000
set undolevels=1000

set noswapfile
set nobackup

set undofile
set undodir=~/.vim/undo

" =============================================================================
" Navigation and Completion
" =============================================================================

set path+=**
set wildmenu
set wildmode=list:longest,full
set wildignore+=*/node_modules/*,*.o,*.pyc,*.DS_Store,*/.git/*,*/dist/*,*/build/*

set tags=./tags;,tags;

" =============================================================================
" Search
" =============================================================================

set ignorecase
set smartcase
set hlsearch
set incsearch

set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case

" =============================================================================
" Editing Behavior
" =============================================================================

set backspace=indent,eol,start
set formatoptions+=croqltj

set clipboard=unnamed,unnamedplus
set mouse=a

" =============================================================================
" Indentation
" =============================================================================

set tabstop=4
set shiftwidth=4
set softtabstop=4
set noexpandtab

" =============================================================================
" Visual
" =============================================================================

set number
set cursorline
set showmatch

set colorcolumn=90
set scrolloff=8
set sidescrolloff=8

set signcolumn=yes

set linebreak
set wrap

set nolist
set ambiwidth=single
set display=lastline
set fillchars=vert:\│,fold:-

if has("termguicolors")
  set termguicolors
endif

" =============================================================================
" Splits
" =============================================================================

set splitright
set splitbelow
set diffopt+=vertical

" =============================================================================
" Status Line
" =============================================================================

set noshowmode
set noruler
set laststatus=2

" =============================================================================
" Security
" =============================================================================

set secure
set cryptmethod=blowfish2

" =============================================================================
" Quickfix / Build
" =============================================================================

set makeprg=make

set errorformat=
set errorformat+=%f:%l:%c:\ %t%*[^:]:\ %m
set errorformat+=%f:%l:\ %t%*[^:]:\ %m
set errorformat+=%f:%l:%c:\ %m
set errorformat+=%f:%l:\ %m

" =============================================================================
" C / Header Files
" =============================================================================

autocmd FileType c,h setlocal cindent
autocmd FileType c,h setlocal tabstop=4 shiftwidth=4 softtabstop=4 noexpandtab
autocmd FileType c,h setlocal textwidth=90
autocmd FileType c,h setlocal formatoptions-=cro

" =============================================================================
" Cscope
" =============================================================================

if has("cscope")
  set cscopequickfix=s-,c-,d-,i-,t-,e-
  set cscopeverbose
  silent! cs add cscope.out
endif

" =============================================================================
" agda
" =============================================================================

autocmd FileType agda setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
"
" " =============================================================================
" " digital brain
" " =============================================================================
" " Digital Brain Path Logic
" let $DB = '/Users/bonatto/DB'
"
" " Allow 'gf' to find files recursively in the DB folders
" set path+=$DB/**
"
" " Allow 'gf' to open files without typing .md
" set suffixesadd+=.md
