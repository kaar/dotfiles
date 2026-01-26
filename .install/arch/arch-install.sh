#!/bin/bash
set -euo pipefail

section() { echo -e "\n\033[1;34m══ $1 ══\033[0m"; }

PACMAN_SRC_FILE=$HOME/.install/arch/packages.txt
[[ ! -f $PACMAN_SRC_FILE ]] && {
  echo "'$PACMAN_SRC_FILE' not found." >&2
  exit 1
}
AUR_SRC=$HOME/.install/arch/aur_packages.txt
[[ ! -f $AUR_SRC ]] && {
  echo "'$AUR_SRC' not found." >&2
  exit 1
}

# Handle --edit option
if [[ "${1:-}" == "--edit" ]]; then
  if [[ -z "${EDITOR:-}" ]]; then
    echo "EDITOR environment variable is not set." >&2
    exit 1
  fi
  exec "$EDITOR" "$PACMAN_SRC_FILE"
fi

# Check if running as root
if [[ $EUID -eq 0 ]]; then
  echo "Do not run as root. Will prompt for sudo when required." >&2
  exit 1
fi

install_aur_package() {
  local url package_name repo
  url="$1"
  package_name=$(basename "$url" .git)

  if pacman -Q "$package_name" &>/dev/null; then
    echo "✓ $package_name (already installed)"
    return 0
  fi
  echo "→ Installing $package_name..."
  repo=$(mktemp -d)/$package_name
  echo "Cloning from $url to $repo"
  git clone "$url" --depth 1 "$repo" --quiet
  (cd "$repo" && makepkg -si --noconfirm --needed --skippgpcheck --skipchecksums --noprogressbar)
  rm -rf "$repo"
}

install_aur_packages() {
  while IFS= read -r line || [[ -n "$line" ]]; do
    [[ "$line" =~ ^\s*# || -z "$line" ]] && continue
    install_aur_package "$line"
  done <"$AUR_SRC"
}

section "Package Tracking Check"
"$HOME/.install/arch/arch-install-check.sh"

section "System Update"
sudo pacman -Syu

section "Base Packages"
grep -v '^\s*#' "$PACMAN_SRC_FILE" | sudo pacman -S --needed -

section "Cleanup: Orphaned Packages"
sudo pacman -Rns "$(pacman -Qdtq)" || true

section "AUR Packages"
install_aur_packages

section "Firmware Updates"
sudo fwupdmgr refresh || true
sudo fwupdmgr get-updates || true
sudo fwupdmgr update || true

section "Flatpak Services"
systemctl --user enable flatpak-update.service
systemctl --user start flatpak-update.service

flatpak update --user -y

### systemd services
if ! systemctl is-active --quiet dnsmasq; then
  echo "dnsmasq service is not running, starting it now..."
  # sudo systemctl start dnsmasq
fi

# Failed to connect to user scope bus via local transport: $DBUS_SESSION_BUS_ADDRESS and $XDG_RUNTIME_DIR not defined (consider using --machine=<user>@.host --user to connect to bus of other user)

# Remove unneeded packages
# pacman -Rns $(pacman -Qdtq)

# pacman -S --needed - < $src_file
# pacman -S --needed - < "$src_file"

# gh-clone kaar/nvim-config

# ln -sf home/kaar/repos/kaar/nvim-config/nvim home/kaar/.config/nvim

# TODO
# * Add tmux plugin validation and install
# * Add nvim config
# * Install nerd fonts.
# Currently download from https://www.nerdfonts.com/#home
# unzip NerdFont.zip -d ~/.local/share/fonts
# fc-cache -fv
#
# Notify
# https://github.com/kaar/mako
#
# Templates
# https://github.com/kaar/template
#
section "Virtualization Services"
sudo systemctl enable --now libvirtd

section "Rust"
if ! command -v rustup &>/dev/null; then
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
else
  echo "rustup already installed"
fi

# Firmware updates
# echo "Installing fwupd for firmware updates..."
# fwupdmgr get-devices
# fwupdmgr get-updates
# echo "Firmware updates installed."
#
#
# Flatpak
# missing_flatpack=missing_flatpak.txt
# grep -v '^\s*#' "$missing_flatpack" \
#   | flatpak install --user -
# echo "Flatpak installed."
#
#

section "pnpm"
if ! command -v pnpm &>/dev/null; then
  echo "Installing pnpm..."
  curl -fsSL https://get.pnpm.io/install.sh | sh -
  # Source the updated environment to make pnpm available
  export PNPM_HOME="$HOME/.local/share/pnpm"
  export PATH="$PNPM_HOME:$PATH"
else
  echo "pnpm already installed, checking for updates..."
  pnpm self-update || true
fi
echo "pnpm version: $(pnpm --version)"
echo "pnpm binary:  $(command -v pnpm)"
echo "pnpm home:    ${PNPM_HOME:-$HOME/.local/share/pnpm}"

section "NPM Packages"
if [ -z "$NPM_PREFIX" ]; then
  echo "NPM_PREFIX is not set."
  exit 1
fi
# check npm config prefix is set
if [ "$(npm config get prefix)" != "$NPM_PREFIX" ]; then
  echo "npm config set prefix $NPM_PREFIX"
  exit 1
fi

npm_install() {
  local pkg=$1
  npm list -g "$pkg" &>/dev/null || npm install -g "$pkg"
  if npm outdated -g "$pkg" | grep -q "${pkg##*/}"; then
    npm update -g "$pkg"
  else
    echo "✓ ${pkg##*/} (up to date)"
  fi
}

npm_install @anthropic-ai/claude-code
npm_install @openai/codex

# # Check if systemd-resolved is running
# systemctl status systemd-resolved
#
#
# # Look up Chromecast devices using systemd-resolved
# resolvectl --type=PTR query _googlecast._tcp.local
#
#
# # resolvectl --type=PTR query _googlecast._tcp.local
# # _googlecast._tcp.local IN PTR Chromecast-HD-b33005e39a26fd0dc11b19a203bede9a._googlecast._tcp.local -- link: wlan0
# # _googlecast._tcp.local IN PTR Google-TV-Streamer-5398eda1207ce3b26b778d4f8d31e4f1._googlecast._tcp.local -- link: wlan0
# #
# # -- Information acquired via protocol mDNS/IPv4 in 768us.
# # -- Data is authenticated: no; Data was acquired via local or encrypted transport: no
# # -- Data from: cache
#
#
#
# resolvectl --type=SRV query Chromecast-HD-b33005e39a26fd0dc11b19a203bede9a._googlecast._tcp.local
#
# # Chromecast-HD-b33005e39a26fd0dc11b19a203bede9a._googlecast._tcp.local IN SRV 0 0 8009 b33005e3-9a26-fd0d-c11b-19a203bede9a.local -- link: wlan0
# #
# # -- Information acquired via protocol mDNS/IPv4 in 1.3ms.
# # -- Data is authenticated: no; Data was acquired via local or encrypted transport: no
# resolvectl query <hostname from SRV>

section "Go Packages"
go_install() {
  local pkg=$1
  echo "→ $(basename "${pkg%@*}")"
  go install "$pkg"
}

go_install github.com/vishen/go-chromecast@latest
