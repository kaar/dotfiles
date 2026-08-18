> [!NOTE]
> This page is **auto-generated from [`man/waybar-river-tags.5.scd`](https://github.com/Alexays/Waybar/blob/master/man/waybar-river-tags.5.scd), [`man/waybar-river-mode.5.scd`](https://github.com/Alexays/Waybar/blob/master/man/waybar-river-mode.5.scd), [`man/waybar-river-window.5.scd`](https://github.com/Alexays/Waybar/blob/master/man/waybar-river-window.5.scd), [`man/waybar-river-layout.5.scd`](https://github.com/Alexays/Waybar/blob/master/man/waybar-river-layout.5.scd)** on the `master` branch.
> Do not edit it here — changes will be overwritten on the next sync.
> To update it, edit the man page(s) and open a PR.

# river/tags

## DESCRIPTION

The **tags** module displays the current state of tags in river.

## CONFIGURATION

Addressed by **river/tags**

| **Option** | **Typeof** | **Default** | **Description** |
|:--:|:--:|:--:|:--:|
| **num-tags** | uint | 9 | The number of tags that should be displayed. Max 32. |
| **tag-labels** | array |  | The label to display for each tag. |
| **disable-click** | bool | false | If set to false, you can left-click to set focused tag. Right-click to toggle tag focus. If set to true this behaviour is disabled. |
| **set-tags** | array |  | An array of tag bitmasks, one per tag button. Left-clicking a tag sets the focused tags to the corresponding bitmask instead of the single tag. Requires **disable-click** to be false. |
| **toggle-tags** | array |  | An array of tag bitmasks, one per tag button. Right-clicking a tag toggles the corresponding bitmask in the focused tags instead of the single tag. Requires **disable-click** to be false. |
| **expand** | bool | false | Enables this module to consume all left over space dynamically. |
| **hide-vacant** | bool | false | Only show relevant tags: tags that are either focused or have a window on them. |

## EXAMPLE

    "river/tags": {
    	"num-tags": 5
    }

Sticky tag: this enables 5 tags and, to support a sticky tag (tag 32), **set-tags** is given bitmasks with the 32nd bit set so that tag stays selected whichever button is clicked.

    "river/tags": {
    	"num-tags": 5,
    	"set-tags": [
    		2147483649,
    		2147483650,
    		2147483652,
    		2147483656,
    		2147483664
    	]
    }

## STYLE

- **\#tags button**

- **\#tags button.occupied**

- **\#tags button.focused**

- **\#tags button.urgent**

- **\#tags button.output**

- **\#tags button.tag-N**

Note that occupied/focused/urgent/output status may overlap. That is, a tag may be both occupied and focused at the same time.

The **output** style is applied when the river output (e.g. monitor) of the current bar is focused.

## SEE ALSO

waybar(5), river(1)

# river/mode

## DESCRIPTION

The **mode** module displays the current mapping mode of river.

## CONFIGURATION

Addressed by **river/mode**

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
| **menu** | string |  | Action that popups the menu. |
| **menu-file** | string |  | Location of the menu descriptor file. There need to be an element of type GtkMenu with id **menu** |
| **menu-actions** | array |  | The actions corresponding to the buttons of the menu. |
| **expand** | bool | false | Enables this module to consume all left over space dynamically. |

## EXAMPLES

    "river/mode": {
    	"format": " {}"
    }

## STYLE

- **\#mode**

- **\#mode.\<mode\>**

# river/window

## DESCRIPTION

The **window** module displays the title of the currently focused window in river

## CONFIGURATION

Addressed by **river/window**

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
| **tooltip** | bool | true | Option to enable tooltip on hover. The tooltip shows the same text as the module label. |
| **menu** | string |  | Action that popups the menu. |
| **menu-file** | string |  | Location of the menu descriptor file. There need to be an element of type GtkMenu with id **menu** |
| **menu-actions** | array |  | The actions corresponding to the buttons of the menu. |
| **expand** | bool | false | Enables this module to consume all left over space dynamically. |

## EXAMPLES

    "river/window": {
    	"format": "{}"
    }

## STYLE

- **\#window**

- **\#window.focused** Applied when the output this module's bar belongs to is focused.

# river/layout

## DESCRIPTION

The **layout** module displays the current layout in river.

It may not be set until a layout is first applied.

## CONFIGURATION

Addressed by **river/layout**

| **Option** | **Typeof** | **Default** | **Description** |
|:--:|:--:|:--:|:--:|
| **format** | string | {} | The format, how information should be displayed. On {} data gets inserted. |
| **format-icons** | array |  | Based on the current layout, the corresponding icon gets selected. |
| **rotate** | integer |  | Positive value to rotate the text label (in 90 degree increments). |
| **max-length** | integer |  | The maximum length in character the module should display. |
| **min-length** | integer |  | The minimum length in characters the module should accept. |
| **align** | float |  | The alignment of the label within the module, where 0 is left-aligned and 1 is right-aligned. If the module is rotated, it will follow the flow of the text. |
| **justify** | string |  | The alignment of the text within the module's label, allowing options 'left', 'right', or 'center' to define the positioning. |
| **on-click** | string |  | Command to execute when clicked on the module. |
| **on-click-middle** | string |  | Command to execute when middle-clicked on the module using mousewheel. |
| **on-click-right** | string |  | Command to execute when you right-click on the module. |
| **menu** | string |  | Action that popups the menu. |
| **menu-file** | string |  | Location of the menu descriptor file. There need to be an element of type GtkMenu with id **menu** |
| **menu-actions** | array |  | The actions corresponding to the buttons of the menu. |
| **expand** | bool | false | Enables this module to consume all left over space dynamically. |

## FORMAT REPLACEMENTS

**{layout}**: Layout, as defined by your layout generator. By default this will be **rivertile(1)**

**{icon}**: Icon, as defined in **format-icons**

## EXAMPLES

With layout name:

    "river/layout": {
    	"format": "{layout}",
    	"min-length": 4,
    	"align": "right"
    }

With icons, this sets icons for the 4 layouts available in rivertile:

    "river/layout": {
    	"format": "{icon}",
    	"min-length": 3,
    	"format-icons": {
    		"left": "[]=",
    		"bottom": "TTT",
    		"top": "ꓕꓕꓕ",
    		"right": "=[]",
    	}
    }

## STYLE

- **\#layout**

- **\#layout.focused** Applied when the output this module's bar belongs to is focused.

- **\#layout.\<layout\>** Applied when the output this module's bar belongs uses this layout.

## SEE ALSO

waybar(5), river(1), rivertile(1)
