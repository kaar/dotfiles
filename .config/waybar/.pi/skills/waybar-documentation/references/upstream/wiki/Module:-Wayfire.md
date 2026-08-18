> [!NOTE]
> This page is **auto-generated from [`man/waybar-wayfire-window.5.scd`](https://github.com/Alexays/Waybar/blob/master/man/waybar-wayfire-window.5.scd), [`man/waybar-wayfire-workspaces.5.scd`](https://github.com/Alexays/Waybar/blob/master/man/waybar-wayfire-workspaces.5.scd)** on the `master` branch.
> Do not edit it here — changes will be overwritten on the next sync.
> To update it, edit the man page(s) and open a PR.

# wayfire/window

## DESCRIPTION

The **window** module displays the title of the currently focused window in wayfire.

## CONFIGURATION

Addressed by **wayfire/window**

| **Option** | **Typeof** | **Default** | **Description** |
|:--:|:--:|:--:|:--:|
| **format** | string | {title} | The format, how information should be displayed. On {} the current window title is displayed. |
| **rewrite** | object |  | Rules to rewrite window title. See **rewrite rules**. |
| **icon** | bool | false | Option to hide the application icon. |
| **icon-size** | integer | 24 | Option to change the size of the application icon. |
| **expand** | bool | false | Enables this module to consume all left over space dynamically. |

## FORMAT REPLACEMENTS

See the output of "wayfire msg windows" for examples

**{title}**: The current title of the focused window.

**{app_id}**: The current app ID of the focused window.

## REWRITE RULES

**rewrite** is an object where keys are regular expressions and values are rewrite rules if the expression matches. Rules may contain references to captures of the expression.

Regular expression and replacement follow ECMA-script rules.

If no expression matches, the title is left unchanged.

Invalid expressions (e.g., mismatched parentheses) are skipped.

## EXAMPLES

    "wayfire/window": {
    	"format": "{}",
    	"rewrite": {
    		"(.*) - Mozilla Firefox": "🌎 $1",
    		"(.*) - zsh": "> [$1]"
    	}
    }

## STYLE

- **\#window**

- **window#waybar.empty \#window** When no windows are on the workspace

The following classes are applied to the entire Waybar rather than just the window widget:

- **window#waybar.empty** When no windows are in the workspace

- **window#waybar.solo** When only one window is on the workspace

- **window#waybar.\<app-id\>** Where **app-id** is the app ID of the only window on the workspace

# wayfire/workspaces

## DESCRIPTION

The **workspaces** module displays the currently used workspaces in wayfire.

## CONFIGURATION

Addressed by **wayfire/workspaces**

| **Option** | **Typeof** | **Default** | **Description** |
|:--:|:--:|:--:|:--:|
| **format** | string | {index} | The format, how information should be displayed. |
| **format-icons** | object |  | Based on the workspace name, index and state, the corresponding icon gets selected. See **icons**. |
| **disable-click** | bool | false | If set to false, you can click to change workspace. If set to true this behaviour is disabled. |
| **disable-scroll** | bool | false | If set to false, you can scroll to cycle through workspaces. If set to true this behaviour is disabled. |
| **enable-bar-scroll** | bool | false | If set to false, you can't scroll to cycle through workspaces from the entire bar. If set to true this behaviour is enabled. |
| **disable-markup** | bool | false | If set to true, button label will escape pango markup. |
| **current-only** | bool | false | If set to true, only the active or focused workspace will be shown. |
| **on-update** | string |  | Command to execute when the module is updated. |
| **expand** | bool | false | Enables this module to consume all left over space dynamically. |

## FORMAT REPLACEMENTS

**{icon}**: Icon, as defined in **format-icons**.

**{index}**: Index of the workspace on its output.

**{output}**: Output where the workspace is located.

## ICONS

Additional to workspace name matching, the following **format-icons** can be set.

- **default**: Will be shown, when no string matches are found.

- **focused**: Will be shown, when workspace is focused.

## EXAMPLES

    "wayfire/workspaces": {
    	"format": "{icon}",
    	"format-icons": {
    		"1": "",
    		"2": "",
    		"3": "",
    		"4": "",
    		"5": "",
    		"focused": "",
    		"default": ""
    	}
    }

## Style

- **\#workspaces button**

- **\#workspaces button.focused**: The single focused workspace.

- **\#workspaces button.empty**: The workspace is empty.

- **\#workspaces button.current_output**: The workspace is from the same output as the bar that it is displayed on.
