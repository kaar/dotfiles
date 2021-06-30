" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  "autocmd VimEnter * PlugInstall
  "autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/autoload/plugged')

    " FZF & vim-rooter
    Plug 'junegunn/fzf', { 'do': { -> fzf#install()  }  }
    Plug 'junegunn/fzf.vim'
    Plug 'airblade/vim-rooter'

    " Better Syntax Support
    Plug 'sheerun/vim-polyglot'

    " NERDTree
    Plug 'scrooloose/NERDTree'

    " Auto pairs for '(' '[' '{'
    Plug 'jiangmiao/auto-pairs'

    " vim tmux navigator, https://github.com/christoomey/vim-tmux-navigator
    Plug 'christoomey/vim-tmux-navigator'

call plug#end()

" ### auto-pairs ###
" activate fly mode
let g:AutoPairsFlyMode = 1
