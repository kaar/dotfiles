" https://github.com/kaar/dotfiles/blob/master/.vimrc

" # SETTINGS #
" ### Visual ###
syntax on               " syntax highlight
colorscheme ron         " color schema:
set background=dark

filetype indent on
filetype plugin indent on
set number              " show line numbers
set norelativenumber    " disable relative line numbers, remove no to sample it
set synmaxcol=1200      " syntax coloring lines that are too long just slows down the world
set scrolloff=10        " let me see more
set ruler               " see ruf for formatting
set showmode            " show command and insert mode
set foldmethod=manual   " manual folding
set nofoldenable        " disable automatic folding at all times
set linebreak           " visual break lines smarter
set wildmenu            " better command-line completion
set cursorline          " show line cursor
set relativenumber

" visualize whitespace characters
" Activate <F4> (:set list)
set listchars=space:*,trail:*,nbsp:*,extends:>,precedes:<,tab:\|>,eol:¬

" Mode-dependent cursor in vim (Mintty)
" still needed in gh gist edit, not sure why
" don't need it as long as i use xterm-256color
" well well...still needed to not keep insert mode in block mode
" I most be missing some setting
let &t_ti.="\e[1 q"
let &t_SI.="\e[5 q"
let &t_EI.="\e[1 q"
let &t_te.="\e[0 q"

" ### Search ###
set ignorecase          " ignore case for search
set smartcase           " unless uppercase is used in search string
set incsearch           " highlight and match when typing
set hlsearch            " highlight matching search results

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
set autoindent          " automatically indent new lines
set tabstop=2           " tab length
set softtabstop=2       " number of spaces in tab when editing
set shiftwidth=2        " number of spaces when shift ident
set smartindent         " be smart with indent
set smarttab            " be smart with tab
set expandtab           " replace tabs with spaces automatically
set nofixendofline      " stop vim from silently fucking with files that it shouldn't
set textwidth=72        " enough for line numbers + gutter within 80 standard
set nowrap              " no wrapping of text
set omnifunc=syntaxcomplete#Complete    " enable omni-completion, Insert Mode: <C-X><C-O>

" ### Files and Backup ###
set autoread            " auto-reload buffers when files are changed on disk
set autowrite           " automatically write files when changing when multiple files open
set nobackup            " more risky, but cleaner
set noswapfile          " noswapfile
set nowritebackup       " write without backup

" avoid most of the 'Hit Enter ...' messages
set shortmess=aoOtTI

" Disable Ex mode
map Q <Nop>

" ### Spelling ###
set spelllang=en_us
" activate for *.md
" autocmd BufRead,BufNewFile *.md setlocal spell

" start at last place you were editing
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

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
" close buffer
nnoremap <leader>c :bd<cr>
" write
nnoremap <leader>w :w<cr>
" select all
nnoremap <leader>a <esc>ggVG<CR>
" buffers
nnoremap <leader>b :Buffers<CR>

