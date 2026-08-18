> [!NOTE]
> This page is **auto-generated from [`man/waybar-inhibitor.5.scd`](https://github.com/Alexays/Waybar/blob/master/man/waybar-inhibitor.5.scd)** on the `master` branch.
> Do not edit it here — changes will be overwritten on the next sync.
> To update it, edit the man page(s) and open a PR.

# DESCRIPTION

The **inhibitor** module allows one to take an inhibitor lock that logind provides. See **systemd-inhibit**(1) for more information.

# CONFIGURATION

| **Option** | **Typeof** | **Default** | **Description** |
|:--:|:--:|:--:|:--:|
| **what** | string or array |  | The inhibitor lock or locks that should be taken when active. The available inhibitor locks are **idle**, **shutdown**, **sleep**, **handle-power-key**, **handle-suspend-key**, **handle-hibernate-key** and **handle-lid-switch**. |
| **format** | string |  | The format, how the state should be displayed. |
| **format-icons** | array |  | Based on the current state, the corresponding icon gets selected. |
| **rotate** | integer |  | Positive value to rotate the text label (in 90 degree increments). |
| **max-length** | integer |  | The maximum length in character the module should display. |
| **min-length** | integer |  | The minimum length in characters the module should accept. |
| **align** | float |  | The alignment of the label within the module, where 0 is left-aligned and 1 is right-aligned. If the module is rotated, it will follow the flow of the text. |
| **justify** | string |  | The alignment of the text within the module's label, allowing options 'left', 'right', or 'center' to define the positioning. |
| **on-click** | string |  | Command to execute when clicked on the module. A click also toggles the state |
| **on-click-middle** | string |  | Command to execute when middle-clicked on the module using mousewheel. |
| **on-click-right** | string |  | Command to execute when you right-click on the module. |
| **on-update** | string |  | Command to execute when the module is updated. |
| **on-scroll-up** | string |  | Command to execute when scrolling up on the module. |
| **on-scroll-down** | string |  | Command to execute when scrolling down on the module. |
| **smooth-scrolling-threshold** | double |  | Threshold to be used when scrolling. |
| **tooltip** | bool | true | Option to disable tooltip on hover. |
| **menu** | string |  | Action that popups the menu. Cannot be "on-click". |
| **menu-file** | string |  | Location of the menu descriptor file. There need to be an element of type GtkMenu with id **menu** |
| **menu-actions** | array |  | The actions corresponding to the buttons of the menu. |
| **expand** | bool | false | Enables this module to consume all left over space dynamically. |

# FORMAT REPLACEMENTS

**{status}**: status (**activated** or **deactivated**)

**{icon}**: Icon, as defined in **format-icons**

# STYLE

- **\#inhibitor**

- **\#inhibitor.activated**

- **\#inhibitor.deactivated**

# EXAMPLES

    "inhibitor": {
    	"what": "handle-lid-switch",
    	"format": "{icon}",
    	"format-icons": {
    		"activated": "",
    		"deactivated": ""
    	}
    }
