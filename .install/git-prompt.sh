#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

## Download git-prompt.sh
curl --silent https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh > ~/.config/bash/git-prompt.sh

