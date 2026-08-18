> [!NOTE]
> This page is **auto-generated from [`man/waybar-upower.5.scd`](https://github.com/Alexays/Waybar/blob/master/man/waybar-upower.5.scd)** on the `master` branch.
> Do not edit it here — changes will be overwritten on the next sync.
> To update it, edit the man page(s) and open a PR.

# DESCRIPTION

The **upower** module displays the main battery capacity with all other upower compatible devices in the tooltip.

# CONFIGURATION

| **Option** | **Typeof** | **Default** | **Description** |
|:--:|:--:|:--:|:--:|
| **native-path** | string |  | The battery to monitor. Refer to the https://upower.freedesktop.org/docs/UpDevice.html#UpDevice--native-path Can be obtained using \`upower --dump\` |
| **model** | string |  | The battery to monitor, based on the model. (this option is ignored if **native-path** is given). Can be obtained using \`upower --dump\` |
| **icon-size** | integer | 20 | Defines the size of the icons. Set to **0** for automatic sizing. |
| **format** | string | {percentage} | The text format. |
| **format-alt** | string | {percentage} {time} | The text format when toggled. |
| **hide-if-empty** | bool | true | Defines visibility of the module if no devices can be found. |
| **tooltip** | bool | true | Option to disable tooltip on hover. |
| **tooltip-spacing** | integer | 4 | Defines the spacing between the tooltip device name and device battery status. |
| **tooltip-padding** | integer | 4 | Defines the spacing between the tooltip window edge and the tooltip content. |
| **tooltip-format** | string |  | The format used for each device line shown in the tooltip. Accepts the same replacements as **format**. |
| **on-click** | string |  | Command to execute when clicked on the module. |
| **show-icon** | bool | true | Option to disable battery icon. |
| **menu** | string |  | Action that popups the menu. |
| **menu-file** | string |  | Location of the menu descriptor file. There need to be an element of type GtkMenu with id **menu** |
| **menu-actions** | array |  | The actions corresponding to the buttons of the menu. |

# FORMAT REPLACEMENTS

**{percentage}**: The battery capacity in percentage

**{time}**: An estimated time either until empty or until fully charged  
depending on the charging state.

**{temperature}**: The battery temperature in degrees Celsius.

**{model}**: The model name of the device.

**{native-path}**: The native path of the device.

# EXAMPLES

    "upower": {
    	"icon-size": 20,
    	"hide-if-empty": true,
    	"tooltip": true,
    	"tooltip-spacing": 20
    }

    "upower": {
    	"native-path": "/org/bluez/hci0/dev_D4_AE_41_38_D0_EF",
    	"icon-size": 20,
    	"hide-if-empty": true,
    	"tooltip": true,
    	"tooltip-spacing": 20
    }

    "upower": {
    	"native-path": "battery_sony_controller_battery_d0o27o88o32ofcoee",
    	"icon-size": 20,
    	"hide-if-empty": true,
    	"tooltip": true,
    	"tooltip-spacing": 20
    }

    "upower": {
    	"show-icon": false,
    	"hide-if-empty": true,
    	"tooltip": true,
    	"tooltip-spacing": 20
    }

# STYLE

- **\#upower**

- **\#upower.charging**

- **\#upower.discharging**

- **\#upower.full**

- **\#upower.empty**

- **\#upower.unknown-status**
