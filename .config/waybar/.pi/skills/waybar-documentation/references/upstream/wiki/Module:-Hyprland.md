> [!NOTE]
> This page is **auto-generated from [`man/waybar-hyprland-window.5.scd`](https://github.com/Alexays/Waybar/blob/master/man/waybar-hyprland-window.5.scd), [`man/waybar-hyprland-workspaces.5.scd`](https://github.com/Alexays/Waybar/blob/master/man/waybar-hyprland-workspaces.5.scd), [`man/waybar-hyprland-submap.5.scd`](https://github.com/Alexays/Waybar/blob/master/man/waybar-hyprland-submap.5.scd), [`man/waybar-hyprland-windowcount.5.scd`](https://github.com/Alexays/Waybar/blob/master/man/waybar-hyprland-windowcount.5.scd)** on the `master` branch.
> Do not edit it here — changes will be overwritten on the next sync.
> To update it, edit the man page(s) and open a PR.

# hyprland/window

## DESCRIPTION

The **window** module displays the title of the currently focused window in Hyprland.

## CONFIGURATION

Addressed by **hyprland/window**

| **Option** | **Typeof** | **Default** | **Description** |
|:--:|:--:|:--:|:--:|
| **format** | string | {title} | The format, how information should be displayed. On {} the current window title is displayed. |
| **max-length** | integer |  | The maximum length in character the module should display. |
| **rewrite** | object |  | Rules to rewrite window title. See **rewrite rules**. |
| **separate-outputs** | bool |  | Show the active window of the monitor the bar belongs to, instead of the focused window. |
| **fallback** | string |  | Text to display when the focused window title is empty (for example when no window is focused). |
| **tooltip-format** | string | (the formatted label text) | The format of the tooltip shown on hover. Supports the same replacements as **format**. Requires **tooltip** to be enabled. When unset, the tooltip falls back to the formatted label text. |
| **icon** | bool | false | Option to hide the application icon. |
| **icon-size** | integer | 24 | Option to change the size of the application icon. |
| **expand** | bool | false | Enables this module to consume all left over space dynamically. |

## FORMAT REPLACEMENTS

See the output of "hyprctl clients" for examples

**{title}**: The current title of the focused window.

**{initialTitle}**: The initial title of the focused window.

**{class}**: The current class of the focused window.

**{initialClass}**: The initial class of the focused window.

## REWRITE RULES

**rewrite** is an object where keys are regular expressions and values are rewrite rules if the expression matches. Rules may contain references to captures of the expression.

Regular expression and replacement follow ECMA-script rules.

If no expression matches, the title is left unchanged.

Invalid expressions (e.g., mismatched parentheses) are skipped.

## EXAMPLES

    "hyprland/window": {
    	"format": "{}",
    	"rewrite": {
    		"(.*) - Mozilla Firefox": "🌎 $1",
    		"(.*) - zsh": "> [$1]"
    	}
    }

## STYLE

- **\#window**

- **window#waybar.empty \#window** When no windows are in the workspace

The following classes are applied to the entire Waybar rather than just the window widget:

- **window#waybar.empty** When no windows are in the workspace

- **window#waybar.solo** When one tiled window is visible in the workspace (floating windows may be present)

- **window#waybar.\<app_id\>** Where **\<app_id\>** is the **class** (e.g. **chromium**) of the solo tiled window in the workspace (use **hyprctl clients** to see classes)

- **window#waybar.floating** When there are only floating windows in the workspace

- **window#waybar.fullscreen** When there is a fullscreen window in the workspace; useful with Hyprland's **fullscreen, 1** mode

- **window#waybar.swallowing** When there is a swallowed window in the workspace

# hyprland/workspaces

## DESCRIPTION

The **workspaces** module displays the currently used workspaces in hyprland compositor.

## CONFIGURATION

Addressed by **hyprland/workspaces**

| **Option** | **Typeof** | **Default** | **Description** |
|:--:|:--:|:--:|:--:|
| **format** | string | {name} | The format, how information should be displayed. |
| **format-icons** | object |  | Based on the workspace ID and state, the corresponding icon gets selected. See **icons**. |
| **window-rewrite** | object |  | Regex rules to map window class to an icon or preferred method of representation for a workspace's window. Keys are the rules, while the values are the methods of representation. Values may use the placeholders {class} and {title} to use the window's original class and/or title respectively. Rules may specify \`class\<...\>\`, \`title\<...\>\`, or both in order to fine-tune the matching. You may assign an empty value to a rule to have it ignored from generating any representation in workspaces. |

This setting is ignored if **workspace-taskbar.enable** is set to true.

| **Option** | **Typeof** | **Default** | **Description** |
|:--:|:--:|:--:|:--:|
| **window-rewrite-default** | string | "?" | The default method of representation for a workspace's window. This will be used for windows whose classes do not match any of the rules in **window-rewrite**. This setting is ignored if **workspace-taskbar.enable** is set to true. |
| **format-window-separator** | string | " " | The separator to be used between windows in a workspace. This setting is ignored if **workspace-taskbar.enable** is set to true. |
| **window-rewrite-group-threshold** | int | 0 | When a workspace contains at least this many windows with the same rewrite result, they are collapsed into a single one using **window-rewrite-group-format**. Set to 0 to disable grouping. This setting is ignored if **workspace-taskbar.enable** is set to true. |
| **window-rewrite-group-format** | string | "{icon}×{count}" | The format used to represent a group of collapsed windows. Available placeholders are {icon} (the icon being grouped) and {count} (how many windows share it). This setting is ignored if **workspace-taskbar.enable** is set to true. |
| **workspace-taskbar** | bool | false | Contains settings for the workspace taskbar, an alternative mode for the workspaces module which displays the window icons as images instead of text. **enable**: Enables the workspace taskbar mode. |
| **update-active-window** | bool | false | If true, the active/focused window will have an 'active' class. Could cause higher CPU usage due to more frequent redraws. |
| **reverse-direction** | bool | false | If true, the taskbar windows will be added in reverse order (right to left if orientation is horizontal, bottom to top if vertical). |
| **active-window-position** | "none" \| "first" \| "last" | "none" | If set to "first", the active window will be moved at the beginning of the taskbar. If set to "last", it will be moved at the end. It will only work if **update-active-window** is set to true. |
| **format** | string | {icon} | Format to use for each window in the workspace taskbar. Available placeholders are {icon} and {title}. |
| **icon-size** | int | 16 | Size of the icons in the workspace taskbar. |
| **max-icons** | int | 0 (unlimited) | Maximum number of icons to show per workspace. When set, duplicate icons (windows with the same class) are removed first, then the list is trimmed to this limit. Set to 0 for unlimited icons. |
| **icon-theme** | string \| array | \[\] | Icon theme to use for the workspace taskbar. If an array is provided, the first theme that is found for a given icon will be used. If no theme is found (or the array is empty), the default icon theme is used. |
| **orientation** | "horizontal" \| "vertical" | horizontal | Direction in which the workspace taskbar is displayed. |
| **ignore-list** | array | \[\] | Regex patterns to match against window class or window title. If a window's class OR title matches any of the patterns, it will not be shown. |
| **on-click-window** | string | "" | Command to run when a window is clicked. Available placeholders are: - {address} Hyprland address of the clicked window. - {button} Pressed button number, see https://api.gtkd.org/gdk.c.types.GdkEventButton.button.html. See https://github.com/Alexays/Waybar/wiki/Module:-Hyprland#workspace-taskbars-example for a full example. |
| **max-windows** | int | 0 (unlimited) | Maximum number of windows to show per workspace. When set, newest windows beyond the limit are not shown. Set to 0 for unlimited windows. |
| **show-special** | bool | false | If set to true, special workspaces will be shown. |
| **special-visible-only** | bool | false | If this and show-special are to true, special workspaces will be shown only if visible. |
| **persistent-only** | bool | false | If set to true, only persistent workspaces will be shown on bar. |
| **persistent-workspaces** | object | empty | Lists workspaces that should always be shown, even when they do not exist. Keys are workspace names and values are arrays of output names on which the workspace should be shown (an empty array means all outputs). See the examples below. Note: for persistent workspaces to actually work you must also declare them in your Hyprland config, e.g. **workspace = 1, monitor:eDP-1, persistent:true**. |
| **all-outputs** | bool | false | If set to false workspaces group will be shown only in assigned output. Otherwise, all workspace groups are shown. |
| **active-only** | bool | false | If set to true, only the active workspace will be shown. |
| **hide-active** | bool | false | If set to true, the active workspace will be hidden. Unless a workspace is persistent or special. |
| **move-to-monitor** | bool | false | If set to true, open the workspace on the current monitor when clicking on a workspace button. Otherwise, the workspace will open on the monitor where it was previously assigned. Analog to using \`focusworkspaceoncurrentmonitor\` dispatcher instead of \`workspace\` in Hyprland. |
| **unique-icons** | bool | false | If set to true, only one instance of each window icon will be shown per workspace. |
| **enable-bar-scroll** | bool | false | If set to false, you can't scroll to cycle throughout workspaces from the entire bar. If set to true this behaviour is enabled. |
| **on-scroll-up** | string |  | Command to execute when scrolling up on the module. This replaces the default behaviour of workspace cycling. |
| **on-scroll-down** | string |  | Command to execute when scrolling down on the module. This replaces the default behaviour of workspace cycling. |
| **ignore-workspaces** | array | \[\] | Regexes to match against workspaces names. If there's a match, the workspace will not be shown. This takes precedence over **show-special**, **all-outputs**, and **active-only**. |
| **sort-by** | string | "default" | If set to number, workspaces will sort by number. If set to name, workspaces will sort by name. If set to id, workspaces will sort by id. If set to special-centered, workspaces will sort by default with special workspaces in the center. If none of those, workspaces will sort with default behavior. |
| **tooltip** | bool | true | Option to disable tooltip on hover. |
| **tooltips** | object |  | Based on the workspace ID and state, the corresponding tooltip gets selected. Selection works the same as **format-icons** do. Format replacements are supported. See **icons**. |
| **expand** | bool | false | Enables this module to consume all left over space dynamically. |

## FORMAT REPLACEMENTS

**{id}**: id of workspace assigned by compositor

**{name}**: workspace name assigned by compositor

**{icon}**: Icon, as defined in **format-icons**.

**{windows}**: The windows in the workspace, formatted according to **window-rewrite** and joined with **format-window-separator**.

## WINDOW REWRITE RULES

The rules in **window-rewrite** are regexes that may match against a window's class, title, or both. There are four categories of rule, distinguished by how they are written in the config:

|                  **Rule**                   | **Category** |
|:-------------------------------------------:|:------------:|
|                **something**                |    Vague     |
|           **class\<something\>**            |  Class-only  |
|           **title\<something\>**            |  Title-only  |
| **class\<something1\> title\<something2\>** |    Hybrid    |

When the config contains only "vague" rules, they are matched against window **classes** only. This is both for backwards compatibility and for performance: matching against the title requires listening to window title changes via Hyprland's IPC, which is unnecessary when no title rule is in use.

When the config contains **at least one** "title-only" or "hybrid" rule, then all "vague" rules match against **both** class and title. This lets you define vague rules where it does not matter whether the class or the title matched.

## ICONS

Additional to workspace name matching, the following **format-icons** can be set.

- **default**: Will be shown, when no string match is found and none of the below conditions have defined icons.

- **active**: Will be shown, when workspace is active

- **special**: Will be shown on non-active special workspaces

- **empty**: Will be shown on non-active, non-special empty persistent workspaces

- **visible**: Will be shown on workspaces that are visible but not active. For example: this is useful if you want your visible workspaces on other monitors to have the same look as active.

- **persistent**: Will be shown on non-empty persistent workspaces

- **urgent**: Will be shown on non-active urgent workspaces

## EXAMPLES

    "hyprland/workspaces": {
    	"format": "{name}: {icon}",
    	"format-icons": {
    		"1": "",
    		"2": "",
    		"3": "",
    		"4": "",
    		"5": "",
    		"active": "",
    		"default": ""
    	},
    	"persistent-workspaces": {
    		"*": 5, // 5 workspaces by default on every monitor
    		"HDMI-A-1": 3 // but only three on HDMI-A-1
    	}
    }

    "hyprland/workspaces": {
    	"format": "{name}: {icon}",
    	"format-icons": {
    		"1": "",
    		"2": "",
    		"3": "",
    		"4": "",
    		"5": "",
    		"active": "",
    		"default": ""
    	},
    	"persistent-workspaces": {
    		"*": [ 2,3,4,5 ], // 2-5 on every monitor
    		"HDMI-A-1": [ 1 ] // but only workspace 1 on HDMI-A-1
    	}
    }

    "hyprland/workspaces": {
    	"format": "{name}n{windows}",
    	"format-window-separator": "n",
    	"window-rewrite-default": "",
    	"window-rewrite": {
    		"title<.*youtube.*>": "", // Windows whose titles contain "youtube"
    		"class<firefox>": "", // Windows whose classes are "firefox"
    		"class<firefox> title<.*github.*>": "", // Windows whose class is "firefox" and title contains "github". Note that "class" always comes first.
    		"foot": "", // Windows that contain "foot" in either class or title. For optimization reasons, it will only match against a title if at least one other window explicitly matches against a title.
    		"code": "󰨞",
    		"title<.* - (.*) - VSCodium>": "codium $1"  // captures part of the window title and formats it into output
    	}
    }

    "hyprland/workspaces": {
    	// Formatting omitted for brevity
    	"ignore-workspaces": [
    		"(special:)?chrome-sharing-indicator"
    	]
    }

    "hyprland/workspaces": {
    	"format": "{icon}",
    	"format-window-separator": ", ",
    	"tooltip": true,
    	"tooltips": {
    		"default": "{name}: {windows}",
    		"empty": "" // Will result in no tooltip
    	}
    	"format-icons": {
    		"1": "",
    		"2": "",
    		"3": "",
    		"4": "",
    		"5": "",
    		"active": "",
    		"default": ""
    	},
    	// Window rewrites omitted for brevity
    }

    "hyprland/workspaces": {
    	"format": "{icon}",
    	"format-window-separator": ", ",
    	"tooltip": true,
    	"tooltips": {
    		"1": "This is the first workspace",
    		"2": "This is the second",
    		"2": "And this is the third"
    	}
    	"format-icons": {
    		"1": "",
    		"2": "",
    		"3": "",
    		"4": "",
    		"5": "",
    		"active": "",
    		"default": ""
    	},
    	// Window rewrites omitted for brevity
    }

## Style

- **\#workspaces**

- **\#workspaces button**

- **\#workspaces button.active**

- **\#workspaces button.empty**

- **\#workspaces button.visible**

- **\#workspaces button.persistent**

- **\#workspaces button.special**

- **\#workspaces button.urgent**

- **\#workspaces button.workspace-hover** (applied while the pointer is over the button)

- **\#workspaces button.\<workspace-name\>** (per-workspace class derived from the workspace name, sanitized to a valid CSS class name, e.g. a workspace named "1" yields '.ws-1'; special workspaces also get the raw name class)

- **\#workspaces button.hosting-monitor** (gets applied if workspace-monitor == waybar-monitor)

- **\#workspaces .workspace-label**

- **\#workspaces .taskbar-window** (each window in the taskbar, only if 'workspace-taskbar.enable' is true)

- **\#workspaces .taskbar-window.active** (applied to the focused window, only if 'workspace-taskbar.update-active-window' is true)

# hyprland/submap

## DESCRIPTION

The **submap** module displays the currently active submap similar to **sway/mode**.

## CONFIGURATION

Addressed by **hyprland/submap**

| **Option** | **Typeof** | **Default** | **Description** |
|:--:|:--:|:--:|:--:|
| **format** | string | {} | The format, how information should be displayed. This format supports two placeholders: **{submap}** for the currently active submap name and **{icon}** for the icon associated with the submap. |
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
| **always-on** | bool | false | Option to display the widget even when there's no active submap. |

**default-submap**  
typeof: string  
default: Default  
Option to set the submap name to display when not in an active submap.

| **Option** | **Typeof** | **Default** | **Description** |
|:--:|:--:|:--:|:--:|
| **icons** | object |  | Based on the submap name, the corresponding icon will be selected from this map and made available as the **{icon}** placeholder in the format string. The keys are submap names, and the values are the icons or strings to display for those submaps. |
| **menu** | string |  | Action that popups the menu. |
| **menu-file** | string |  | Location of the menu descriptor file. There need to be an element of type GtkMenu with id **menu** |
| **menu-actions** | array |  | The actions corresponding to the buttons of the menu. |
| **expand** | bool | false | Enables this module to consume all left over space dynamically. |

## EXAMPLES

    "hyprland/submap": {
    	"format": "{icon} {submap}",
    	"max-length": 8,
    	"tooltip": false,
    	"icons": {
    		"resize": "",
    		"pause": "",
    	}
    }

## STYLE

- **\#submap**

- **\#submap.\<name\>**

# hyprland/windowcount

## DESCRIPTION

The **windowcount** module displays the number of windows in the current Hyprland workspace.

## CONFIGURATION

Addressed by **hyprland/windowcount**

| **Option** | **Typeof** | **Default** | **Description** |
|:--:|:--:|:--:|:--:|
| **format** | string | {} | The format for how information should be displayed. On {} the current workspace window count is displayed. |
| **format-empty** | string |  | Override the format when the workspace contains no windows window |
| **format-windowed** | string |  | Override the format when the workspace contains no fullscreen windows |
| **format-fullscreen** | string |  | Override the format when the workspace contains a fullscreen window |
| **separate-outputs** | bool | true | Show the active workspace window count of the monitor the bar belongs to, instead of the focused workspace. |

## STYLE

- **\#windowcount**

The following classes are applied to the entire Waybar rather than just the windowcount widget:

- **window#waybar.empty** When no windows are in the workspace

- **window#waybar.fullscreen** When there is a fullscreen window in the workspace; useful with Hyprland's **fullscreen, 1** mode

## Screenshots

![](https://user-images.githubusercontent.com/25804378/270065881-acef7b73-e528-4648-82c1-ba70ea9f7804.png)
![Workspace taskbars example](https://github.com/user-attachments/assets/c5387d8b-6612-442a-83af-2a0d881fa6db)
![image](https://github.com/Alexays/Waybar/assets/1778670/6421e9ce-50be-4086-8045-688338d5fbe7)
![image](https://github.com/Alexays/Waybar/assets/1778670/48c58198-aae4-42ac-802a-33b1e3db5e33)
