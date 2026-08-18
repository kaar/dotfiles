> [!NOTE]
> This page is **auto-generated from [`man/waybar-mango-window.5.scd`](https://github.com/Alexays/Waybar/blob/master/man/waybar-mango-window.5.scd), [`man/waybar-mango-workspaces.5.scd`](https://github.com/Alexays/Waybar/blob/master/man/waybar-mango-workspaces.5.scd), [`man/waybar-mango-keymode.5.scd`](https://github.com/Alexays/Waybar/blob/master/man/waybar-mango-keymode.5.scd), [`man/waybar-mango-layout.5.scd`](https://github.com/Alexays/Waybar/blob/master/man/waybar-mango-layout.5.scd)** on the `master` branch.
> Do not edit it here — changes will be overwritten on the next sync.
> To update it, edit the man page(s) and open a PR.

# mango/window

## DESCRIPTION

The **window** module displays the title and app ID of the currently focused window in the Mango compositor.

## CONFIGURATION

Addressed by **mango/window**

| **Option** | **Typeof** | **Default** | **Description** |
|:--:|:--:|:--:|:--:|
| **format** | string | {title} | The format string. See **FORMAT REPLACEMENTS**. |
| **rewrite** | object |  | Rules to rewrite the window title. Each key is a regular expression and its value is the replacement string. Captures can be used with **\$1**, **\$2**, etc. |
| **icon** | bool | false | Whether to show the application icon. |
| **icon-size** | integer | 24 | Size of the application icon in pixels. |
| **expand** | bool | false | Enables the module to consume all leftover space. |
| **max-length** | integer |  | Set maximum length of characters the module can display. |

## FORMAT REPLACEMENTS

**{title}**: The current window title.

**{app_id}**: The app ID of the focused window.

## REWRITE RULES

If the title matches a regular expression from the **rewrite** object, it is replaced by the corresponding value. Regular expression syntax follows ECMAScript rules. Unmatched titles are left unchanged.

## EXAMPLES

    "mango/window": {
    	"format": "{title}",
    	"rewrite": {
    		"(.*) - Mozilla Firefox": "🌎 $1",
    		"(.*) - zsh": "> [$1]"
    	},
    	"icon": true,
    	"icon-size": 20
    }

## STYLE

- **\#window**

The following classes are set on the module's event box (the container that wraps **\#window**), not on **\#window** itself. Target them directly or with a descendant selector such as **.solo \#window**:

- **.empty** – applied when no window is focused (module hidden by default)

- **.solo** – applied when only one window is present on the active workspace

- **.\<app-id\>** – applied when a single window with the given app ID is on the workspace.RE

# mango/workspaces

## DESCRIPTION

The **workspaces** module displays the tags (workspaces) of the Mango compositor. It shows an overview button when the overview mode is active (active tag is 0), and individual tag buttons otherwise.

## CONFIGURATION

Addressed by **mango/workspaces**

| **Option** | **Typeof** | **Default** | **Description** |
|:--:|:--:|:--:|:--:|
| **format** | string | {value} | The format for each tag button. See **FORMAT REPLACEMENTS**. |
| **format-icons** | object |  | Icons to be used instead of the workspace index or name. Keys can be a workspace index (as a string), or one of the following special state keys: **default**, **active**, **urgent**, **empty**. |
| **disable-markup** | bool | false | If true, the button label will not be interpreted as Pango markup. |
| **current-only** | bool | false | If true, only the currently active workspace button is shown. |
| **hide-empty** | bool | false | If true, buttons for empty (client_count == 0) workspaces are hidden, unless the workspace is active. |
| **on-click** | string |  | Command to execute on left click. Typically set to **activate** or **toggle**. |
| **on-click-middle** | string |  | Command for middle click. Same actions as **on-click**. |
| **on-click-right** | string |  | Command for right click. Same actions as **on-click**. |
| **overview-label** | string | "OVERVIEW" | Label shown on the overview button when the overview is active. |
| **expand** | bool | false | Enables the module to consume leftover space. |

## FORMAT REPLACEMENTS

**{value}**: Workspace index (same as **{index}** for unnamed workspaces).

**{name}**: Workspace name (equal to the index for unnamed workspaces in Mango).

**{icon}**: Icon selected from **format-icons** based on workspace index and state.

**{index}**: Numeric index of the workspace.

**{output}**: Name of the output where the workspace is located.

## CLICK ACTIONS

When a tag button is clicked, the action from **on-click** (or its middle/right variants) is evaluated. Supported actions:

- **activate**: dispatch view,\<index\>

- **toggle**: dispatch toggleview,\<index\>

When the overview button is clicked, the actions change to:

- **activate**: dispatch overview

- **toggle**: dispatch toggleoverview

## EXAMPLES

    "mango/workspaces": {
    	"format": "{icon}",
    	"format-icons": {
    		"1": "一",
    		"2": "二",
    		"active": "",
    		"default": "",
    		"urgent": "",
    		"empty": ""
    	},
    	"on-click": "activate",
    	"on-click-right": "toggle",
    	"overview-label": ""
    }

## STYLE

- **\#workspaces button**

- **\#workspaces button.active** – the workspace is active (visible) on its output.

- **\#workspaces button.urgent** – the workspace has at least one urgent window.

- **\#workspaces button.empty** – the workspace contains no clients.

- **\#workspaces button.current_output** – the workspace belongs to the output where the bar is shown.

- **\#workspaces button.overview** – the overview button (visible in overview mode)..RE

# mango/keymode

## DESCRIPTION

The **keymode** module displays the current keyboard mode (e.g. "resize", "default") in the Mango compositor. It is hidden when no mode is active.

## CONFIGURATION

Addressed by **mango/keymode**

| **Option** | **Typeof** | **Default** | **Description** |
|:--:|:--:|:--:|:--:|
| **format** | string | {} | The format, how the mode should be displayed. **{mode}** is replaced by the current mode name. |
| **format-\<mode\>** | string |  | Provide a custom format for a specific keymode. **\<mode\>** is the mode name as reported by Mango (e.g. "resize"). The value can contain **{mode}** as a placeholder. If this option is set, it overrides the main **format** for that mode. |
| **menu** | string |  | Action that pops up a menu. |
| **menu-file** | string |  | Location of the menu descriptor file. |
| **menu-actions** | array |  | Actions for the menu buttons. |
| **expand** | bool | false | Enables the module to consume all leftover space. |

## FORMAT REPLACEMENTS

**{mode}**: The name of the current keymode.

## EXAMPLES

    "mango/keymode": {
    	"format": "[{mode}]",
    	"format-resize": " Resizing"
    }

## STYLE

- **\#keymode**

A CSS class with the current mode name (e.g. **.resize**) is added to the widget, allowing per‑mode styling:

    #keymode.resize { background: #ff0000; }

# mango/layout

## DESCRIPTION

The **layout** module displays the current layout symbol of the monitor (e.g. "S", "M") in the Mango compositor. It supports dynamic CSS classes and custom formats based on the active layout symbol.

## CONFIGURATION

Addressed by **mango/layout**

| **Option** | **Typeof** | **Default** | **Description** |
|:--:|:--:|:--:|:--:|
| **format** | string | {} | The default format, how the layout symbol should be displayed. The positional **{}** (the default) and **{symbol}** are both replaced by the current layout symbol. |
| **format-\<symbol\>** | string | **none** | The custom format to use when a specific layout symbol is active (e.g., **format-S**, **format-M**). Note that the symbol string is strictly case-sensitive. If no match is found, it falls back to **format**. |
| **expand** | bool | false | Enables the module to consume all leftover space. |

## FORMAT REPLACEMENTS

**{symbol}**: The layout symbol reported by Mango (e.g., "S", "M", "Dwindle").

## CUSTOM FORMATS

You can define specific formats for different layouts by appending the exact layout symbol to the **format-** key in your configuration.

For example, if your Mango compositor reports the symbol "S" for a spiral layout and "M" for a master layout, you can use **format-S** and **format-M** to define unique icons or text for each. Keep in mind that JSON keys are case-sensitive, so if the compositor sends "S", the key must be exactly **format-S**.

## STYLE

The layout module provides dynamic CSS classes based on the current layout symbol, allowing you to style each layout differently.

\#layout **.\<symbol\>** - The current layout symbol is dynamically added as a CSS class name (e.g., **.S**, **.M**).

## EXAMPLES

    "mango/layout": {
        "format": "[] {symbol}",
        "format-S": "󰌌 {symbol}",
        "format-M": "󰕰 {symbol}"
    }

### CSS Example

    #layout {
        color: #ffffff;
        padding: 0 5px;
    }

    /* Specific color for the "S" layout */
    #layout.S {
        color: #a6e3a1;
    }

    /* Specific color for the "M" layout */
    #layout.M {
        color: #f38ba8;
    }
