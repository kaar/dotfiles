set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath

" ### PLUGINS ###
call plug#begin('~/.vim/plugged')
  Plug 'junegunn/fzf', { 'do': { -> fzf#install()  }  }
  Plug 'junegunn/fzf.vim'
  Plug 'airblade/vim-rooter'
  Plug 'sheerun/vim-polyglot'
  Plug 'scrooloose/NERDTree'
  Plug 'christoomey/vim-tmux-navigator'
  Plug 'morhetz/gruvbox'  " gruvbox colorschema
  Plug 'neovim/nvim-lspconfig'
call plug#end()

source ~/.vimrc

" ### .vimrc overrides ###
colorscheme gruvbox

source ~/.config/nvim/lsp.vim
