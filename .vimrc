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
colorscheme ron
" load indent file for the current filetype
filetype indent on
filetype plugin indent on

" highlight the search
set hlsearch
set ignorecase

set smartcase
set incsearch
set clipboard=unnamedplus

" WSL yank support
let s:clip = 'clip.exe'  " change this path according to your mount point
if executable(s:clip)
    augroup WSLYank
        autocmd!
        autocmd TextYankPost * if v:event.operator ==# 'y' | call system(s:clip, @0) | endif
    augroup END
endif

set number
" set relativenumber

" disable relative line numbers, remove no to sample it
set norelativenumber

" syntax coloring lines that are too long just slows down the world
set synmaxcol=1200

" automatically indent new lines
set autoindent

set tabstop=2
set softtabstop=2
set shiftwidth=2
set smartindent
set smarttab

" replace tabs with spaces automatically
set expandtab

" stop vim from silently fucking with files that it shouldn't
set nofixendofline

" auto-reload buffers when files are changed on disk
set autoread

" tell vim to keep a backup file
set backup

" tell vim where to put its backup files
set backupdir=~/.tmp/vim

" tell vim where to put swap files
set dir=~/.tmp/vim

" stop vim from silently fucking with files that it shouldn't
set nofixendofline

" let me see more
set scrolloff=10

" netrw
" let g:netrw_liststyle = 3		" change directory view
" let g:netrw_banner = 0			" remove banner
" let g:netrw_winsize = 20		" explorer width in percent
" let g:netrw_browse_split = 2    " open file; 1 = h-split, 2=v-split, 3 = new tab, 4 = prev window
" let g:netrw_altv = 1			" ???
"augroup ProjectDrawer
"	autocmd!
"    autocmd VimEnter * :Vexplore
"augroup END


" FZF
" add installed path to &runtimepat
set rtp+=~/.bin/fzf

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
nnoremap <leader>a <esc>ggVG<CR>    " select all

" buffers
nnoremap <leader>b :buffers<CR>:buffer<Space>

" copy/paste
vnoremap <leader>y "+y
map <leader>p "+p

" tabs
" A tab page is a collection of windows and does not represent open files
" Use tabs for different projects almost like terminal tabs
" nnoremap <C-t> :tabnew<CR>      " new tab
" nnoremap td    :tabclose<CR>    " close tab
" nnoremap th    :tabnext<CR>     " next tab
" nnoremap tl    :tabprev<CR>     " prev tabjh

" add timestamp
" nnoremap <F5> "=strftime("%c")<CR>P
" inoremap <F5> <C-R>=strftime("%c")<CR>

" File explorer
" netrw
" nnoremap <C-e> :Vexplore<CR>		" ctrl+e; open netrw explore
" nnoremap <leader> e :Vexplor<CR>	" leader+e; open netr explore

" move lines
nnoremap <C-j> <Esc> :m .+1<CR>     " ctrl+j; move line down
nnoremap <C-k> <Esc> :m .-2<CR>     " ctrl+k; move line up
inoremap <C-j> <Esc> :m .+1<CR>i    " ctrl+j; move line down
inoremap <C-k> <Esc> :m .-2<CR>i    " ctrl+k; move line up


" fzf
nmap <C-P> :FZF<CR>

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

" Commenting blocks of code.
" ,cc - commment
" ,cu - uncomment

augroup commenting_blocks_of_code
  autocmd!
  autocmd FileType c,cpp,java,scala let b:comment_leader = '// '
  autocmd FileType sh,ruby,python   let b:comment_leader = '# '
  autocmd FileType conf,fstab       let b:comment_leader = '# '
  autocmd FileType tex              let b:comment_leader = '% '
  autocmd FileType mail             let b:comment_leader = '> '
  autocmd FileType vim              let b:comment_leader = '" '
augroup END
noremap <silent> ,cc :<C-B>silent <C-E>s/^/<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>:nohlsearch<CR>
noremap <silent> ,cu :<C-B>silent <C-E>s/^\V<C-R>=escape(b:comment_leader,'\/')<CR>//e<CR>:nohlsearch<CR>

command! Config execute ":e $HOME/.vimrc"
augroup standard_group
  " Reload file on focus/enter. This seems to break in Windows.
  " https://stackoverflow.com/a/20418591
  " Still have a bug where last search highlight on :Reload
  if !has("win32")
    autocmd FocusGained,BufEnter * :silent! !
  endif

  command! Reload execute "source ~/.vimrc"
augroup END


" NERDTree
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

" Start NERDTree when Vim is started without file arguments.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif

" Pandoc

" Disable folding
let g:pandoc#modules#disabled = ["folding", "spell"]
