> [!NOTE]
> This page is **auto-generated from [`man/waybar-sway-language.5.scd`](https://github.com/Alexays/Waybar/blob/master/man/waybar-sway-language.5.scd), [`man/waybar-hyprland-language.5.scd`](https://github.com/Alexays/Waybar/blob/master/man/waybar-hyprland-language.5.scd), [`man/waybar-niri-language.5.scd`](https://github.com/Alexays/Waybar/blob/master/man/waybar-niri-language.5.scd), [`man/waybar-mango-language.5.scd`](https://github.com/Alexays/Waybar/blob/master/man/waybar-mango-language.5.scd)** on the `master` branch.
> Do not edit it here — changes will be overwritten on the next sync.
> To update it, edit the man page(s) and open a PR.

# sway/language

## DESCRIPTION

The **language** module displays the current keyboard layout in Sway

## CONFIGURATION

Addressed by **sway/language**

| **Option** | **Typeof** | **Default** | **Description** |
|:--:|:--:|:--:|:--:|
| **format** | string | {} | The format, how layout should be displayed. |
| **hide-single-layout** | bool | false | Defines visibility of the module if a single layout is configured |
| **tooltip-format** | string | {} | The format, how layout should be displayed in tooltip. |
| **tooltip** | bool | true | Option to disable tooltip on hover. |
| **on-click** | string |  | Command to execute when clicked on the module. |
| **on-click-middle** | string |  | Command to execute when you middle clicked on the module using mousewheel. |
| **on-click-right** | string |  | Command to execute when you right clicked on the module. |
| **menu** | string |  | Action that popups the menu. |
| **menu-file** | string |  | Location of the menu descriptor file. There need to be an element of type GtkMenu with id **menu** |
| **menu-actions** | array |  | The actions corresponding to the buttons of the menu. |
| **expand** | bool | false | Enables this module to consume all left over space dynamically. |

## FORMAT REPLACEMENTS

**{short}**: Short name of layout (e.g. "us"). Equals to {}.

**{shortDescription}**: Short description of layout (e.g. "en").

**{long}**: Long name of layout (e.g. "English (Dvorak)").

**{variant}**: Variant of layout (e.g. "dvorak").

**{flag}**: Country flag of layout.

## EXAMPLES

    "sway/language": {
    	"format": "{}",
    	"on-click": "swaymsg input type:keyboard xkb_switch_layout next",
    },

    "sway/language": {
    	"format": "{short} {variant}",
    }

## STYLE

- **\#language**

- **\#language.\<layout-short-name\>** Where **layout-short-name** is the short name of the active layout (e.g. **\#language.us** or **\#language.de**).

# hyprland/language

## DESCRIPTION

The **language** module displays the currently selected language.

## CONFIGURATION

Addressed by **hyprland/language**

| **Option** | **Typeof** | **Default** | **Description** |
|:--:|:--:|:--:|:--:|
| **format** | string | {} | The format, how information should be displayed. |

**format-\<lang\>**  
typeof: string  
Provide an alternative name to display per language where \<lang\> is the language of your choosing. Can be passed multiple times with multiple languages as shown by the example below.

**format-\<lang\>-\<variant\>**  
typeof: string  
Like **format-\<lang\>** but also matches the layout variant, taking precedence over **format-\<lang\>** when both the language and variant match.

| **Option** | **Typeof** | **Default** | **Description** |
|:--:|:--:|:--:|:--:|
| **keyboard-name** | string |  | Specifies which keyboard to use from hyprctl devices output. Using the option that begins with "at-translated-set..." is recommended. |
| **menu** | string |  | Action that popups the menu. |
| **menu-file** | string |  | Location of the menu descriptor file. There need to be an element of type GtkMenu with id **menu** |
| **menu-actions** | array |  | The actions corresponding to the buttons of the menu. |
| **tooltip** | boolean | true | Enables or disables the tooltip for the language module. By default, the tooltip is enabled. Set to **false** to disable. |
| **tooltip-format** | string | {long} | Specifies the format of the tooltip when it is enabled. It follows the same format replacement rules as the **format** key. |
| **tooltip-format-\<lang\>** | string |  | Allows specifying a different tooltip format for each language. The **\<lang\>** should be replaced with the language code. This can be used to provide a custom tooltip for each language. |
| **tooltip-format-\<lang\>-\<variant\>** | string |  | Like **tooltip-format-\<lang\>** but also matches the layout variant, taking precedence over **tooltip-format-\<lang\>** when both the language and variant match. |
| **expand** | bool | false | Enables this module to consume all left over space dynamically. |

## FORMAT REPLACEMENTS

**{short}**: Short name of layout (e.g. "us").

**{shortDescription}**: Short description of layout (e.g. "en").

**{long}**: Long name of layout (e.g. "English (Dvorak)").

**{variant}**: Variant of layout (e.g. "dvorak").

## EXAMPLES

    "hyprland/language": {
    	"format": "Lang: {long}",
    	"format-en": "AMERICA, HELL YEAH!",
    	"format-tr": "As bayrakları",
    	"keyboard-name": "at-translated-set-2-keyboard"
    }

    "hyprland/language": {
    	"format": "{}",
    	"format-en": "US",
    	"format-es": "ES",
    	"tooltip": true,
    	"tooltip-format": "{long}"
    }

    "hyprland/language": {
    	"format": "{}",
    	"format-en": "US",
    	"format-es": "ES",
    	"tooltip": true,
    	"tooltip-format": "{}",
    	"tooltip-format-es": "{Español}",
    	"tooltip-format-en": "{English (american)}"
    }

## STYLE

- **\#language**

- **\#language.\<layout\>** (per-layout class derived from the layout short name, e.g. '.us')

# niri/language

## DESCRIPTION

The **language** module displays the currently selected language in niri.

## CONFIGURATION

Addressed by **niri/language**

| **Option** | **Typeof** | **Default** | **Description** |
|:--:|:--:|:--:|:--:|
| **format** | string | {} | The format, how information should be displayed. |

**format-\<lang\>**  
typeof: string  
Provide an alternative name to display per language where \<lang\> is the language of your choosing. Can be passed multiple times with multiple languages as shown by the example below.

**format-\<lang\>-\<variant\>**  
typeof: string  
Like **format-\<lang\>** but also matches the layout variant, taking precedence over **format-\<lang\>** when both the language and variant match.

| **Option** | **Typeof** | **Default** | **Description** |
|:--:|:--:|:--:|:--:|
| **menu** | string |  | Action that popups the menu. |
| **menu-file** | string |  | Location of the menu descriptor file. There need to be an element of type GtkMenu with id **menu** |
| **menu-actions** | array |  | The actions corresponding to the buttons of the menu. |
| **expand** | bool | false | Enables this module to consume all left over space dynamically. |

## FORMAT REPLACEMENTS

**{short}**: Short name of layout (e.g. "us").

**{shortDescription}**: Short description of layout (e.g. "en").

**{long}**: Long name of layout (e.g. "English (Dvorak)"). Equals to {}.

**{variant}**: Variant of layout (e.g. "dvorak").

## EXAMPLES

    "niri/language": {
    	"format": "Lang: {long}",
    	"format-en": "AMERICA, HELL YEAH!",
    	"format-tr": "As bayrakları"
    }

## STYLE

- **\#language**

Additionally, a CSS class matching the current layout's short name is added to the widget. This allows per-language styling, for example:

    #language.us { color: #00ff00; }
    #language.de { color: #ff0000; }
    #language.fr { color: #0000ff; }

# mango/language

## DESCRIPTION

The **language** module displays the currently active keyboard layout in the Mango compositor.

## CONFIGURATION

Addressed by **mango/language**

| **Option** | **Typeof** | **Default** | **Description** |
|:--:|:--:|:--:|:--:|
| **format** | string | {} | The format, how the layout should be displayed. See **FORMAT REPLACEMENTS**. |
| **format-\<lang\>** | string |  | Provide an alternative format string for a given language. \<lang\> is the short description of the layout (e.g. "us", "de"). The value is used as the replacement for **{}** in the main **format**. This option can be repeated for multiple languages. |
| **format-\<lang\>-\<variant\>** | string |  | Like **format-\<lang\>** but also matches the layout variant, taking precedence over **format-\<lang\>** when both the language and variant match. |
| **menu** | string |  | Action that pops up a menu. |
| **menu-file** | string |  | Location of the menu descriptor file. It must contain an element of type GtkMenu with id **menu**. |
| **menu-actions** | array |  | Actions corresponding to the buttons of the menu. |
| **expand** | bool | false | Enables this module to consume all leftover space dynamically. |

## FORMAT REPLACEMENTS

**{short}**: Short name of the layout (e.g. "us").

**{shortDescription}**: Short description of the layout (same as **{short}** in most cases).

**{long}**: Full name of the layout as reported by Mango (e.g. "English (US)"). The empty positional **{}** in the default format resolves to this value, so the long name is shown when no **format** is specified.

**{variant}**: Variant of the layout, if any.

## EXAMPLES

    "mango/language": {
    	"format": " {long} ",
    	"format-us": "US",
    	"format-de": "DE"
    }

## STYLE

- **\#language**

A CSS class matching the current layout's short name is added to the widget. This allows per‑layout styling:

    #language.us { color: #00ff00; }
    #language.de { color: #ff0000; }
