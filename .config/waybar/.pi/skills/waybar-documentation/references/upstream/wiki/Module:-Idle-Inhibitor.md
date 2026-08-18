> [!NOTE]
> This page is **auto-generated from [`man/waybar-idle-inhibitor.5.scd`](https://github.com/Alexays/Waybar/blob/master/man/waybar-idle-inhibitor.5.scd)** on the `master` branch.
> Do not edit it here — changes will be overwritten on the next sync.
> To update it, edit the man page(s) and open a PR.

# DESCRIPTION

The **idle_inhibitor** module can inhibit the idle behavior such as screen blanking, locking, and screensaver, also known as "presentation mode".

# CONFIGURATION

| **Option** | **Typeof** | **Default** | **Description** |
|:--:|:--:|:--:|:--:|
| **format** | string |  | The format, how the state should be displayed. |
| **format-icons** | array |  | Based on the current state, the corresponding icon gets selected. |
| **rotate** | integer |  | Positive value to rotate the text label (in 90 degree increments). |
| **max-length** | integer |  | The maximum length in character the module should display. |
| **min-length** | integer |  | The minimum length in characters the module should accept. |
| **align** | float |  | The alignment of the label within the module, where 0 is left-aligned and 1 is right-aligned. If the module is rotated, it will follow the flow of the text. |
| **justify** | string |  | The alignment of the text within the module's label, allowing options 'left', 'right', or 'center' to define the positioning. |
| **on-click** | string |  | Command to execute when clicked on the module. A click also toggles the state (enable only if dynamic timeouts are enabled). |
| **on-click-middle** | string |  | Command to execute when middle-clicked on the module using mousewheel. (reset the timeout to the initial value if dynamic timeouts are enabled). |
| **on-click-right** | string |  | Command to execute when you right-click on the module. (deactivate the inhibit if dynamic timeouts are enabled). |
| **on-update** | string |  | Command to execute when the module is updated. |
| **on-scroll-up** | string |  | Command to execute when scrolling up on the module. (increase the timeout if dynamic timeouts are enabled). |
| **on-scroll-down** | string |  | Command to execute when scrolling down on the module. (decrease the timeout if dynamic timeouts are enabled). |
| **smooth-scrolling-threshold** | double |  | Threshold to be used when scrolling. |
| **start-activated** | bool | **false** | Whether the inhibit should be activated when starting waybar. |
| **timeout** | double |  | The number of minutes the inhibition should last. |
| **timeout-step** | double | 10 | The number of minutes to add or subtract when scrolling (when dynamic timeouts are enabled). |
| **dynamic-timeouts** | bool | false | Option to enable dynamic timeouts. The legacy singular spelling **dynamic-timeout** is also accepted as an alias. |
| **wait-for-activity** | bool | **false** | When enabled, the idle inhibitor remains active as long as there is keyboard or mouse activity on the bar. If there is no activity for the duration specified in **timeout**, the inhibitor will automatically toggle off. This option requires **timeout** to be set. |
| **signal** | integer |  | The signal number used to toggle the idle inhibitor externally. The number is valid between 1 and N, where **SIGRTMIN+N** = **SIGRTMAX**. Use \`pkill -SIGRTMIN+N waybar\` to toggle the idle inhibitor from scripts or keybindings. |
| **tooltip** | bool | true | Option to disable tooltip on hover. |
| **tooltip-format-activated** | string |  | This format is used when the inhibit is activated. |
| **tooltip-format-deactivated** | string |  | This format is used when the inhibit is deactivated. |
| **menu** | string |  | Action that popups the menu. Cannot be "on-click". |
| **menu-file** | string |  | Location of the menu descriptor file. There need to be an element of type GtkMenu with id **menu** |
| **menu-actions** | array |  | The actions corresponding to the buttons of the menu. |
| **expand** | bool | false | Enables this module to consume all left over space dynamically. |

# FORMAT REPLACEMENTS

**{status}**: status (**activated** or **deactivated**)

**{icon}**: Icon, as defined in **format-icons**

**{timeout}**: Timeout in minutes

**{timeleft}**: Time left in minutes

# EXAMPLES

Basic usage with timeout:

    "idle_inhibitor": {
    	"format": "{icon}",
    	"format-icons": {
    		"activated": "",
    		"deactivated": ""
    	},
    	"timeout": 30.5
    }

With dynamic timeouts (scroll to adjust the timeout):

    "idle_inhibitor": {
    	"format": "{status} {timeleft}/{timeout}",
    	"format-icons": {
    		"activated": "",
    		"deactivated": ""
    	},
    	"timeout": 480,
    	"dynamic-timeouts": true,
    	"timeout-step": 10
    }

With external control via signals (can be toggled with \`pkill -SIGRTMIN+8 waybar\`):

    "idle_inhibitor": {
    	"format": "{icon}",
    	"format-icons": {
    		"activated": "",
    		"deactivated": ""
    	},
    	"signal": 8
    }

With wait-for-activity feature:

    "idle_inhibitor": {
    	"format": "{icon}",
    	"format-icons": {
    		"activated": "",
    		"deactivated": ""
    	},
    	"timeout": 5.0,
    	"wait-for-activity": true
    }

# STYLE

- **\#idle_inhibitor**

- **\#idle_inhibitor.activated**

- **\#idle_inhibitor.deactivated**
