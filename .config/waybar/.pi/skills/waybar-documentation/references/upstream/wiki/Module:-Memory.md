> [!NOTE]
> This page is **auto-generated from [`man/waybar-memory.5.scd`](https://github.com/Alexays/Waybar/blob/master/man/waybar-memory.5.scd)** on the `master` branch.
> Do not edit it here — changes will be overwritten on the next sync.
> To update it, edit the man page(s) and open a PR.

# DESCRIPTION

The **memory** module displays the current memory utilization.

# CONFIGURATION

Addressed by **memory**

| **Option** | **Typeof** | **Default** | **Description** |
|:--:|:--:|:--:|:--:|
| **interval** | integer | 30 | The interval in which the information gets polled. |
| **format** | string | {percentage}% | The format, how information should be displayed. |
| **format-icons** | array/object |  | Based on the current percentage, the corresponding icon gets selected. The order is **low** to **high**. Or by the state if it is an object. |
| **rotate** | integer |  | Positive value to rotate the text label (in 90 degree increments). |
| **states** | object |  | A number of memory utilization states which get activated on certain percentage thresholds. See **waybar-states(5)**. |
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
| **tooltip-format** | string | {used:0.1f}GiB used | The format of the tooltip shown on hover. Supports the same replacements as **format**. |
| **menu** | string |  | Action that popups the menu. |
| **menu-file** | string |  | Location of the menu descriptor file. There need to be an element of type GtkMenu with id **menu** |
| **menu-actions** | array |  | The actions corresponding to the buttons of the menu. |
| **expand** | bool | false | Enables this module to consume all left over space dynamically. |
| **unit** | string | GiB | Used to specify unit for total, swapTotal, used, swapUsed, avail, swapAvail, and swapState. Accepts B, kB, kiB, MB, MiB, GB, GiB, TB, and TiB. |

# FORMAT REPLACEMENTS

**{percentage}**: Percentage of memory in use.

**{swapPercentage}**: Percentage of swap in use.

**{total}**: Amount of total memory available. Defaults to GiB.

**{swapTotal}**: Amount of total swap available. Defaults to GiB.

**{used}**: Amount of used memory. Defaults to GiB.

**{swapUsed}**: Amount of used swap. Defaults to GiB.

**{avail}**: Amount of available memory. Defaults to GiB.

**{swapAvail}**: Amount of available swap. Defaults to GiB.

**{swapState}**: Signals if swap is activated or not

# EXAMPLES

    "memory": {
    	"interval": 30,
    	"format": "{}% ",
    	"max-length": 10
    }

## FORMATTED MEMORY VALUES

    "memory": {
    	"interval": 30,
    	"format": "{used:0.1f}G/{total:0.1f}G "
    }

# STYLE

- **\#memory**
