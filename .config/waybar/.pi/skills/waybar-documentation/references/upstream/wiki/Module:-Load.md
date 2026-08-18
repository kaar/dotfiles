> [!NOTE]
> This page is **auto-generated from [`man/waybar-load.5.scd`](https://github.com/Alexays/Waybar/blob/master/man/waybar-load.5.scd)** on the `master` branch.
> Do not edit it here — changes will be overwritten on the next sync.
> To update it, edit the man page(s) and open a PR.

# DESCRIPTION

The **load** module displays the current CPU load.

# CONFIGURATION

Addressed by **load**

| **Option** | **Typeof** | **Default** | **Description** |
|:--:|:--:|:--:|:--:|
| **interval** | integer | 10 | The interval in which the information gets polled. |
| **format** | string | {load1} | The format, how information should be displayed. |
| **rotate** | integer |  | Positive value to rotate the text label (in 90 degree increments). |
| **states** | object |  | A number of load states which get activated on certain thresholds, based on \`load1\`. See **waybar-states(5)**. |
| **max-length** | integer |  | The maximum length in character the module should display. |
| **min-length** | integer |  | The minimum length in characters the module should accept. |
| **align** | float |  | The alignment of the label within the module, where 0 is left-aligned and 1 is right-aligned. If the module is rotated, it will follow the flow of the text. |
| **justify** | string |  | The alignment of the text within the module's label, allowing options 'left', 'right', or 'center' to define the positioning. |
| **on-click** | string |  | Command to execute when clicked on the module. |
| **on-click-middle** | string |  | Command to execute when middle-clicked on the module using mousewheel. |
| **on-click-right** | string |  | Command to execute when you right-click on the module. |
| **on-update** | string |  | Command to execute when the module is updated. |
| **on-scroll-up** | string |  | Command to execute when scrolling up on the module. |
| **on-scroll-down** | string |  | Command to execute when scrolling down on the module. |
| **smooth-scrolling-threshold** | double |  | Threshold to be used when scrolling. |
| **tooltip** | bool | true | Option to disable tooltip on hover. |
| **tooltip-format** | string | Load 1: {load1}\nLoad 5: {load5}\nLoad 15: {load15} | The format of the tooltip shown on hover. Supports the same replacements as **format**. |
| **menu** | string |  | Action that popups the menu. |
| **menu-file** | string |  | Location of the menu descriptor file. There need to be an element of type GtkMenu with id **menu** |
| **menu-actions** | array |  | The actions corresponding to the buttons of the menu. |
| **expand** | bool | false | Enables this module to consume all left over space dynamically. |

# FORMAT REPLACEMENTS

**{}**: Equivalent to \`{load1}\`

**{load1}**: Current CPU load average over the last minute

**{load5}**: Current CPU load average over the last 5 minutes

**{load15}**: Current CPU load average over the last 15 minutes

# EXAMPLES

    "load": {
        "interval": 10,
        "format": "load: {load1}",
        "max-length": 10
    }

    "load": {
        "interval": 1,
        "format": "load: {load1} {load5} {load15}"
    }

# STYLE

- **\#load**
