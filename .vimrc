" https://github.com/kaar/dotfiles/blob/master/.vimrc

" # SETTINGS #
" ### Visual ###
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
" turn col and row position on in bottom right
set ruler " see ruf for formatting
" show command and insert mode
set showmode
" disable automatic folding at all times
set foldmethod=manual
set nofoldenable
" visualize whitespace characters
" Activate by :set list
set listchars=space:*,trail:*,nbsp:*,extends:>,precedes:<,tab:\|>
" visual break lines smarter
set linebreak
" better command-line completion
set wildmenu

" Mode-dependent cursor in vim (Mintty)
" still needed in gh gist edit, not sure why
let &t_ti.="\e[1 q"
let &t_SI.="\e[5 q"
let &t_EI.="\e[1 q"
let &t_te.="\e[0 q"

" ### Search ###
" ignore case for search
set ignorecase
" unless uppercase is used in search string
set smartcase
" highlight and match when typing
set incsearch
" highlight matching search results
set hlsearch
" disable search highlighting with <C-L> (redraw screen)
" stopped working because of vim-tmux-navigator plugin
nnoremap <C-L> :nohl<CR><C-L>

" ### Clipboard (Copy/Paste) ###
set clipboard=unnamedplus

" WSL yank support
let s:clip = 'clip.exe'  " change this path according to your mount point
if executable(s:clip)
    augroup WSLYank
        autocmd!
        autocmd TextYankPost * if v:event.operator ==# 'y' | call system(s:clip, @0) | endif
    augroup END
endif

" ### Text and Formating ###
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
" enough for line numbers + gutter within 80 standard
set textwidth=72
" enable omni-completion, Insert Mode: <C-X><C-O>
set omnifunc=syntaxcomplete#Complete

" ### Files and Backup ###
" auto-reload buffers when files are changed on disk
set autoread
" automatically write files when changing when multiple files open
set autowrite
" more risky, but cleaner
set nobackup
set noswapfile
set nowritebackup
" Don't use Ex mode, use Q for formatting.
" Revert with ":unmap Q".
map Q gq

" ### Spelling ###
" language
set spelllang=en_us
" activate for *.md
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

" # KEYBINDINGS #
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
nnoremap <leader>b :Buffers<CR>
" quote word
nnoremap <Leader>" ciw"<C-r>""<Esc>
vnoremap <Leader>" c"<C-r>""<Esc>

" fzf
nmap // :BLines<CR>
nmap ?? :Rg<CR>
" fucks up b key. Also not using buffers that much
" nmap bu :Buffers<CR>
nmap cc :Commands<CR>
nmap cm :Commits<CR>
nmap <C-P> :Files<CR>
nmap <leader>p :Files<CR>

" function keys
map <F1> :set number!<CR> :set relativenumber!<CR>
" toggle search highlight
nnoremap <F3> :set hlsearch!<CR>
" visulize whitespaces
map <F4> :set list!<CR>
map <F5> :set cursorline!<CR>
map <F7> :set spell!<CR>

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

" completion menu
inoremap <expr> <Esc>      pumvisible() ? "\<C-e>" : "\<Esc>"
inoremap <expr> <CR>       pumvisible() ? "\<C-y>" : "\<CR>"
inoremap <expr> <Down>     pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr> <Up>       pumvisible() ? "\<C-p>" : "\<Up>"

" copy/paste
vnoremap <leader>y "+y
map <leader>p "+p

" *** Emacs-Like in insert mode ***
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

" add timestamp
" nnoremap <F5> "=strftime("%c")<CR>P
" inoremap <F5> <C-R>=strftime("%c")<CR>

" File explorer
" netrw
" nnoremap <C-e> :Vexplore<CR>		" ctrl+e; open netrw explore
" nnoremap <leader> e :Vexplor<CR>	" leader+e; open netr explore


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
" nnoremap <leader>n :NERDTreeFocus<CR>
" nnoremap <C-n> :NERDTreeToggle<CR>
" nnoremap <C-f> :NERDTreeFind<CR>

" Start NERDTree when Vim is started without file arguments.
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif

" Pandoc

" Disable folding
let g:pandoc#modules#disabled = ["folding", "spell"]

" read private vim config
" set rtp^=~/.vimprivate
