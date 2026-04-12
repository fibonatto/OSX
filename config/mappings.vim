" =============================================================================
" Key Mappings
" =============================================================================

let mapleader = ","

" =============================================================================
" Movement
" =============================================================================

nnoremap <S-j> 6gj
nnoremap <S-k> 6gk
vnoremap <S-j> 6gj
vnoremap <S-k> 6gk

nnoremap <S-h> b
nnoremap <S-l> e
vnoremap <S-h> b
vnoremap <S-l> e

" =============================================================================
" Window Navigation
" =============================================================================

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

nnoremap <Left> <C-w><
nnoremap <Right> <C-w>>
nnoremap <Up> <C-w>-
nnoremap <Down> <C-w>+

" =============================================================================
" Editing
" =============================================================================

vnoremap < <gv
vnoremap > >gv

nnoremap U <C-r>
vnoremap <S-s> :sort<CR>

nnoremap m %
nnoremap ( <<
nnoremap ) >>

" =============================================================================
" File / Search
" =============================================================================

nnoremap <C-p> :Files<CR>
nnoremap <Leader>b :Buffers<CR>
nnoremap <Leader>rg :Rg<CR>

" =============================================================================
" NERDTree
" =============================================================================

nnoremap <C-a> :NERDTreeToggle<CR>

" =============================================================================
" Commenting
" =============================================================================

nnoremap ! <Plug>NERDCommenterToggle
vnoremap ! <Plug>NERDCommenterToggle

nnoremap <Leader>/ <Plug>NERDCommenterToggle
vnoremap <Leader>/ <Plug>NERDCommenterToggle

nnoremap <Leader>c <Plug>NERDCommenterToggle
vnoremap <Leader>c <Plug>NERDCommenterToggle

nnoremap <Leader>cm <Plug>NERDCommenterMinimal
vnoremap <Leader>cm <Plug>NERDCommenterMinimal

nnoremap <Leader>cs <Plug>NERDCommenterSexy
vnoremap <Leader>cs <Plug>NERDCommenterSexy

nnoremap <Leader>cb <Plug>NERDCommenterAlternate
vnoremap <Leader>cb <Plug>NERDCommenterAlternate

" =============================================================================
" Build / Quickfix
" =============================================================================
nnoremap <F5>  :Make<CR>
nnoremap <F6>  :copen<CR>
nnoremap <F7>  :cnext<CR>
nnoremap <F8>  :TagbarToggle<CR>
nnoremap <F9>  :!./main<CR>
nnoremap <F10> :cprev<CR>

" =============================================================================
" Run Binary
" =============================================================================

nnoremap <F9> :!./main<CR>

" =============================================================================
" C Navigation
" =============================================================================

nnoremap <Leader>d <C-]>
nnoremap <Leader>u <C-t>

nnoremap <Leader>cc :cs find c <C-R><C-W><CR>
nnoremap <Leader>cg :cs find g <C-R><C-W><CR>
nnoremap <Leader>ci :cs find i <C-R><C-W><CR>
nnoremap <Leader>ct :cs find t <C-R><C-W><CR>

" =============================================================================
" Custom Commands
" =============================================================================

nnoremap <Leader>k :!kindcoder<CR>
nnoremap <Leader>t :!ts-deps<CR>
nnoremap <Leader>h :!holefill % %<CR>
nnoremap <Leader>f :!refactor %<CR>
nnoremap <Leader>s :!chatsh<CR>
nnoremap <Leader>a :!agda2kind %<CR>

" =============================================================================
" Silicon
" =============================================================================

xnoremap P :Silicon<CR>
xnoremap <Leader>p :Silicon!<CR>

" =============================================================================
" LSP
" =============================================================================

nmap <silent> <leader>gd <plug>(lsp-definition)
nmap <silent> <leader>gr <plug>(lsp-references)
nmap <silent> <leader>gi <plug>(lsp-implementation)
nmap <silent> <leader>rn <plug>(lsp-rename)
nmap <silent> <leader>K  <plug>(lsp-hover)
nmap <silent> [g         <plug>(lsp-previous-diagnostic)
nmap <silent> ]g         <plug>(lsp-next-diagnostic)
nmap <silent> <leader>ca <plug>(lsp-code-action)

" =============================================================================
" Autocomplete (asyncomplete)
" =============================================================================

inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <CR>    pumvisible() ? asyncomplete#close_popup() : "\<CR>"

" =============================================================================
" Snippets (vim-vsnip)
" =============================================================================

imap <expr> <C-l> vsnip#expandable() ? '<Plug>(vsnip-expand)'    : '<C-l>'
smap <expr> <C-l> vsnip#expandable() ? '<Plug>(vsnip-expand)'    : '<C-l>'
imap <expr> <C-j> vsnip#jumpable(1)  ? '<Plug>(vsnip-jump-next)' : '<C-j>'
smap <expr> <C-j> vsnip#jumpable(1)  ? '<Plug>(vsnip-jump-next)' : '<C-j>'
imap <expr> <C-k> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<C-k>'
smap <expr> <C-k> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<C-k>'


" " =============================================================================
" " Digital Brain
" " ================================================
" " Search for the tag under cursor within the DB
" nnoremap F :call DBSearchEngine(expand('<cWORD>'), 0)<CR>
"
" " Quick jump to the brain index
" nnoremap <leader>db :e $DB/index.md<CR>
"
" " Quick jump to TODO list
" nnoremap <leader>do :e $DB/TODO.md<CR>
"
" nnoremap <leader>dd :execute 'e ' . $DB . '/5_Daily/' . strftime('%Y-%m-%d') . '.md'<CR>
"
