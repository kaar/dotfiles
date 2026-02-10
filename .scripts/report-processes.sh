#!/usr/bin/env bash

set -o nounset
set -o pipefail

section() {
  local title="$1"
  echo "## $title"
  echo ""
  echo '```sh'
  cat
  echo '```'
  echo ""
}

echo "# Threat Report"
echo ""

ps -f --ppid 1 -C tmux,ps,bash,dbus-broker,sway,pulse,foot --deselect |
  section "Processes (Excluding Common System Processes)"

ps -fu "$USER" |
  section "Processes Owned by $USER"

ps aux --forest |
  section "Process Tree"

lsof -nP -u "$USER" | grep LISTEN |
  section "Open Files and Network Connections"

ss -tulpn |
  section "Listening Network Sockets"

ss -tulpn | grep -v 127.0.0.1 |
  section "External Listening Network Sockets"
