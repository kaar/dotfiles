#!/bin/bash
set -euo pipefail

# PACMAN_SRC_FILE="missing.txt"
PACMAN_SRC_FILE=$HOME/.install/arch/packages.txt

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

# Check if PACMAN_SRC_FILE exists
if [[ ! -f $PACMAN_SRC_FILE ]]; then
    echo "Package list file '$PACMAN_SRC_FILE' not found." >&2
    exit 1
fi

# Update packages
echo "Updating system packages..."
sudo pacman -Syu
echo "System packages updated."

echo "Installing base packages..."
# Skip comments
grep -v '^\s*#' "$PACMAN_SRC_FILE" \
  | sudo pacman -S --needed -
echo "Base packages installed."

# Remove orphaned packages
echo "Removing orphaned packages..."
sudo pacman -Rns "$(pacman -Qdtq)" || true
echo "Orphaned packages removed."


# Firmware updates
echo "Checking for firmware updates..."
sudo fwupdmgr refresh       # update metadata
sudo fwupdmgr get-updates   # list updates
sudo fwupdmgr update        # install updates
echo "Firmware updates checked."

# Enable flatpak update service
# .config/systemd/user/flatpak-update.service
echo "Enabling flatpak update service..."
systemctl --user enable flatpak-update.service
systemctl --user start flatpak-update.service


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
# Virtualization
# Enable systemd services
echo "Enabling virtualization services..."
sudo systemctl enable --now libvirtd
echo "Virtualization services enabled."

# Rust
if ! command -v rustup &> /dev/null; then
  echo "Installing rust..."
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
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

### NPM
# check NPM_PREFIX is set
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
  local package_name=$1

  npm list -g "$package_name" >/dev/null 2>&1 \
    || npm install -g "$package_name"

  if npm outdated -g "$package_name" | grep -q "${package_name##*/}"; then
      echo "Update available. Updating..."
      npm update -g "$package_name"
  else
      echo "$package_name is up to date"
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

### Go
go install github.com/vishen/go-chromecast@latest
