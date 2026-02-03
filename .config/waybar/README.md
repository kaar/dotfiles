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
