#!/bin/bash
set -o nounset

## FZF, https://github.com/junegunn/fzf
FZF_PATH=${BIN}/fzf
REPO="https://github.com/junegunn/fzf.git"
if [[ ! -d $FZF_PATH ]]
then
	echo "Clone ${REPO}"
	git clone --depth 1 $REPO $FZF_PATH
fi

# Only downloads the latest binary from GitHub
# ~/.bin/fzf is needed for loading into vim
${FZF_PATH}/install --bin
echo "Create symbolic link ${FZF_PATH}/fzf -> /usr/bin/fzf"
[[ ! -L /usr/bin/fzf ]] \
	&& sudo ln -sf "${FZF_PATH}/bin/fzf" "/usr/bin/fzf"
	
