> [!NOTE]
> This page is **auto-generated from [`man/waybar-sway-workspaces.5.scd`](https://github.com/Alexays/Waybar/blob/master/man/waybar-sway-workspaces.5.scd), [`man/waybar-sway-window.5.scd`](https://github.com/Alexays/Waybar/blob/master/man/waybar-sway-window.5.scd), [`man/waybar-sway-mode.5.scd`](https://github.com/Alexays/Waybar/blob/master/man/waybar-sway-mode.5.scd), [`man/waybar-sway-scratchpad.5.scd`](https://github.com/Alexays/Waybar/blob/master/man/waybar-sway-scratchpad.5.scd)** on the `master` branch.
> Do not edit it here — changes will be overwritten on the next sync.
> To update it, edit the man page(s) and open a PR.

# sway/workspaces

## DESCRIPTION

The **workspaces** module displays the currently used workspaces in Sway.

## CONFIGURATION

Addressed by **sway/workspaces**

| **Option** | **Typeof** | **Default** | **Description** |
|:--:|:--:|:--:|:--:|
| **all-outputs** | bool | false | If set to false, workspaces will only be shown on the output they are on. If set to true all workspaces will be shown on every output. |
| **format** | string | {value} | The format, how information should be displayed. |
| **format-for-negative-index** | string | **format** | An alternative format, which will be used for workspaces with no explict or negative index ("num" in sway terms). Requires **format** to be set. |
| **format-icons** | array |  | Based on the workspace name and state, the corresponding icon gets selected. See **icons**. |
| **disable-scroll** | bool | false | If set to false, you can scroll to cycle through workspaces. If set to true this behaviour is disabled. |
| **reverse-scroll** | bool | false | If set to false, scrolling up will switch to the previous workspace and scrolling down will switch to the next workspace. If set to true, the behavior will be reversed. |
| **disable-click** | bool | false | If set to false, you can click to change workspace. If set to true this behaviour is disabled. |
| **smooth-scrolling-threshold** | double |  | Threshold to be used when scrolling. |
| **disable-scroll-wraparound** | bool | false | If set to false, scrolling on the workspace indicator will wrap around to the first workspace when reading the end, and vice versa. If set to true this behavior is disabled. |
| **enable-bar-scroll** | bool | false | If set to false, you can't scroll to cycle throughout workspaces from the entire bar. If set to true this behaviour is enabled. |
| **disable-markup** | bool | false | If set to true, button label will escape pango markup. |
| **current-only** | bool | false | If set to true. Only focused workspaces will be shown. |
| **ignore-workspaces** | array | empty | List of regular expressions. Workspaces whose name matches any of the given patterns are not shown. |
| **persistent-workspaces** | json (see below) | empty | Lists workspaces that should always be shown, even when non-existent |
| **on-update** | string |  | Command to execute when the module is updated. |
| **disable-auto-back-and-forth** | bool |  | Whether to disable **workspace_auto_back_and_forth** when clicking on workspaces. If this is set to **true**, clicking on a workspace you are already on won't do anything, even if **workspace_auto_back_and_forth** is enabled in the Sway configuration. |
| **no-switch-output** | bool |  | Whether to disable switching output when clicking on workspaces. If this is set to **true**, then clicking on a workspace on a different output will bring it to the current output instead of switching to that output. |
| **alphabetical_sort** | bool |  | Whether to sort workspaces alphabetically. Please note this can make "swaymsg workspace prev/next" move to workspaces inconsistent with the ordering shown in Waybar. |
| **custom-sort** | array | \[\] | Defines an explicit ordering for workspace names. Entries earlier in the array appear first. Both full names and the trimmed portion after ":" are matched. Any workspace not listed here falls back to the default ordering (or alphabetical ordering when **alphabetical_sort** is true). |

warp-on-scroll:  
typeof: bool  
default: true  
If set to false, you can scroll to cycle through workspaces without mouse warping being enabled. If set to true this behaviour is disabled.

| **Option** | **Typeof** | **Default** | **Description** |
|:--:|:--:|:--:|:--:|
| **window-rewrite** | object |  | Regex rules to map window class to an icon or preferred method of representation for a workspace's window. Keys are the rules, while the values are the methods of representation. Rules may specify \`class\<...\>\`, \`title\<...\>\`, or both in order to fine-tune the matching. You may assign an empty value to a rule to have it ignored from generating any representation in workspaces. For Wayland windows \`class\` is matched against the \`app_id\`, and for X11 windows against the \`class\` property. |
| **window-rewrite-default** | string | "?" | The default method of representation for a workspace's window. This will be used for windows whose classes do not match any of the rules in **window-rewrite**. |
| **format-window-separator** | string | " " | The separator to be used between windows in a workspace. |
| **expand** | bool | false | Enables this module to consume all left over space dynamically. |
| **output-classes** | array |  | Specify additional CSS classes to be added to workspace indicators based on the output on which the associated workspace is located. Keys are output names and values are class names like **\${output}: {output-class}**. Assignment in config is used to keep the stylesheet independent of the available outputs. |

## FORMAT REPLACEMENTS

**{value}**: Name of the workspace, as defined by sway.

**{name}**: Number stripped from workspace value.

**{icon}**: Icon, as defined in **format-icons**.

**{index}**: Index of the workspace.

**{output}**: Output where the workspace is located.

**{windows}**: Result from window-rewrite

## ICONS

Additional to workspace name matching, the following **format-icons** can be set.

- **default**: Will be shown, when no string matches are found.

- **urgent**: Will be shown, when workspace is flagged as urgent

- **focused**: Will be shown, when workspace is focused

- **persistent**: Will be shown, when workspace is persistent.

- **high-priority-named**: Icons by names will be shown always for those workspaces, independent by state.

## PERSISTENT WORKSPACES

Each entry of **persistent_workspace** names a workspace that should always be shown. Associated with that value is a list of outputs indicating **where** the workspace should be shown, an empty list denoting all outputs.

    "sway/workspaces": {
    	"persistent-workspaces": {
    		"3": [], // Always show a workspace with name '3', on all outputs if it does not exist
    		"4": ["eDP-1"], // Always show a workspace with name '4', on output 'eDP-1' if it does not exist
    		"5": ["eDP-1", "DP-2"] // Always show a workspace with name '5', on outputs 'eDP-1' and 'DP-2' if it does not exist
    		"6": ["MonitorMaker 3000 ABC0123"], // Always show a workspace with name '6' on outputs with an identifier 'MonitorMaker 3000 ABC0123' (usually a triple of vendor/model/serial)
    	}
    }

n.b.: the list of outputs can be obtained from command line using **swaymsg -t get_outputs**

## EXAMPLES

    "sway/workspaces": {
    	"disable-scroll": true,
    	"all-outputs": true,
    	"format": "{name}: {icon}",
    	"format-icons": {
    		"1": "",
    		"2": "",
    		"3": "",
    		"4": "",
    		"5": "",
    		"high-priority-named": [ "1", "2" ],
    		"urgent": "",
    		"focused": "",
    		"default": ""
    	}
    }

    "sway/workspaces": {
      "format": "<span size='larger'>{name}</span> {windows}",
      "format-window-separator": " | ",
      "window-rewrite-default": "{name}",
      "window-rewrite": {
        "class<firefox>": "",
        "class<kitty>": "k",
    	"title<.* - (.*) - VSCodium>": "codium $1"  // captures part of the window title and formats it into output
      }
    }

    "sway/workspaces": {
    	"format": "{index} - {name}",
    	"format-for-negative-index": "{name}"
    }

## Style

- **\#workspaces button**

- **\#workspaces button.visible**

- **\#workspaces button.focused**

- **\#workspaces button.urgent**

- **\#workspaces button.persistent**

- **\#workspaces button.empty**

- **\#workspaces button.current_output**

- **\#workspaces button#sway-workspace-\${name}**

- **\#workspaces button.\${output-class}**

# sway/window

## DESCRIPTION

The **window** module displays the title of the currently focused window in Sway

## CONFIGURATION

Addressed by **sway/window**

| **Option** | **Typeof** | **Default** | **Description** |
|:--:|:--:|:--:|:--:|
| **format** | string | {} | The format, how information should be displayed. |
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
| **all-outputs** | bool | false | Option to show the focused window along with its workspace styles on all outputs. |
| **offscreen-css** | bool | false | Only effective when all-outputs is true. Adds style according to present windows on unfocused outputs instead of showing the focused window and style. |
| **offscreen-css-text** | string |  | Only effective when both all-outputs and offscreen-style are true. On screens currently not focused, show the given text along with that workspace styles. |
| **show-focused-workspace-name** | bool | false | If the workspace itself is focused and the workspace contains nodes or floating_nodes, show the workspace name. If not set, text remains empty but styles according to nodes in the workspace are still applied. |
| **show-hidden-marks** | bool | false | For the **{marks}** format replacement, include hidden marks that start with an underscore. |
| **rewrite** | object |  | Rules to rewrite the module format output. See **rewrite rules**. |
| **icon** | bool | false | Option to display the application icon. |
| **icon-size** | integer | 24 | Option to change the size of the application icon. |
| **icon-spacing** | integer | 8 | Spacing between the application icon and the label. |
| **swap-icon-label** | bool | false | Option to swap the order of the application icon and the label. |
| **expand** | bool | false | Enables this module to consume all left over space dynamically. |

## FORMAT REPLACEMENTS

**{title}**: The title of the focused window.

**{app_id}**: The app_id of the focused window.

**{shell}**: The shell of the focused window. It's 'xwayland' when the window is running through xwayland, otherwise, it's 'xdg-shell'.

**{marks}**: Marks of the window.

## REWRITE RULES

**rewrite** is an object where keys are regular expressions and values are rewrite rules if the expression matches. Rules may contain references to captures of the expression.

Regular expression and replacement follow ECMA-script rules.

If no expression matches, the format output is left unchanged.

Invalid expressions (e.g., mismatched parentheses) are skipped.

## EXAMPLES

    "sway/window": {
    	"format": "{}",
    	"max-length": 50,
    	"rewrite": {
    		"(.*) - Mozilla Firefox": "🌎 $1",
    		"(.*) - zsh": "> [$1]"
    	}
    }

## STYLE

- **\#window**

The following classes are applied to the entire Waybar rather than just the window widget:

- **window#waybar.empty** When no windows are in the workspace, or screen is not focused and offscreen-css option is not set

- **window#waybar.solo** When one tiled window is in the workspace

- **window#waybar.floating** When there are only floating windows in the workspace

- **window#waybar.stacked** When there is more than one window in the workspace and the workspace layout is stacked

- **window#waybar.tabbed** When there is more than one window in the workspace and the workspace layout is tabbed

- **window#waybar.tiled** When there is more than one window in the workspace and the workspace layout is splith or splitv

- **window#waybar.\<app_id\>** Where **app_id** is the app_id or **instance** name like (**chromium**) of the only window in the workspace

These additional classes are applied to the whole Waybar (an element with the name **window** and the id **waybar**) rather than to the module widget itself (an element with the name **box** and the id **window**). In most cases you therefore want to target **window#waybar.\<stylename\> \#window** to style the module.

Switching layouts does not change the style unless the focus is changed. Sway does not provide events for layout switching and the module does not poll.

# sway/mode

## DESCRIPTION

The **mode** module displays the current binding mode of Sway

## CONFIGURATION

Addressed by **sway/mode**

| **Option** | **Typeof** | **Default** | **Description** |
|:--:|:--:|:--:|:--:|
| **format** | string | {} | The format, how information should be displayed. On {} data gets inserted. |
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
| **menu** | string |  | Action that popups the menu. |
| **menu-file** | string |  | Location of the menu descriptor file. There need to be an element of type GtkMenu with id **menu** |
| **menu-actions** | array |  | The actions corresponding to the buttons of the menu. |
| **expand** | bool | false | Enables this module to consume all left over space dynamically. |

## EXAMPLES

    "sway/mode": {
    	"format": " {}",
    	"max-length": 50
    }

## STYLE

- **\#mode**

# sway/scratchpad

## DESCRIPTION

The **scratchpad** module displays the scratchpad status in Sway

## CONFIGURATION

Addressed by **sway/scratchpad**

| **Option** | **Typeof** | **Default** | **Description** |
|:--:|:--:|:--:|:--:|
| **format** | string | {icon} {count} | The format, how information should be displayed. |
| **show-empty** | bool | false | Option to show module when scratchpad is empty. |
| **format-icons** | array/object |  | Based on the current scratchpad window counts, the corresponding icon gets selected. |
| **tooltip** | bool | true | Option to disable tooltip on hover. |
| **tooltip-format** | string | {app}: {title} | The format, how information in the tooltip should be displayed. |
| **menu** | string |  | Action that popups the menu. |
| **menu-file** | string |  | Location of the menu descriptor file. There need to be an element of type GtkMenu with id **menu** |
| **menu-actions** | array |  | The actions corresponding to the buttons of the menu. |
| **expand** | bool | false | Enables this module to consume all left over space dynamically. |

## FORMAT REPLACEMENTS

**{icon}**: Icon, as defined in **format-icons**.

**{count}**: Number of windows in the scratchpad.

**{app}**: Name of the application in the scratchpad.

**{title}**: Title of the application in the scratchpad.

## EXAMPLES

    "sway/scratchpad": {
    	"format": "{icon} {count}",
    	"show-empty": false,
    	"format-icons": ["", ""],
    	"tooltip": true,
    	"tooltip-format": "{app}: {title}"
    }

## STYLE

- **\#scratchpad**

- **\#scratchpad.empty**
