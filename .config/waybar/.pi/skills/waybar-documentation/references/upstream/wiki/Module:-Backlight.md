> [!NOTE]
> This page is **auto-generated from [`man/waybar-backlight.5.scd`](https://github.com/Alexays/Waybar/blob/master/man/waybar-backlight.5.scd)** on the `master` branch.
> Do not edit it here — changes will be overwritten on the next sync.
> To update it, edit the man page(s) and open a PR.

# DESCRIPTION

The **backlight** module displays the current backlight level.

# CONFIGURATION

| **Option** | **Typeof** | **Default** | **Description** |
|:--:|:--:|:--:|:--:|
| **interval** | integer | 2 | The interval in which information gets polled. |
| **device** | string |  | The name of the preferred backlight device to display. If left empty, a device will be chosen automatically. Both screen backlights (the udev **backlight** subsystem) and keyboard backlights (LEDs in the udev **leds** subsystem, e.g. **white:kbd_backlight**) are supported; name such an LED here to control it. When left empty, a screen backlight is always preferred for automatic selection. |
| **format** | string | {percent}% | The format, how information should be displayed. On {} data gets inserted. |
| **max-length** | integer |  | The maximum length in characters the module should display. |
| **min-length** | integer |  | The minimum length in characters the module should accept. |
| **align** | float |  | The alignment of the label within the module, where 0 is left-aligned and 1 is right-aligned. If the module is rotated, it will follow the flow of the text. |
| **justify** | string |  | The alignment of the text within the module's label, allowing options 'left', 'right', or 'center' to define the positioning. |
| **rotate** | integer |  | Positive value to rotate the text label (in 90 degree increments). |
| **states** | object |  | A number of backlight states which get activated on certain brightness levels. See **waybar-states(5)**. |
| **on-click** | string |  | Command to execute when the module is clicked. |
| **on-click-middle** | string |  | Command to execute when middle-clicked on the module using mouse scroll wheel. |
| **on-click-right** | string |  | Command to execute when the module is right-clicked. |
| **on-update** | string |  | Command to execute when the module is updated. |
| **on-scroll-up** | string |  | Command to execute when performing a scroll up on the module. This replaces the default behaviour of brightness control. |
| **on-scroll-down** | string |  | Command to execute when performing a scroll down on the module. This replaces the default behaviour of brightness control. |
| **smooth-scrolling-threshold** | double |  | Threshold to be used when scrolling. |
| **reverse-scrolling** | bool | false | Option to reverse the scroll direction for devices other than a mouse (touchpad, trackpad, etc). |
| **reverse-mouse-scrolling** | bool | false | Option to reverse the scroll direction for mice. |
| **scroll-step** | float | 1.0 | The speed at which to change the brightness when scrolling. |
| **min-brightness** | double | 0.0 | The minimum brightness of the backlight. |
| **tooltip** | bool | true | Option to disable tooltip on hover. |
| **tooltip-format** | string |  | Text to be displayed in the tooltip. |
| **menu** | string |  | Action that popups the menu. |
| **menu-file** | string |  | Location of the menu descriptor file. There need to be an element of type GtkMenu with id **menu** |
| **menu-actions** | array |  | The actions corresponding to the buttons of the menu. |
| **expand** | bool | false | Enables this module to consume all left over space dynamically. |

# FORMAT REPLACEMENTS

**{percent}**: The current brightness in percent.

**{percent_exp}**: The current brightness in percent, adjusted with a power curve to better match perceived brightness.

**{icon}**: The icon from **format-icons** chosen according to **{percent}**.

**{icon_exp}**: The icon from **format-icons** chosen according to **{percent_exp}**.

# EXAMPLE:

    "backlight": {
    	"device": "intel_backlight",
    	"format": "{percent}% {icon}",
    	"format-icons": ["", ""]
    }

# STYLE

- **\#backlight**
