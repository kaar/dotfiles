# Waybar Configuration

Personal waybar configuration for Sway with Gruvbox Dark theme.

## Theme

Uses Gruvbox Dark color scheme with JetBrainsMono Nerd Font.

**Key colors:**
- Background: `#282828`
- Foreground: `#ebdbb2`
- Accent (clock): `#a89984` (gray)


## Usage

```bash
# Start waybar (usually done by sway config)
waybar &

# Restart after config changes
~/.config/waybar/restart.sh

# Check config syntax
waybar --config ~/.config/waybar/config.jsonc --log-level debug
```

## Custom Scripts

### airpods.sh

Provides the Waybar AirPods status indicator and one-click A2DP audio selection. The script locates the trusted Caspar AirPods by name without storing their Bluetooth address.

- `status` emits compact JSON with `connected`, `disconnected`, or `unavailable` as the Waybar class. When A2DP is also present and selected as the default sink, the class array contains both `connected` and `audio-connected`.
- `pair` scans for discoverable Caspar AirPods, pairs them, and marks them trusted without storing or printing their Bluetooth address. It refuses to choose when multiple matching devices are discovered and never removes an existing bond.
- Clicking the module runs `connect`, requests the A2DP Audio Sink profile, makes it the default PulseAudio sink, and moves active playback streams.
- `connect` is a no-op when the AirPods are already connected and their A2DP sink is already the default.
- Desktop notifications report pairing or connection success and failure, and Waybar is refreshed with real-time signal 8.

#### Dependencies

The helper uses the following Arch packages:

- `bash`: runs the script.
- `bluez` and `bluez-utils`: provide the Bluetooth service and `bluetoothctl` for discovery, pairing, trust, and connection.
- `pulseaudio`, `pulseaudio-bluetooth`, and `libpulse`: provide the PulseAudio server, Bluetooth A2DP support, and `pactl`.
- `ripgrep`: provides `rg` for parsing BlueZ and PulseAudio state.
- `jq`: produces the JSON consumed by Waybar.
- `coreutils`: provides `sleep` while waiting for the A2DP sink.
- `systemd`: manages the Bluetooth and user audio services.
- `waybar` and `procps-ng`: provide the bar and `pkill` used to request a module refresh.
- `libnotify` (optional): provides `notify-send` for desktop notifications. The helper still works without it.

Install the required packages and the optional notification integration:

```bash
sudo pacman -S bash bluez bluez-utils coreutils jq libnotify libpulse procps-ng pulseaudio pulseaudio-bluetooth ripgrep systemd waybar
```

Enable BlueZ and ensure PulseAudio is available through its user socket:

```bash
sudo systemctl enable --now bluetooth.service
systemctl --user enable --now pulseaudio.socket
systemctl --user restart pulseaudio.service
```

This configuration uses PulseAudio directly. Do not install `pipewire-pulse` alongside it because both provide the PulseAudio server interface.

#### Pairing and use

Put the AirPods in pairing mode by opening their case and holding the setup button until its light flashes white, then run:

```bash
# Pair and trust discoverable Caspar AirPods
~/.config/waybar/airpods.sh pair

# Inspect Waybar status
~/.config/waybar/airpods.sh status | jq .

# Connect and select A2DP audio
~/.config/waybar/airpods.sh connect
```

Normal use requires an existing trusted, paired, and bonded record. Pairing does not remove or repair an invalid existing bond.

### openclaw.py

Displays OpenClaw Gateway service status in the bar.

- Shows running/stopped status via systemd user service check
- Click to open the gateway URL (http://127.0.0.1:18789)
- Updates every 10 seconds

```bash
# Test manually
~/.config/waybar/openclaw.py
```

### podman.py

Monitors running Podman containers.

**Commands:**

```bash
# Show container count and list (default)
~/.config/waybar/podman.py info

# Show status of specific container
~/.config/waybar/podman.py status jellyfin
```

**Waybar integration example:**

```jsonc
"custom/podman": {
  "exec": "~/.config/waybar/podman.py info",
  "interval": 10,
  "return-type": "json",
  "format": "{} "
},
"custom/jellyfin": {
  "exec": "~/.config/waybar/podman.py status jellyfin",
  "interval": 10,
  "return-type": "json",
  "format": "{}",
  "on-click": "xdg-open http://localhost:8096"
}
```
