#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail


alias config='git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
git clone --bare https://github.com/kaar/dotfiles.git "$HOME/.cfg"
config checkout
config config --local status.showUntrackedFiles no
