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

  to_remove=()
  while read -r pkg; do
    read -rp "Uninstall '$pkg'? [y/N/q] " answer </dev/tty
    case "$answer" in
      y|Y) to_remove+=("$pkg") ;;
      q|Q) echo "Skipping remaining packages."; break ;;
      *) ;;
    esac
  done <<< "$untracked"

  if [[ ${#to_remove[@]} -gt 0 ]]; then
    echo "Removing: ${to_remove[*]}"
    sudo pacman -Rns "${to_remove[@]}"
  fi
fi
echo "✓ Package tracking check complete"
