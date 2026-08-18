> [!NOTE]
> This page is **auto-generated from [`man/waybar-disk.5.scd`](https://github.com/Alexays/Waybar/blob/master/man/waybar-disk.5.scd)** on the `master` branch.
> Do not edit it here — changes will be overwritten on the next sync.
> To update it, edit the man page(s) and open a PR.

# DESCRIPTION

The **disk** module displays information of multiple disks.

# CONFIGURATION

Addressed by **disk**

| **Option** | **Typeof** | **Default** | **Description** |
|:--:|:--:|:--:|:--:|
| **interval** | integer | 30 | The interval in which the information gets polled. |
| **format** | string | "{}%" | The format, how information for each disk should be displayed. Note: in the default the positional field "{}" resolves to **{percentage_free}**. |
| **rotate** | integer |  | Positive value to rotate the text label (in 90 degree increments). |
| **states** | object |  | A number of disk utilization states that get activated on certain percentage thresholds (percentage_used). See **waybar-states(5)**. |
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
| **path** | string | "/" | Deprecated path of filesystem or mountpoint to monitor. |
| **paths** | array | \["/"\] | Array of paths residing in the filesystem or mountpoint for which the information should be displayed. |
| **header** | string | "" | Text to appear before the disk information defined in the format. |
| **separator** | string | " " | Separator string between multiple disk information. |
| **smooth-scrolling-threshold** | double |  | Threshold to be used when scrolling. |
| **tooltip** | bool | true | Option to disable tooltip on hover. |
| **tooltip-format** | string | "{used} used out of {total} on {path} ({percentage_used}%)" | The format of the information displayed in the tooltip. |
| **unit** | string |  | Use with specific_free, specific_used, and specific_total to force calculation to always be in a certain unit. Accepts kB, kiB, MB, Mib, GB, GiB, TB, TiB. |
| **menu** | string |  | Action that popups the menu. |
| **menu-file** | string |  | Location of the menu descriptor file. There need to be an element of type GtkMenu with id **menu** |
| **menu-actions** | array |  | The actions corresponding to the buttons of the menu. |
| **expand** | bool | false | Enables this module to consume all left over space dynamically. |

# FORMAT REPLACEMENTS

**{percentage_used}**: Percentage of disk in use.

**{percentage_free}**: Percentage of free disk space

**{total}**: Total amount of space on the disk, partition, or mountpoint. Automatically selects unit based on size remaining.

**{used}**: Amount of used disk space. Automatically selects unit based on size remaining.

**{free}**: Amount of available disk space for normal users. Automatically selects unit based on size remaining.

**{path}**: The path for each disk specified in the configuration.

**{specific_total}**: Total amount of space on the disk, partition, or mountpoint in a specific unit. Defaults to bytes.

**{specific_used}**: Amount of used disk space in a specific unit. Defaults to bytes.

**{specific_free}**: Amount of available disk space for normal users in a specific unit. Defaults to bytes.

# NUMBER FORMAT MODIFIERS

**{total}**, **{used}** and **{free}** auto-scale with a binary prefix (KiB, GiB, …). Their rendering can be tuned with fmt-style modifiers, e.g. **"{free:\>}"** or **"{free:G}"**, combined in any order:

**\<**, **=**, **\>**: Alignment/padding (left, column-align, right).

**u** / **U**: Hide (**u**) or show (**U**) the unit suffix. Shown by default with an auto scale, hidden by default when a scale is forced.

**\#**, **k**, **M**, **G**, **T**, **P**: Force a fixed scale instead of auto-selecting (**\#** = base scale). Forcing a scale hides the scale prefix and, by default, the unit. E.g. **"{free:G}"** always shows gibibytes.

**i**: Force integer display (no decimals).

**b** / **B**: Force decimal base 1000 (**b**) or binary base 1024 (**B**); disk values are binary by default.

A trailing number is a fixed width for the coefficient when a scale is forced; overflow is shown as **\#** characters (e.g. **"{free:=3#}"** → **\###**).

# EXAMPLES

    "disk": {
    	"interval": 30,
    	"format": "{percentage_free}% free on {path}",
    }

    "disk": {
    	"interval": 30,
    	"format": "{percentage_free}% free on {path}",
    	"header": "Disks: ",
    	"paths": ["/", "/home"],
    	"separator": " ",
    }

    "disk": {
    	"interval": 30,
    	"paths": ["/"],
    	"format": "{specific_free:0.2f} GB out of {specific_total:0.2f} GB available. Alternatively {free} out of {total} available",
    	"unit": "GB"
    }

    	// 1434.25 GB out of 2000.00 GB available. Alternatively 1.4TiB out of 1.9TiB available.

# STYLE

- **\#disk**
