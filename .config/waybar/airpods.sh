#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

# Setup and persistent bonding repair: ~/.config/waybar/AIRPODS_FIX.md
# BlueZ controller mode is configured in /etc/bluetooth/main.conf.
# Waybar invokes this helper from ~/.config/waybar/config.jsonc.

readonly AIRPODS_OWNER="Caspar"
readonly AIRPODS_ICON=""
readonly A2DP_SINK_UUID="0000110b-0000-1000-8000-00805f9b34fb"
readonly WAYBAR_SIGNAL=8

usage() {
    echo "Usage: ${0##*/} {status|connect|pair}" >&2
    exit 2
}

require_bluetoothctl() {
    command -v bluetoothctl >/dev/null || {
        echo "bluetoothctl is not installed; install the Arch package bluez-utils" >&2
        return 1
    }
}

find_airpods() {
    local line
    local address
    local name

    while IFS= read -r line; do
        [[ "$line" == Device\ * ]] || continue
        line="${line#Device }"
        address="${line%% *}"
        name="${line#* }"

        if [[ "$name" == *"$AIRPODS_OWNER"* && "$name" == *AirPods* ]]; then
            printf '%s\n' "$address"
            return 0
        fi
    done < <(bluetoothctl devices Trusted 2>/dev/null || true)

    return 1
}

find_pairing_candidates() {
    local line
    local address
    local name

    while IFS= read -r line; do
        [[ "$line" == Device\ * ]] || continue
        line="${line#Device }"
        address="${line%% *}"
        name="${line#* }"

        [[ "$name" == *"$AIRPODS_OWNER"* && "$name" == *AirPods* ]] && printf '%s\n' "$address"
    done < <(bluetoothctl devices 2>/dev/null || true)
}

is_paired() {
    local address="$1"
    bluetoothctl info "$address" 2>/dev/null | rg --quiet '^\s*Paired: yes$'
}

is_connected() {
    local address="$1"
    bluetoothctl info "$address" 2>/dev/null | rg --quiet '^\s*Connected: yes$'
}

notify() {
    local message="$1"
    command -v notify-send >/dev/null || return 0
    notify-send --app-name="AirPods" "AirPods" "$message" || true
}

refresh_waybar() {
    pkill "-RTMIN+$WAYBAR_SIGNAL" waybar 2>/dev/null || true
}

print_status() {
    local address=""
    local state="disconnected"
    local audio_connected=false
    local tooltip=$'AirPods disconnected\rClick to connect'

    if ! command -v bluetoothctl >/dev/null; then
        state="unavailable"
        tooltip="Bluetooth tools unavailable"
    elif ! systemctl is-active --quiet bluetooth.service; then
        state="unavailable"
        tooltip="Bluetooth unavailable"
    elif ! address="$(find_airpods)" || ! is_paired "$address"; then
        state="unavailable"
        tooltip=$'AirPods not paired\rClick to pair'
    elif audio_is_ready "$address"; then
        state="connected"
        audio_connected=true
        tooltip="AirPods connected"
    elif is_connected "$address"; then
        state="connected"
        tooltip="AirPods connected but not selected for audio"
    fi

    jq --compact-output --null-input \
        --arg text "$AIRPODS_ICON" \
        --arg tooltip "$tooltip" \
        --arg class "$state" \
        --argjson audio_connected "$audio_connected" \
        '{text: $text, tooltip: $tooltip, class: (if $audio_connected then [$class, "audio-connected"] else $class end)}'
}

audio_is_ready() {
    local address="$1"
    local sink="bluez_sink.${address//:/_}.a2dp_sink"

    is_connected "$address" &&
        [[ "$(pactl get-default-sink 2>/dev/null || true)" == "$sink" ]] &&
        pactl list sinks short | rg --quiet "[[:space:]]${sink}[[:space:]]"
}

