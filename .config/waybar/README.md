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
- Clicking the module runs `connect`, requests the A2DP Audio Sink profile, makes it the default PulseAudio sink, and moves active playback streams.
- `connect` is a no-op when the AirPods are already connected and their A2DP sink is already the default.
- Desktop notifications report connection success or failure, and Waybar is refreshed with real-time signal 8.

```bash
# Inspect Waybar status
~/.config/waybar/airpods.sh status | jq .

# Connect and select A2DP audio
~/.config/waybar/airpods.sh connect
```

Normal use requires an existing trusted, paired, and bonded record. See [`AIRPODS_FIX.md`](./AIRPODS_FIX.md) only for one-time pairing repair or `br-connection-key-missing` recovery.

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
