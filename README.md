# Kaar dotfiles

Personal dotfiles managed with a bare Git repository cloned into `$HOME/.cfg`.

<img width="2878" height="1800" alt="image" src="https://github.com/user-attachments/assets/5a5c9c2e-3800-4e6a-8fbb-d909cc143585" />

+ **OS**: [Arch Linux](https://archlinux.org/)
+ **Shell**: [Bash](.bashrc)
+ **Terminal**: Foot
+ **Display Server**: [Wayland](https://wayland.freedesktop.org/)
+ **Compositor**: [Sway](.config/sway/config)
+ **Editor**: [Neovim](https://github.com/kaar/nvim-config)
+ **Multiplexer**: [Tmux](https://github.com/kaar/tmux-config)
+ **Status Bar**: [Waybar](.config/waybar/config.jsonc)

## Setup
```sh
curl -fsSL https://gist.github.com/9c338d1ec5ed9df6c76471b46709ed09 | sh
```

```sh
alias config='git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
git clone --bare https://github.com/kaar/dotfiles.git "$HOME/.cfg"
config checkout
config config --local status.showUntrackedFiles no
```

## Additional external configs


```sh
# Nvim
git clone https://github.com/kaar/nvim-config ~/.config/nvim
# TMUX
git clone https://github.com/kaar/tmux-config ~/.config/tmux
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