check_pairing() {
    local address="$1"
    local info

    info="$(bluetoothctl info "$address")"
    printf '%s\n' "$info" | rg --quiet '^\s*Paired: yes$' || {
        echo "AirPods are trusted but not paired; A2DP authentication cannot succeed" >&2
        return 1
    }

    printf '%s\n' "$info" | rg --quiet '^\s*Bonded: yes$' ||
        echo "Warning: Bluetooth record is paired but not persistently bonded" >&2
}

connect_a2dp() {
    local address="$1"
    local output

    if ! output="$(bluetoothctl --timeout 25 connect "$address" "$A2DP_SINK_UUID" 2>&1)"; then
        printf '%s\n' "${output//$address/<device>}" >&2
        return 1
    fi
}

select_audio() {
    local address="$1"
    local card="bluez_card.${address//:/_}"
    local sink="bluez_sink.${address//:/_}.a2dp_sink"
    local attempt
    local sink_input

    for ((attempt = 0; attempt < 40; attempt++)); do
        if pactl list cards short | rg --quiet "[[:space:]]${card}[[:space:]]" &&
            pactl set-card-profile "$card" a2dp_sink 2>/dev/null &&
            pactl list sinks short | rg --quiet "[[:space:]]${sink}[[:space:]]"; then
            pactl set-default-sink "$sink" || return
            while IFS=$'\t' read -r sink_input _; do
                [[ -z "$sink_input" ]] || pactl move-sink-input "$sink_input" "$sink" || return
            done < <(pactl list sink-inputs short)
            return 0
        fi
        sleep 0.25
    done

    echo "BlueZ connected, but PulseAudio did not provide an A2DP sink" >&2
    return 1
}

connect_airpods() {
    local address

    require_bluetoothctl || return

    systemctl is-active --quiet bluetooth.service || {
        echo "Bluetooth service is not running" >&2
        return 1
    }

    address="$(find_airpods)" || {
        echo "Trusted Caspar AirPods were not found" >&2
        return 1
    }

    if audio_is_ready "$address"; then
        echo "AirPods A2DP audio is already selected"
        return 0
    fi

    check_pairing "$address" || return
    connect_a2dp "$address" || return
    select_audio "$address" || return
    echo "AirPods connected and selected for A2DP audio"
}

pair_airpods() {
    local address
    local output
    local -a candidates=()

    require_bluetoothctl || return

    systemctl is-active --quiet bluetooth.service || {
        echo "Bluetooth service is not running" >&2
        return 1
    }

    echo "Open the AirPods case and hold its setup button until the light flashes white." >&2
    echo "Scanning for $AIRPODS_OWNER AirPods for 20 seconds..." >&2
    bluetoothctl --timeout 20 scan on >/dev/null 2>&1 || true
    mapfile -t candidates < <(find_pairing_candidates)

    case "${#candidates[@]}" in
        0)
            echo "$AIRPODS_OWNER AirPods were not found; confirm pairing mode and try again" >&2
            return 1
            ;;
        1)
            address="${candidates[0]}"
            ;;
        *)
            echo "Multiple $AIRPODS_OWNER AirPods were found; refusing to choose a device" >&2
            return 1
            ;;
    esac

    if ! is_paired "$address"; then
        if ! output="$(bluetoothctl --timeout 30 pair "$address" 2>&1)"; then
            printf '%s\n' "${output//$address/<device>}" >&2
            return 1
        fi
    fi

    if ! output="$(bluetoothctl trust "$address" 2>&1)"; then
        printf '%s\n' "${output//$address/<device>}" >&2
        return 1
    fi

    check_pairing "$address" || return
    echo "AirPods paired and trusted"
}

run_connect() {
    if connect_airpods; then
        notify "Connected and selected for A2DP audio"
    else
        notify "A2DP audio connection failed"
        return 1
    fi
}

run_pair() {
    if pair_airpods; then
        notify "Paired and trusted"
    else
        notify "Pairing failed"
        return 1
    fi
}

case "${1:-}" in
    status)
        print_status
        ;;
    connect)
        trap refresh_waybar EXIT
        run_connect
        ;;
    pair)
        trap refresh_waybar EXIT
        run_pair
        ;;
    *)
        usage
        ;;
esac
