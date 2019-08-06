"source ~/.vimrc"
" Notes
" ======== 
" :so %, Reload vim rc 
" Mode-dependent cursor in vim (Mintty)
let &t_ti.="\e[1 q"
let &t_SI.="\e[5 q"
let &t_EI.="\e[1 q"
let &t_te.="\e[0 q"

" Settings
syntax on
" load indent file for the current filetype
filetype indent on
filetype plugin indent on
let mapleader = " "
set hlsearch                    " highlight the search
set ignorecase
set smartcase
set incsearch
set clipboard=unnamed
set autoindent
set number
set relativenumber
set synmaxcol=1200              " Syntax coloring lines that are too long just slows down the world
set nocompatible                " Turn off vi compatibility
set smartindent
set autoindent
set tabstop=4                   " show existing tab with 4 spaces width
set shiftwidth=4                " when indenting with '>', use 4 spaces width
set noexpandtab                 " On pressing tab, insert tab
set nobackup                    " don't want no backup files
set nowritebackup               " don't make a backup before overwriting a file
set noswapfile                  " no swap files
set autoread                    " Auto-reload buffers when files are changed on disk

" Mappings
imap jj <Esc>
nnoremap <leader>w :w<cr>
nnoremap <leader>- :split<cr>
nnoremap <leader>/ :vsplit<cr>
nnoremap <leader>h <c-w><c-h>
nnoremap <leader>j <c-w><c-j>
nnoremap <leader>k <c-w><c-k>
nnoremap <leader>l <c-w><c-l>
nnoremap <leader>q <c-w>q
nnoremap <leader>a <esc>ggVG<CR> " Select all text in file

"Move lines"
nnoremap <C-j> <Esc> :m .+1<CR>
nnoremap <C-k> <Esc> :m .-2<CR>
inoremap <C-j> <Esc> :m .+1<CR>i
inoremap <C-k> <Esc> :m .-2<CR>i

" Visual studio Specific mappings
nnoremap <leader>n :vsc resharper.resharper_gotofile<cr>
nnoremap <leader>e :vsc resharper.resharper_gotorecentfiles<cr>
nnoremap <leader><S-n> :vsc resharper.resharper_gotosymbol<cr>
nnoremap <leader>f :vsc resharper.resharper_reformatcode<cr>

" Disable Arrow keys in Escape mode
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>

" Disable Arrow keys in Insert mode
imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>

