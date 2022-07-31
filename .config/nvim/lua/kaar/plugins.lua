vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'sainnhe/gruvbox-material'
  use 'christoomey/vim-tmux-navigator'
end)
