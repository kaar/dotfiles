> [!NOTE]
> This page is **auto-generated from [`man/waybar-wwan.5.scd`](https://github.com/Alexays/Waybar/blob/master/man/waybar-wwan.5.scd)** on the `master` branch.
> Do not edit it here — changes will be overwritten on the next sync.
> To update it, edit the man page(s) and open a PR.

# DESCRIPTION

**wwan** module for ModemManager.

# ADDITIONAL FILES

libmm-glib lives in:

> 1\.
>
> /usr/lib/libmm-glib.so or /usr/lib64/libmm-glib.so

> 2\.
>
> /usr/lib/pkgconfig/libmm-glib.pc or /usr/lib64/pkgconfig/libmm-glib.pc

> 3\.
>
> /usr/include/libmm-glib

# CONFIGURATION

| **Option** | **Typeof** | **Default** | **Description** |
|:--:|:--:|:--:|:--:|
| **format** | string | **{state}** | The format, how information should be displayed. This format is used when other formats aren't specified. |
| **format-failed** | string |  | This format is used when the modem cannot start. |
| **format-locked** | string |  | This format is used when the SIM on the modem is locked. |
| **format-disabled** | string |  | This format is used when the modem is disabled. |
| **format-enabled** | string |  | This format is used when the modem is enabled, but isn't registered to any carrier network. |
| **format-searching** | string |  | This format is used when the modem is looking for a carrier network to register to. |
| **format-registered** | string |  | This format is used when the modem is registered to a network, but no data connection is active. |
| **format-connected** | string |  | This format is used when the modem is registered to a network, and there is an active data connection. |
| **format-icons** | array/object |  | Based on the current signal strength, the corresponding icon gets selected. The order is **low** to **high**. Or by the state if it is an object. |
| **tooltip** | bool | true | Option to disable tooltip on hover. |
| **tooltip-format** | strirng | {state} | The format, how information should be displayed in the tooltip. This format is used when other formats aren't specified. |
| **tooltip-format-failed** | string |  | This format is used when the modem cannot start. |
| **tooltip-format-locked** | string |  | This format is used when the SIM on the modem is locked. |
| **tooltip-format-disabled** | string |  | This format is used when the modem is disabled. |
| **tooltip-format-enabled** | string |  | This format is used when the modem is enabled, but isn't registered to any carrier network. |
| **tooltip-format-searching** | string |  | This format is used when the modem is looking for a carrier network to register to. |
| **tooltip-format-registered** | string |  | This format is used when the modem is registered to a network, but no data connection is active. |
| **tooltip-format-connected** | string |  | This format is used when the modem is registered to a network, and there is an active data connection. |
| **interval** | integer | 5 | The interval in which the WWAN information gets polled (e.g. carrier name). |
| **imei** | string |  | Select only the modem with the corresponding imei. |
| **path** | string |  | Select only the modem with the corresponding hardware path. |
| **hide-disconnected** | bool | true | Defines if the module should be hidden while the modem does not have an active data connection. |

# FORMAT REPLACEMENTS

**{state}**: Modem state.

**{current_modes}**: List of all the currently active connection modes.

**{preferred_mode}**: The preferred connection mode in use.

**{signal_quality}**: Signal quality (0-100).

**{operator_name}**: Name of the network operator.

**{icon}**: Icon selected from **format-icons** according to the signal quality.

**{power_state}**: Modem power state (On/Off/Low/Unknown).

**{imei}**: Modem equipment identifier (IMEI).

# EXAMPLES

    "wwan": {
    	"format": "{state}",
    	"format-disabled": "", // an empty format will hide the module
    	"format-locked": "SIM Locked",
        "format-connected": "{operator_name} {preferred_mode} | {signal_quality}%"
    	"tooltip-format": "{preferred_mode}",
    	"tooltip-format-connected": "{current_modes}",
    	"hide-disconnected": false
    }

# STYLE

- **\#wwan**

- **\#wwan.failed** Applied when the modem cannot start.

- **\#wwan.locked** Applied when the SIM on the modem is locked.

- **\#wwan.disabled** Applied when the modem is disabled.

- **\#wwan.enabled** Applied when the modem is enabled, but isn't registered to any carrier network.

- **\#wwan.searching** Applied when the modem is looking for a carrier network to register to.

- **\#wwan.registered** Applied when the modem is registered to a network, but no data connection is active.

- **\#wwan.connected** Applied when the modem is registered to a network, and there is an active data connection.
