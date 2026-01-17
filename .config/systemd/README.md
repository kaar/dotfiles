# Systemd User

User-level systemd services run without root privileges and are managed per-user.

## Directory Structure

```
~/.config/systemd/user/
├── *.service               # Service unit files
├── *.timer                 # Timer unit files (like cron)
└── default.target.wants/   # Services enabled at login
```

## Common Commands

```bash
# Reload after adding/modifying unit files
systemctl --user daemon-reload

# Start/stop/restart a service
systemctl --user start myservice
systemctl --user stop myservice
systemctl --user restart myservice

# Enable/disable at login
systemctl --user enable myservice
systemctl --user disable myservice

# Check status and logs
systemctl --user status myservice
journalctl --user -u myservice -f
```

## Creating a Service

Create `~/.config/systemd/user/myservice.service`:

```ini
[Unit]
Description=My Custom Service
After=network.target

[Service]
Type=simple
ExecStart=/path/to/your/program
Restart=on-failure
RestartSec=5

[Install]
WantedBy=default.target
```

### Service Types

- `simple` - Default. Process started by ExecStart is the main process
- `oneshot` - For scripts that run once and exit
- `forking` - For daemons that fork (use with PIDFile=)

### Environment Variables

```ini
[Service]
Environment="VAR1=value1" "VAR2=value2"
EnvironmentFile=%h/.config/myservice/env
```

`%h` expands to the user's home directory.

## Creating a Timer

Create `~/.config/systemd/user/myservice.timer`:

```ini
[Unit]
Description=Run myservice periodically

[Timer]
OnCalendar=hourly
Persistent=true

[Install]
WantedBy=timers.target
```

Enable with `systemctl --user enable --now myservice.timer`

## Persistent Services (Linger)

By default, user services stop when you log out. To keep them running:

```bash
loginctl enable-linger $USER
```

## Useful Specifiers

- `%h` - User home directory
- `%u` - Username
- `%t` - Runtime directory (`$XDG_RUNTIME_DIR`)
