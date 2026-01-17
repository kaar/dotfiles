#!/usr/bin/env bash
# Display status of user-level systemd services

echo "=== Active Services ==="
systemctl --user list-units --type=service --state=running --no-pager --no-legend

echo ""
echo "=== Failed Services ==="
systemctl --user list-units --type=service --state=failed --no-pager --no-legend

echo ""
echo "=== Active Timers ==="
systemctl --user list-timers --no-pager --no-legend

echo ""
echo "=== Enabled Services ==="
systemctl --user list-unit-files --type=service --state=enabled --no-pager --no-legend
