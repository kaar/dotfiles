"source ~/.vimrc"
let mapleader = " "
set hlsearch
set ignorecase
set smartcase
set incsearch
set clipboard=unnamed
set autoindent
set number
set relativenumber

imap jj <Esc>
nnoremap <leader>w :w<cr>
nnoremap <leader>- :split<cr>
nnoremap <leader>/ :vsplit<cr>
nnoremap <leader>h <c-w><c-h>
nnoremap <leader>j <c-w><c-j>
nnoremap <leader>k <c-w><c-k>
nnoremap <leader>l <c-w><c-l>
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