" quick pair word and selection
nnoremap <leader>" ciw"<C-r>""<Esc>
vnoremap <leader>" c"<C-r>""<Esc>
nnoremap <leader>' ciw'<C-r>"'<Esc>
vnoremap <leader>' c'<C-r>"'<Esc>
nnoremap <leader>( ciw(<C-r>")<Esc>
vnoremap <leader>( c(<C-r>")<Esc>
nnoremap <leader>[ ciw[<C-r>"]<Esc>
vnoremap <leader>[ c[<C-r>"]<Esc>
nnoremap <leader>{ ciw{<C-r>"}<Esc>
vnoremap <leader>{ c{<C-r>"}<Esc>
nnoremap <leader>` ciw`<C-r>"`<Esc>
vnoremap <leader>` c`<C-r>"`<Esc>

" check file in shellcheck:
map <leader>s :!clear && shellcheck -x %<CR>
" format file
nmap <leader>ff ggVG=

" fzf
nmap // :BLines<CR>
nmap ?? :Rg<CR>
nmap cc :Commands<CR>
nmap cm :Commits<CR>
nmap <C-P> :Files<CR>

" function keys
map <F1> :set number!<CR> :set relativenumber!<CR>
map <F3> :set hlsearch!<CR>
map <F4> :set list!<CR>
map <F5> :set cursorline!<CR>
map <F7> :set spell!<CR>

" move lines (Ctrl+[j,k,l,m])
inoremap <C-j> <Esc> :m .+1<CR>==i
inoremap <C-k> <Esc> :m .-2<CR>==i

" collides with vim-tmux-navigator
"nnoremap <C-j> <Esc> :m .+1<CR>==
"nnoremap <C-k> <Esc> :m .-2<CR>==

" completion menu
inoremap <expr> <Esc>      pumvisible() ? "\<C-e>" : "\<Esc>"
inoremap <expr> <CR>       pumvisible() ? "\<C-y>" : "\<CR>"
inoremap <expr> <Down>     pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr> <Up>       pumvisible() ? "\<C-p>" : "\<Up>"

" copy/paste
" make Y consitent with D and C (yank til end)
map Y y$

" keep things center
" n - next
" N - previews
" zz - center
" zv - open folds
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJ`z


nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>Y gg"+yG
vnoremap <leader>p "_dP

" jump buffers
" nmap J :bnext<CR>
" nmap K :bprev<CR>

" line break
nmap <C-CR> m'a<CR><Esc>`'
" nmap K m'a<CR><Esc>`'

" undo break points
" inoremap , ,<c-g>u
" inoremap . .<c-g>u
" inoremap ! !<c-g>u
" inoremap ? ?<c-g>u

" release my pinky
nnoremap ; :
" swap them around
" nnoremap : ;

" *** Emacs-Like in insert mode ***
" Go to beginning of the line [Normal Mode && Insert Mode]
map <C-a> <ESC>^
imap <C-a> <ESC>I
" Go to end of line [Normal Mode && Insert Mode]
map <C-e> <ESC>$
imap <C-e> <ESC>A
" Backward a word [Insert Mode]
inoremap <M-b> <Esc>Bi
" Forward a word [Insert Mode]
inoremap <M-f> <ESC><Space>Wi
" Delete a word (backward) [Insert Mode]
inoremap <M-d> <ESC><Space>cW

" maps gX to use xdg-open with a relative filepath under your cursor
nnoremap gX :silent :execute
            \ "!xdg-open" expand('%:p:h') . "/" . expand("<cfile>") " &"<cr>

" NerdTree
map <C-b> :NERDTreeToggle<CR>
map <C-f> :NERDTreeFind<CR>

let g:NERDTreeDirArrowExpandable = '►'
let g:NERDTreeDirArrowCollapsible = '▼'
let NERDTreeShowLineNumbers=1
let NERDTreeShowHidden=1
let NERDTreeMinimalUI = 1
let g:NERDTreeWinSize=38

" indent with tab/s-tab
nnoremap <Tab> >>_
nnoremap <S-Tab> <<_
inoremap <S-Tab> <C-D>
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv

" auto-center
nmap G Gzz
nmap n nzz
nmap N Nzz
nmap } }zz
nmap { {zz

" paste clipboard as markdown link
nmap <leader>pl i* []()<ESC>PF]i

" use arrows for number increment/decrement
nnoremap <up> <C-a>
nnoremap <down> <C-x>

" move cursor position back and forth in change list
nnoremap <left> g;
nnoremap <right> g,

" ### Commands ###
"
" format json using jq
command! FormatJson :execute '%!jq .'
command! VimEdit execute ':e ~/.vimrc'
command! VimReload execute ':source ~/.vimrc'

" ### Auto Commands ###

" rename tmux window when open *.md files
autocmd BufReadPost,FileReadPost,BufNewFile *.md call system("tmux rename-window " . expand("%"))
" rename tmux window to current directory then closing markdown file
autocmd VimLeave *.md call system("tmux rename-window " . expand('%:p:h:t'))

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
    autocmd FileType csharp           let b:comment_leader = '# '
augroup END
noremap <silent> ,cc :<C-B>silent <C-E>s/^/<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>:nohlsearch<CR>
noremap <silent> ,cu :<C-B>silent <C-E>s/^\V<C-R>=escape(b:comment_leader,'\/')<CR>//e<CR>:nohlsearch<CR>

" Remove trailing whitespace on write
" autocmd BufWritePre * %s/\s\+$//e
" Mark trailing spaces as errors
match ErrorMsg '\s\+$'

" Disable folding
let g:pandoc#modules#disabled = ["folding", "spell"]

" auto-pairs
" activate fly mode
let g:AutoPairsFlyMode = 1

" # vim-markdown (vim-polyglot)
" https://github.com/plasticboy/vim-markdown
" disable auto insert bullets
let g:vim_markdown_auto_insert_bullets = 0
let g:vim_markdown_new_list_item_indent = 0

" ### Functions
function! FixLastSpellingError()
    " mm    - set mark m at cursor pos
    " [s    - move to the previous misspelled word
    " 1z=   - pick first spelling suggestions
    " 1m    - jump to the mark m
    normal! mm[s1z=`m
endfunction

nnoremap <leader>sp :call FixLastSpellingError()<cr>
