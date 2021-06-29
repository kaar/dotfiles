"source ~/.vimrc"
" Notes
" ======== 
" :so %, Reload vim rc 

" === SETTINGS ===
" === Visual Settings ===
" syntax highlight
syntax on
" color schema
colorscheme ron
" load indent file for the current filetype
filetype indent on
filetype plugin indent on
" show line numbers
set number
" set relativenumber
" disable relative line numbers, remove no to sample it
set norelativenumber
" syntax coloring lines that are too long just slows down the world
set synmaxcol=1200
" let me see more
set scrolloff=10

" === Search ===
" ignore case for search
set ignorecase
" highlight and match when typing
set incsearch
" highlight matching search results
set hlsearch
" <F3> toggle search highlight
nnoremap <F3> :set hlsearch!<CR>

" === Clipboard (Copy/Paste) ===
set smartcase
set clipboard=unnamedplus

" WSL yank support
let s:clip = 'clip.exe'  " change this path according to your mount point
if executable(s:clip)
    augroup WSLYank
        autocmd!
        autocmd TextYankPost * if v:event.operator ==# 'y' | call system(s:clip, @0) | endif
    augroup END
endif


" === Text and Formating ===
" automatically indent new lines
set autoindent
" tab length
set tabstop=2
set softtabstop=2
set shiftwidth=2
set smartindent
set smarttab

" replace tabs with spaces automatically
set expandtab

" stop vim from silently fucking with files that it shouldn't
set nofixendofline

" === Files and Backup ===
" auto-reload buffers when files are changed on disk
set autoread

" tell vim to keep a backup file
set backup

" tell vim where to put its backup files
set backupdir=/tmp

" tell vim where to put swap files
set dir=/tmp

" === Spelling ===
set spelllang=en_us
"set spellfile=TOOD
autocmd BufRead,BufNewFile *.md setlocal spell

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

" === Keybindings ===
" space; leader key
let mapleader = " "
" remap escape
imap jj <Esc>
" split
nnoremap <leader>- :split<cr>
" split vertical
nnoremap <leader>/ :vsplit<cr>
" quit
nnoremap <leader>q <c-w>q
" write
nnoremap <leader>w :w<cr>
" select all
nnoremap <leader>a <esc>ggVG<CR>
" buffers
nnoremap <leader>b :buffers<CR>:buffer<Space>

" movement panes
nnoremap <leader>h <c-w><c-h>
nnoremap <leader>j <c-w><c-j>
nnoremap <leader>k <c-w><c-k>
nnoremap <leader>l <c-w><c-l>

" move lines (Ctrl+[j,k,l,m])
nnoremap <C-j> <Esc> :m .+1<CR>     " ctrl+j; move line down
nnoremap <C-k> <Esc> :m .-2<CR>     " ctrl+k; move line up
inoremap <C-j> <Esc> :m .+1<CR>i    " ctrl+j; move line down
inoremap <C-k> <Esc> :m .-2<CR>i    " ctrl+k; move line up

" copy/paste
vnoremap <leader>y "+y
map <leader>p "+p

" Emacs-Like in insert mode
" Go to beginning of the line [Normal Mode && Insert Mode]
map <C-a> <ESC>^
imap <C-a> <ESC>I
" Go to end of line [Normal Mode && Insert Mode]
map <C-e> <ESC>$
imap <C-e> <ESC>A
" Backward a word [Insert Mode]
inoremap <M-f> <ESC><Space>Wi
" Forward a word [Insert Mode]
inoremap <M-b> <Esc>Bi
" Delete a word (backward) [Insert Mode]
inoremap <M-d> <ESC>cW

" maps gX to use xdg-open with a relative filepath under your cursor
nnoremap gX :silent :execute
  \ "!xdg-open" expand('%:p:h') . "/" . expand("<cfile>") " &"<cr>

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


