> [!NOTE]
> This page is **auto-generated from [`man/waybar-keyboard-state.5.scd`](https://github.com/Alexays/Waybar/blob/master/man/waybar-keyboard-state.5.scd)** on the `master` branch.
> Do not edit it here — changes will be overwritten on the next sync.
> To update it, edit the man page(s) and open a PR.

# DESCRIPTION

The **keyboard-state** module displays the state of number lock, caps lock, and scroll lock.

You must be a member of the input group to use this module. Add yourself with **usermod -a -G input \<username\>** (as root), then reboot.

# CONFIGURATION

**interval**:  
Deprecated, this module uses event loop now, the interval has no effect.

> typeof: integer  
> default: 1  
> The interval, in seconds, to poll the keyboard state.

| **Option** | **Typeof** | **Default** | **Description** |
|:--:|:--:|:--:|:--:|
| **format** | string\|object | {name} {icon} | The format, how information should be displayed. If a string, the same format is used for all keyboard states. If an object, the fields "numlock", "capslock", and "scrolllock" each specify the format for the corresponding state. Any unspecified states use the default format. |
| **format-icons** | object | {"locked": "locked", "unlocked": "unlocked"} | Based on the keyboard state, the corresponding icon gets selected. Supports two syntaxes: - Common format-icons: "locked" and "unlocked" keys apply to all lock types. - Per-lock-type format-icons: per-lock-type objects with "numlock", "capslock", "scrolllock" keys, each containing "locked" and "unlocked" icons. See **icons**. |
| **numlock** | bool | false | Display the number lock state. |
| **capslock** | bool | false | Display the caps lock state. |
| **scrolllock** | bool | false | Display the scroll lock state. |
| **device-path** | string | chooses first valid input device | Which libevdev input device to show the state of. Libevdev devices can be found in /dev/input. The device should support number lock, caps lock, and scroll lock events. |
| **binding-keys** | array | \[58, 69, 70\] | Customize the key to trigger this module, the key number can be found in /usr/include/linux/input-event-codes.h or running sudo libinput debug-events --show-keycodes. |
| **expand** | bool | false | Enables this module to consume all left over space dynamically. |

# FORMAT REPLACEMENTS

**{name}**: Caps, Num, or Scroll.

**{icon}**: Icon, as defined in **format-icons**.

# ICONS

The following **format-icons** can be set.

## Common format-icons for all lock types:

- **locked**: Will be shown when the keyboard state is locked. Default "locked".

- **unlocked**: Will be shown when the keyboard state is not locked. Default "unlocked".

## Per-lock-type format-icons:

- **numlock**, **capslock**, **scrolllock**: Object containing "locked" and "unlocked" keys for lock-type-specific icons. Defaults to {"locked": "locked", "unlocked": "unlocked"} for each lock type.

# EXAMPLE:

## Common format-icons for all lock types:

    "keyboard-state": {
    	"numlock": true,
    	"capslock": true,
    	"scrolllock": true,
    	"format": "{name} {icon}",
    	"format-icons": {
    		"locked": "",
    		"unlocked": ""
    	}
    }

## Per-lock-type format-icons:

    "keyboard-state": {
    	"numlock": true,
    	"capslock": true,
    	"scrolllock": true,
    	"format": "{name} {icon}",
    	"format-icons": {
    		"numlock": {
    			"locked": "1",
    			"unlocked": "0"
    		},
    		"capslock": {
    			"locked": "A",
    			"unlocked": "a"
    		},
    		"scrolllock": {
    			"locked": "S",
    			"unlocked": "s"
    		}
    	}
    }

# STYLE

- **\#keyboard-state**

- **\#keyboard-state label**

- **\#keyboard-state label.locked**

- **\#keyboard-state label.numlock**

- **\#keyboard-state label.numlock.locked**

- **\#keyboard-state label.capslock**

- **\#keyboard-state label.capslock.locked**

- **\#keyboard-state label.scrolllock**

- **\#keyboard-state label.scrolllock.locked**
