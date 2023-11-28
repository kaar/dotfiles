#!/bin/sh
# Install aur package
# Usage: install-aur.sh <url>
# Example: install-aur.sh https://aur.archlinux.org/franz.git

url="$1"

if [ -z "${url}" ]; then
    echo "Usage: install-aur.sh <url>"
    exit 1
fi

repo=$(mktemp -d)/$(basename "$0")
echo "Cloning ${url} into ${repo}"
git clone "${url}" --depth 1 "${repo}"

cd "${repo}" || exit 1
makepkg -si --noconfirm --needed --skippgpcheck --skipchecksums --noprogressbar
cd - || exit 1
rm -rf "${repo}"
