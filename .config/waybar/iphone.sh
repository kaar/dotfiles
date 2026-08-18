#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

readonly IPHONE_SSID="Caspar iPhone"
readonly IPHONE_ICON=""
readonly IPHONE_CONNECT_SCRIPT="$HOME/.scripts/iphone"
readonly WIFI_INTERFACE="wlan0"
readonly WAYBAR_SIGNAL=9

usage() {
    echo "Usage: ${0##*/} {status|connect}" >&2
    exit 2
}

current_ssid() {
    local line

    while IFS= read -r line; do
        if [[ "$line" == *"SSID: "* ]]; then
            printf '%s\n' "${line#*SSID: }"
            return 0
        fi
    done < <(iw dev "$WIFI_INTERFACE" link 2>/dev/null || true)

    return 1
}

notify() {
    local message="$1"

    command -v notify-send >/dev/null &&
        notify-send --app-name="iPhone hotspot" "iPhone hotspot" "$message" || true
}

refresh_waybar() {
    pkill "-RTMIN+$WAYBAR_SIGNAL" waybar 2>/dev/null || true
}

print_status() {
    local ssid=""
    local state="disconnected"
    local tooltip="Caspar's iPhone hotspot is disconnected\nClick to connect"

    if ! command -v iw >/dev/null || ! iw dev "$WIFI_INTERFACE" info >/dev/null 2>&1; then
        state="unavailable"
        tooltip="Wi-Fi interface $WIFI_INTERFACE is unavailable"
    elif ssid="$(current_ssid)" && [[ "$ssid" == "$IPHONE_SSID" ]]; then
        state="connected"
        tooltip="Connected to Caspar's iPhone hotspot"
    fi

    jq --compact-output --null-input \
        --arg text "$IPHONE_ICON" \
        --arg tooltip "$tooltip" \
        --arg class "$state" \
        '{text: $text, tooltip: $tooltip, class: $class}'
}

connect_iphone() {
    local attempt
    local ssid=""

    command -v iw >/dev/null || {
        notify "The iw command is unavailable"
        return 1
    }

    [[ -x "$IPHONE_CONNECT_SCRIPT" ]] || {
        notify "Connection script not found: $IPHONE_CONNECT_SCRIPT"
        return 1
    }

    if ssid="$(current_ssid)" && [[ "$ssid" == "$IPHONE_SSID" ]]; then
        notify "Already connected to $IPHONE_SSID"
        return 0
    fi

    "$IPHONE_CONNECT_SCRIPT" >/dev/null 2>&1 || true

    for ((attempt = 0; attempt < 10; attempt++)); do
        if ssid="$(current_ssid)" && [[ "$ssid" == "$IPHONE_SSID" ]]; then
            notify "Connected to $IPHONE_SSID"
            return 0
        fi
        sleep 0.5
    done

    notify "Failed to connect to $IPHONE_SSID"
    return 1
}

case "${1:-}" in
    status)
        print_status
        ;;
    connect)
        trap refresh_waybar EXIT
        connect_iphone
        ;;
    *)
        usage
        ;;
esac
