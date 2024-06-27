# Kaar dotfiles

## Setup
## Get started
```sh
curl -fsSL https://gist.github.com/9c338d1ec5ed9df6c76471b46709ed09 | sh
```

```sh
alias config='git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
git clone --bare https://github.com/kaar/dotfiles.git "$HOME/.cfg"
config checkout
config config --local status.showUntrackedFiles no
```

## NVIM

```sh
~/.install/source/nvim
```

## Usage
Example
```
config status
config add .vimrc
config commit -m "Add vimrc"
config add .bashrc
config commit -m "Add bashrc"
config push
```

## Inspiration
* [rwxrob](https://github.com/rwxrob/dot)
* [christoomey](https://github.com/christoomey/dotfiles)
* [ThePrimeagen](https://github.com/ThePrimeagen/.dotfiles)
