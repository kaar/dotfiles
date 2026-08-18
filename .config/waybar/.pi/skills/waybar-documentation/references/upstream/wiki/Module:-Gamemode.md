> [!NOTE]
> This page is **auto-generated from [`man/waybar-gamemode.5.scd`](https://github.com/Alexays/Waybar/blob/master/man/waybar-gamemode.5.scd)** on the `master` branch.
> Do not edit it here — changes will be overwritten on the next sync.
> To update it, edit the man page(s) and open a PR.

# DESCRIPTION

The **gamemode** module displays if any game or application is running with  
Feral Gamemode optimizations.

# CONFIGURATION

| **Option** | **Typeof** | **Default** | **Description** |
|:--:|:--:|:--:|:--:|
| **format** | string | {glyph} | The text format. |
| **format-alt** | string | {glyph} {count} | The text format when toggled. |
| **tooltip** | bool | true | Option to disable tooltip on hover. |
| **tooltip-format** | string | Games running: {count} | The text format of the tooltip. |
| **hide-not-running** | bool | true | Defines if the module should be hidden if no games are running. |
| **use-icon** | bool | true | Defines if the module should display a GTK icon instead of the specified **glyph** |
| **glyph** | string | 󰊴 | The string icon to display. Only visible if **use-icon** is set to false. |
| **icon-name** | string | input-gaming-symbolic | The GTK icon to display. Only visible if **use-icon** is set to true. |
| **icon-size** | unsigned integer | 20 | Defines the size of the icons. Set to **0** for auto size. |
| **icon-spacing** | unsigned integer | 4 | Defines the spacing between the icon and the text. |
| **expand** | bool | false | Enables this module to consume all left over space dynamically. |

# FORMAT REPLACEMENTS

**{glyph}**: The string icon glyph to use instead.

**{count}**: The number of games running with gamemode optimizations.

# TOOLTIP FORMAT REPLACEMENTS

**{count}**: The number of games running with gamemode optimizations.

# EXAMPLES

    "gamemode": {
    	"format": "{glyph}",
    	"format-alt": "{glyph} {count}",
    	"glyph": "󰊴",
    	"hide-not-running": true,
    	"use-icon": true,
    	"icon-name": "input-gaming-symbolic",
    	"icon-spacing": 4,
    	"icon-size": 20,
    	"tooltip": true,
    	"tooltip-format": "Games running: {count}"
    }

# STYLE

- **\#gamemode**

- **\#gamemode.running**
