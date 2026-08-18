> [!NOTE]
> This page is **auto-generated from [`man/waybar-dwl-tags.5.scd`](https://github.com/Alexays/Waybar/blob/master/man/waybar-dwl-tags.5.scd), [`man/waybar-dwl-window.5.scd`](https://github.com/Alexays/Waybar/blob/master/man/waybar-dwl-window.5.scd)** on the `master` branch.
> Do not edit it here — changes will be overwritten on the next sync.
> To update it, edit the man page(s) and open a PR.

# dwl/tags

## DESCRIPTION

The **tags** module displays the current state of tags in dwl.

Using this module requires patching dwl with the IPC patch \<https://codeberg.org/dwl/dwl-patches/wiki/ipc\>.

## CONFIGURATION

Addressed by **dwl/tags**

| **Option** | **Typeof** | **Default** | **Description** |
|:--:|:--:|:--:|:--:|
| **num-tags** | uint | 9 | The number of tags that should be displayed. Max 32. This should match the number of tags configured in dwl. |
| **tag-labels** | array |  | The label to display for each tag. |
| **hide-vacant** | bool | false | If set to true, tags without clients and that are not active will be hidden. |
| **disable-click** | bool | false | If set to false, you can left-click to set focused tag. Right-click to toggle tag focus. If set to true this behaviour is disabled. |
| **expand** | bool | false | Enables this module to consume all left over space dynamically. |

## EXAMPLE

    "dwl/tags": {
    	"num-tags": 5
    }

## STYLE

- **\#tags button**

- **\#tags button.occupied**

- **\#tags button.empty**

- **\#tags button.focused**

- **\#tags button.urgent**

- **\#tags button.output**

Note that occupied/focused/urgent/output status may overlap. That is, a tag may be both occupied and focused at the same time.

## SEE ALSO

waybar(5), dwl(1)

# dwl/window

## DESCRIPTION

The **window** module displays the title of the currently focused window in DWL

Using this module requires patching dwl with the IPC patch \<https://codeberg.org/dwl/dwl-patches/wiki/ipc\>.

## CONFIGURATION

Addressed by **dwl/window**

| **Option** | **Typeof** | **Default** | **Description** |
|:--:|:--:|:--:|:--:|
| **format** | string | {} | The format, how information should be displayed. |
| **hide-empty** | bool | false | Option to hide the module when the content would be empty. |
| **hide-inactive** | bool | false | Option to hide the module when the window is unfocused. |
| **rotate** | integer |  | Positive value to rotate the text label (in 90 degree increments). |
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
| **rewrite** | object |  | Rules to rewrite the module format output. See **rewrite rules**. |
| **icon** | bool | false | Option to hide the application icon. |
| **icon-size** | integer | 24 | Option to change the size of the application icon. |
| **expand** | bool | false | Enables this module to consume all left over space dynamically. |

## FORMAT REPLACEMENTS

**{title}**: The title of the focused window.

**{app_id}**: The app_id of the focused window.

**{layout}**: The layout of the focused window.

## REWRITE RULES

**rewrite** is an object where keys are regular expressions and values are rewrite rules if the expression matches. Rules may contain references to captures of the expression.

Regular expression and replacement follow ECMA-script rules.

If no expression matches, the format output is left unchanged.

Invalid expressions (e.g., mismatched parentheses) are skipped.

## STYLE

- **\#window.active**

## EXAMPLES

    "dwl/window": {
    	"format": "{}",
    	"max-length": 50,
    	"rewrite": {
    		"(.*) - Mozilla Firefox": "🌎 $1",
    		"(.*) - zsh": "> [$1]"
    	}
    }
