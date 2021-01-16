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
set hlsearch                    " highlight the search
set ignorecase
set smartcase
set incsearch
set clipboard=unnamedplus
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

" netrw
let g:netrw_liststyle = 3		" change directory view
let g:netrw_banner = 0			" remove banner
let g:netrw_winsize = 20		" explorer width in percent
let g:netrw_browse_split = 2    " open file; 1 = h-split, 2=v-split, 3 = new tab, 4 = prev window
let g:netrw_altv = 1			" ???
"augroup ProjectDrawer
"	autocmd!
"    autocmd VimEnter * :Vexplore
"augroup END


" mappings
let mapleader = " "					" space; leader key
imap jj <Esc>						" remap escape
nnoremap <leader>w :w<cr>			" file write
nnoremap <leader>- :split<cr>		" split
nnoremap <leader>/ :vsplit<cr>		" split vertical

" movement
nnoremap <leader>h <c-w><c-h>
nnoremap <leader>j <c-w><c-j>
nnoremap <leader>k <c-w><c-k>
nnoremap <leader>l <c-w><c-l>

nnoremap <leader>q <c-w>q			" quit
nnoremap <leader>a <esc>ggVG<CR>    " Select all text in file

" netrw
nnoremap <C-e> :Vexplore<CR>		" ctrl+e; open netrw explore
nnoremap <leader> e :Vexplor<CR>	" leader+e; open netr explore

" tabs
nnoremap th  :tabfirst<CR>
nnoremap tk  :tabnext<CR>
nnoremap tj  :tabprev<CR>
nnoremap tl  :tablast<CR>
nnoremap tt  :tabedit<Space>
nnoremap tn  :tabnext<Space>
nnoremap tm  :tabm<Space>
nnoremap td  :tabclose<CR>
" Alternatively use
nnoremap th :tabnext<CR>			" th; next tab
nnoremap tl :tabprev<CR>			" tl; prev tabjh
nnoremap <C-t>     :tabnew<CR>		" ctrl+t; new tab
" "nnoremap tn :tabnew<CR>

inoremap <C-S-tab> <Esc>:tabprevious<CR>i
inoremap <C-tab>   <Esc>:tabnext<CR>i
inoremap <C-t>     <Esc>:tabnew<CR>

" add timestamp
nnoremap <F5> "=strftime("%c")<CR>P
inoremap <F5> <C-R>=strftime("%c")<CR>

" move lines
nnoremap <C-j> <Esc> :m .+1<CR>     " ctrl+j; move line down
nnoremap <C-k> <Esc> :m .-2<CR>     " ctrl+k; move line up

" insert-mode mappings
inoremap <C-j> <Esc> :m .+1<CR>i    " ctrl+j; move line down
inoremap <C-k> <Esc> :m .-2<CR>i    " ctrl+k; move line up

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

