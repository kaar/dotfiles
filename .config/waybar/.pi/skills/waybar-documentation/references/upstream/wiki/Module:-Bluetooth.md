> [!NOTE]
> This page is **auto-generated from [`man/waybar-bluetooth.5.scd`](https://github.com/Alexays/Waybar/blob/master/man/waybar-bluetooth.5.scd)** on the `master` branch.
> Do not edit it here — changes will be overwritten on the next sync.
> To update it, edit the man page(s) and open a PR.

# DESCRIPTION

The **bluetooth** module displays information about a bluetooth controller and its connections.

# CONFIGURATION

Addressed by **bluetooth**

| **Option** | **Typeof** | **Default** | **Description** |
|:--:|:--:|:--:|:--:|
| **controller** | string |  | Use the controller with the defined alias. Otherwise, a random controller is used. Recommended to define when there is more than 1 controller available to the system. |
| **controller-alias** | string |  | Synonym for **controller**. If both are set, **controller-alias** takes precedence. |
| **format-device-preference** | array |  | A ranking of bluetooth devices, addressed by their alias. The order is from **first displayed** to **last displayed**. If this config option is not defined or none of the devices in the list are connected, it will fall back to showing the last connected device. |
| **format** | string | ** {status}** | The format, how information should be displayed. This format is used when other formats aren't specified. |
| **format-disabled** | string |  | This format is used when the displayed controller is disabled. |
| **format-off** | string |  | This format is used when the displayed controller is turned off. |
| **format-on** | string |  | This format is used when the displayed controller is turned on with no devices connected. |
| **format-connected** | string |  | This format is used when the displayed controller is connected to at least 1 device. |
| **format-no-controller** | string |  | This format is used when no bluetooth controller can be found |
| **format-icons** | array/object |  | Based on the current battery percentage (see section **EXPERIMENTAL BATTERY PERCENTAGE FEATURE**), the corresponding icon gets selected. The order is **low** to **high**. Will only show the current battery percentage icon in the **\*-connected-battery** config options. Or by the state if it is an object. It will fall back to the enabled state if its derivatives are not defined (on, off, connected). |
| **rotate** | integer |  | Positive value to rotate the text label (in 90 degree increments). |
| **max-length** | integer |  | The maximum length in character the module should display. |
| **min-length** | integer |  | The minimum length in characters the module should accept. |
| **align** | float |  | The alignment of the label within the module, where 0 is left-aligned and 1 is right-aligned. If the module is rotated, it will follow the flow of the text. |
| **justify** | string |  | The alignment of the text within the module's label, allowing options 'left', 'right', or 'center' to define the positioning. |
| **on-click** | string |  | Command to execute when clicked on the module. |
| **on-click-middle** | string |  | Command to execute when middle-clicked on the module using mousewheel. |
| **on-click-right** | string |  | Command to execute when you right-click on the module. |
| **on-scroll-up** | string |  | Command to execute when scrolling up on the module. |
| **on-scroll-down** | string |  | Command to execute when scrolling down on the module. |
| **smooth-scrolling-threshold** | double |  | Threshold to be used when scrolling. |
| **tooltip** | bool | **true** | Option to disable tooltip on hover. |
| **tooltip-format** | string |  | The format, how information should be displayed in the tooltip. This format is used when other formats aren't specified. |
| **tooltip-format-disabled** | string |  | This format is used when the displayed controller is disabled. |
| **tooltip-format-off** | string |  | This format is used when the displayed controller is turned off. |
| **tooltip-format-on** | string |  | This format is used when the displayed controller is turned on with no devices connected. |
| **tooltip-format-connected** | string |  | This format is used when the displayed controller is connected to at least 1 device. |
| **tooltip-format-no-controller** | string |  | This format is used when no bluetooth controller can be found |
| **tooltip-format-enumerate-connected** | string |  | This format is used to define how each connected device should be displayed within the **device_enumerate** format replacement in the tooltip menu. |
| **menu** | string |  | Action that popups the menu. |
| **menu-file** | string |  | Location of the menu descriptor file. There need to be an element of type GtkMenu with id **menu** |
| **menu-actions** | array |  | The actions corresponding to the buttons of the menu. |
| **expand** | bool | false | Enables this module to consume all left over space dynamically. |

# FORMAT REPLACEMENTS

**{status}**: Status of the bluetooth device.

**{icon}**: Icon, as defined in **format-icons**.

**{num_connections}**: Number of connections the displayed controller has.

**{controller_address}**: Address of the displayed controller.

**{controller_address_type}**: Address type of the displayed controller.

**{controller_alias}**: Alias of the displayed controller.

**{device_address}**: Address of the displayed device.

**{device_address_type}**: Address type of the displayed device.

**{device_alias}**: Alias of the displayed device.

**{device_enumerate}**: Show a list of all connected devices, each on a separate line. Define the format of each device with the **tooltip-format-enumerate-connected**  
and/or **tooltip-format-enumerate-connected-battery** config options. Can only be used in the tooltip-related format options.

# EXPERIMENTAL BATTERY PERCENTAGE FEATURE

At the time of writing, the experimental features of BlueZ need to be turned on, for the battery percentage options listed below to work.

## FORMAT REPLACEMENT

**{device_battery_percentage}**: Battery percentage of the displayed device if available. Use only in the config options defined below.

**{device_battery_percentage_peripheral}**: Battery percentage of the peripheral half of a split keyboard (e.g., ZMK keyboards with separate central and peripheral batteries).  
This is read from GATT Battery Service characteristics that have a User Description descriptor. Use only in the config options defined below.

## CONFIGURATION

| **Option** | **Typeof** | **Default** | **Description** |
|:--:|:--:|:--:|:--:|
| **format-connected-battery** | string |  | This format is used when the displayed device provides its battery percentage. |
| **tooltip-format-connected-battery** | string |  | This format is used when the displayed device provides its battery percentage. |
| **tooltip-format-enumerate-connected-battery** | string |  | This format is used to define how each connected device with a battery should be displayed within the **device_enumerate** format replacement option. When this config option is not defined, it will fall back on the **tooltip-format-enumerate-connected** config option. |

# EXAMPLES

    "bluetooth": {
    	// "controller": "controller1", // specify the alias of the controller if there are more than 1 on the system
    	"format": " {status}",
    	"format-disabled": "", // an empty format will hide the module
    	"format-connected": " {num_connections} connected",
    	"tooltip-format": "{controller_alias}\t{controller_address}",
    	"tooltip-format-connected": "{controller_alias}\t{controller_address}\n\n{device_enumerate}",
    	"tooltip-format-enumerate-connected": "{device_alias}\t{device_address}"
    }

    "bluetooth": {
    	"format": " {status}",
    	"format-connected": " {device_alias}",
    	"format-connected-battery": " {device_alias} {device_battery_percentage}%",
    	// "format-device-preference": [ "device1", "device2" ], // preference list deciding the displayed device
    	"tooltip-format": "{controller_alias}\t{controller_address}\n\n{num_connections} connected",
    	"tooltip-format-connected": "{controller_alias}\t{controller_address}\n\n{num_connections} connected\n\n{device_enumerate}",
    	"tooltip-format-enumerate-connected": "{device_alias}\t{device_address}",
    	"tooltip-format-enumerate-connected-battery": "{device_alias}\t{device_address}\t{device_battery_percentage}%"
    }

Split keyboard with separate central/peripheral batteries (e.g., ZMK):

    "bluetooth": {
    	"format-device-preference": [ "Keyball44" ],
    	"format": "",
    	"format-connected-battery": " {device_battery_percentage}%|{device_battery_percentage_peripheral}%",
    	"tooltip-format-connected": "{device_alias}\nCentral: {device_battery_percentage}%\nPeripheral: {device_battery_percentage_peripheral}%"
    }

# STYLE

- **\#bluetooth**

- **\#bluetooth.disabled**

- **\#bluetooth.off**

- **\#bluetooth.on**

- **\#bluetooth.connected**

- **\#bluetooth.no-controller**

- **\#bluetooth.discoverable**

- **\#bluetooth.discovering**

- **\#bluetooth.pairable**
