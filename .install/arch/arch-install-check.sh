#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

PACMAN_FILE=${1:-$HOME/.install/arch/packages.txt}
AUR_URL_FILE=${2:-$HOME/.install/arch/aur_packages.txt}

installed=$(pacman -Qeq | grep -v -- '-debug$' | sort)
tracked_pacman=$(grep -v '^\s*#' "$PACMAN_FILE" | grep -v '^\s*$' | sort)

# Extract package names from AUR URLs (basename without .git)
tracked_aur=$(grep -v '^\s*#' "$AUR_URL_FILE" | grep -v '^\s*$' | xargs -I{} basename {} .git | sort)
# untracked=$(comm -23 <(echo "$installed") <(sort -u <(echo "$tracked_pacman")))
untracked=$(comm -23 <(echo "$installed") <(sort -u <(echo "$tracked_pacman") <(echo "$tracked_aur")))

if [[ -n "$untracked" ]]; then
  echo "The following packages are installed but not tracked:"
  echo "$untracked" | while read -r pkg; do
    echo "  - $pkg"
  done
  echo ""
  exit 1
fi
echo "✓ All installed packages are tracked"
