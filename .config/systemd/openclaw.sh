#!/usr/bin/env bash

SERVICE="openclaw-gateway"
ACTION="${1:-status}"

case "$ACTION" in
start | stop | status | enable | disable | restart)
  systemctl --user "$ACTION" "$SERVICE"
  ;;
logs | log)
  journalctl --user -u "$SERVICE" -f
  ;;
*)
  echo "Usage: $0 {start|stop|restart|status|enable|disable|logs}"
  exit 1
  ;;
esac
