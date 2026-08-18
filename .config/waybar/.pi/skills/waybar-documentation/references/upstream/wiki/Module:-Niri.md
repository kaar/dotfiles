> [!NOTE]
> This page is **auto-generated from [`man/waybar-niri-window.5.scd`](https://github.com/Alexays/Waybar/blob/master/man/waybar-niri-window.5.scd), [`man/waybar-niri-workspaces.5.scd`](https://github.com/Alexays/Waybar/blob/master/man/waybar-niri-workspaces.5.scd)** on the `master` branch.
> Do not edit it here — changes will be overwritten on the next sync.
> To update it, edit the man page(s) and open a PR.

# niri/window

## DESCRIPTION

The **window** module displays the title of the currently focused window in niri.

## CONFIGURATION

Addressed by **niri/window**

| **Option** | **Typeof** | **Default** | **Description** |
|:--:|:--:|:--:|:--:|
| **format** | string | {title} | The format, how information should be displayed. On {} the current window title is displayed. |
| **rewrite** | object |  | Rules to rewrite window title. See **rewrite rules**. |
| **separate-outputs** | bool |  | Show the active window of the monitor the bar belongs to, instead of the focused window. |
| **icon** | bool | false | Option to hide the application icon. |
| **icon-size** | integer | 24 | Option to change the size of the application icon. |
| **expand** | bool | false | Enables this module to consume all left over space dynamically. |
| **show-empty** | bool | false | When no window is focused (empty workspace or all windows closed), keep the module visible and render **format** with empty {title}/{app_id} and {col}/{max_col} set to -1. When false (the default), the module is hidden while no window is focused. |

## FORMAT REPLACEMENTS

See the output of "niri msg windows" for examples

**{title}**: The current title of the focused window.

**{app_id}**: The current app ID of the focused window.

**{col}**: The current column of the focused window in the workspace.

**{max_col}**: The maximum column inside the workspace of the focused window.

## REWRITE RULES

**rewrite** is an object where keys are regular expressions and values are rewrite rules if the expression matches. Rules may contain references to captures of the expression.

Regular expression and replacement follow ECMA-script rules.

If no expression matches, the title is left unchanged.

Invalid expressions (e.g., mismatched parentheses) are skipped.

## EXAMPLES

    "niri/window": {
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

# niri/workspaces

## DESCRIPTION

The **workspaces** module displays the currently used workspaces in niri.

## CONFIGURATION

Addressed by **niri/workspaces**

| **Option** | **Typeof** | **Default** | **Description** |
|:--:|:--:|:--:|:--:|
| **all-outputs** | bool | false | If set to false, workspaces will only be shown on the output they are on. If set to true all workspaces will be shown on every output. |
| **sort-by-name** | bool | false | Sort workspaces by name (numeric sort when all names are numbers). Unnamed workspaces fall back to their index on the output. |
| **sort-by-coordinates** | bool | false | Sort workspaces by output and index. If both **sort-by-name** and **sort-by-coordinates** are true, sorting by name is applied. |
| **sort-by-id** | bool | false | Sort workspaces by id, taking precedence over other sort options. |
| **sort-by-number** | bool | false | Deprecated alias for **sort-by-id**; prefer **sort-by-id** instead. |

If none of the sorting options are enabled, workspaces keep their output/index order.

| **Option** | **Typeof** | **Default** | **Description** |
|:--:|:--:|:--:|:--:|
| **format** | string | {value} | The format, how information should be displayed. |
| **format-icons** | array |  | Based on the workspace name, index and state, the corresponding icon gets selected. See **icons**. |
| **disable-click** | bool | false | If set to false, you can click to change workspace. If set to true this behaviour is disabled. |
| **enable-bar-scroll** | bool | false | If set to false, you can't scroll to cycle throughout workspaces from the entire bar. If set to true this behaviour is enabled. |
| **disable-markup** | bool | false | If set to true, button label will escape pango markup. |
| **current-only** | bool | false | If set to true, only the active or focused workspace will be shown. |
| **display-condition** | string | "show-all" | oneof: "show-all", "keep-named", "only-populated" Specifies the conditions for showing workspace widgets. **show-all**: displays widgets for all workspaces. **keep-named**: always displays named workspaces, irrespective of whether they contain windows or not. **only-populated**: only displays widgets for workspaces that have windows. |
| **hide-empty** | bool | false | If set to true, empty workspaces will not be shown. |
| **on-update** | string |  | Command to execute when the module is updated. |
| **expand** | bool | false | Enables this module to consume all left over space dynamically. |
| **workspace-taskbar** | object |  | Contains settings for the workspace taskbar, which displays app icons within each workspace. |
| **enable** | bool | false | Enables the workspace taskbar mode. |
| **icon-size** | int | 16 | Size of the icons in the workspace taskbar. |
| **ignore-workspaces** | array | \[\] | Regexes to match against workspaces names and index's. If there's a match, the workspace will not be shown. |
| **format-window-separator** | string | " " | Separator used between window representations generated by **window-rewrite**. |
| **window-rewrite** | object | {} | Rules to map window app_id and/or title to a specific string representation (e.g., an icon). Keys are regular expressions matching \`app_id\<regex\>\` and/or \`title\<regex\>\`. Values are the replacement strings, which can contain \`{app_id}\` and \`{title}\` placeholders. |
| **window-rewrite-default** | string | "?" | The default representation for windows that don't match any rule in **window-rewrite**. |

## FORMAT REPLACEMENTS

**{value}**: Name of the workspace, or index for unnamed workspaces, as defined by niri.

**{name}**: Name of the workspace for named workspaces.

**{icon}**: Icon, as defined in **format-icons**.

**{index}**: Index of the workspace on its output.

**{output}**: Output where the workspace is located.

**{total}**: The total number of workspaces.

**{windows}**: Concatenated representation of windows in the workspace, using **window-rewrite** rules and **format-window-separator**.

## ICONS

Additional to workspace name matching, the following **format-icons** can be set.

- **default**: Will be shown, when no string matches are found.

- **focused**: Will be shown, when workspace is focused.

- **active**: Will be shown, when workspace is active on its output.

- **urgent**: Will be shown, when workspace has urgent windows.

- **empty**: Will be shown, when workspace is empty.

## EXAMPLES

    "niri/workspaces": {
        "format": "{icon} {windows}",
        "format-window-separator": "|",
        "window-rewrite-default": "",
        "window-rewrite": {
            "app_id<firefox>": "",
            "app_id<foot>": "",
            "app_id<org.gnome.Nautilus> title<.*Downloads.*>": "",
            "app_id<org.gnome.Nautilus>": ""
        },
        "format-icons": {
            // Named workspaces
            // (you need to configure them in niri)
            "browser": "",
            "discord": "",
            "chat": "<b></b>",

            // Icons by state
            "active": "",
            "default": ""
        }
    }

    "niri/workspaces": {
        "format": "{icon}",
        "workspace-taskbar": {
            "enable": true,
            "icon-size": 18
        }
    }

## Style

- **\#workspaces button**

- **\#workspaces button.focused**: The single focused workspace.

- **\#workspaces button.active**: The workspace is active (visible) on its output.

- **\#workspaces button.urgent**: The workspace has one or more urgent windows.

- **\#workspaces button.empty**: The workspace is empty.

- **\#workspaces button.current_output**: The workspace is from the same output as the bar that it is displayed on.

- **\#workspaces button#niri-workspace-\<name\>**: Workspaces named this, or index for unnamed workspaces.

- **\#workspaces button.niri-workspace**: The main container for the workspace.

- **\#workspaces button .niri-taskbar-btn**: The icon buttons within the taskbar.

- **\#workspaces button .niri-taskbar-btn.focused**: The taskbar icon button of the currently focused window.
