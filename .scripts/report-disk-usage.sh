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

echo "# Disk Usage Report"
echo ""

df -h / /home 2>/dev/null | sort -u |
  section "Filesystem Overview"

du -sh "$HOME"/*/ 2>/dev/null | sort -rh | head -20 |
  section "Largest Directories in \$HOME"

du -sh "$HOME"/.[!.]* 2>/dev/null | sort -rh | head -20 |
  section "Largest Hidden Directories in \$HOME"

du -sh "$HOME"/.cache/*/ 2>/dev/null | sort -rh | head -15 |
  section "Cache Breakdown (~/.cache)"

du -sh "$HOME"/.local/share/*/ 2>/dev/null | sort -rh | head -15 |
  section ".local/share Breakdown"

find "$HOME/Downloads" -maxdepth 2 -type f -size +50M -exec du -sh {} + 2>/dev/null | sort -rh | head -15 |
  section "Largest Files in Downloads"

{ du -sh /var/cache/pacman/pkg/ 2>/dev/null || echo "N/A"; } |
  section "Pacman Cache"

{ journalctl --disk-usage 2>/dev/null || echo "N/A"; } |
  section "Journal Logs Size"

{ podman system df 2>/dev/null || docker system df 2>/dev/null || echo "No container runtime found"; } |
  section "Docker/Container Images"

{ pacman -Qdtq 2>/dev/null || echo "None"; } |
  section "Orphan Packages (Arch)"
