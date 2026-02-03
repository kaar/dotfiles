#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

echo "Restarting Waybar..."
killall waybar 2>/dev/null || true
sleep 0.5
waybar &
echo "Waybar started with PID $!"
