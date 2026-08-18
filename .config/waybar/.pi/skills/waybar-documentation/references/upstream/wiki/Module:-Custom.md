> [!NOTE]
> This page is **auto-generated from [`man/waybar-custom.5.scd`](https://github.com/Alexays/Waybar/blob/master/man/waybar-custom.5.scd), [`man/waybar-custom-graph.5.scd`](https://github.com/Alexays/Waybar/blob/master/man/waybar-custom-graph.5.scd)** on the `master` branch.
> Do not edit it here — changes will be overwritten on the next sync.
> To update it, edit the man page(s) and open a PR.

# custom

## DESCRIPTION

The **custom** module displays either the output of a script or static text. To display static text, specify only the **format** field.

## CONFIGURATION

Addressed by **custom/\<name\>**

| **Option** | **Typeof** | **Default** | **Description** |
|:--:|:--:|:--:|:--:|
| **exec** | string |  | The path to the script, which should be executed. |
| **exec-if** | string |  | The path to a script, which determines if the script in **exec** should be executed. **exec** will be executed if the exit code of **exec-if** equals 0. |
| **hide-empty-text** | bool |  | Disables the module when output is empty, but format might contain additional static content. |
| **exec-on-event** | bool | true | If an event command is set (e.g. **on-click** or **on-scroll-up**) then re-execute the script after executing the event command. |
| **return-type** | string |  | See **return-type** |
| **interval** | integer or float |  | The interval (in seconds) in which the information gets polled. Minimum value is 0.001 (1ms). Values smaller than 1ms will be set to 1ms. Use **once** if you want to execute the module only on startup. You can update it manually with a signal. If no **interval** or **signal** is defined, it is assumed that the out script loops itself. If a **signal** is defined then the script will run once on startup and will only update with a signal. |
| **restart-interval** | integer or float |  | The restart interval (in seconds). Minimum value is 0.001 (1ms). Values smaller than 1ms will be set to 1ms. Can't be used with the **interval** option, so only with continuous scripts. Once the script exits, it'll be re-executed after the **restart-interval**. |
| **signal** | integer |  | The signal number used to update the module. The number is valid between 1 and N, where **SIGRTMIN+N** = **SIGRTMAX**. If no interval is defined then a signal will be the only way to update the module. |
| **format** | string | {text} | The format, how information should be displayed. On {text} data gets inserted. |
| **format-icons** | array or object or string |  | If the type is an array, then based on the set percentage, the corresponding icon gets selected (the order is **low** to **high**). If the type is an object, then the icon is selected according to the **alt** string from the output. If the type is a string, it is pasted as is. Arrays can be nested into objects: icons are then selected first according to **alt**, then percentage. |
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
| **tooltip-format** | string |  | The tooltip format. If specified, overrides any tooltip output from the script in **exec**. Uses the same format replacements as **format**. |
| **escape** | bool | false | Option to enable escaping of script output. |
| **menu** | string |  | Action that popups the menu. |
| **menu-file** | string |  | Location of the menu descriptor file. There need to be an element of type GtkMenu with id **menu** |
| **menu-actions** | array |  | The actions corresponding to the buttons of the menu. |
| **expand** | bool | false | Enables this module to consume all left over space dynamically. |
| **image-path** | string |  | Path to an image file to display in the module. |
| **image-name** | string |  | Name of a themed icon to display in the module. |
| **icon-size** | integer |  | The size (in pixels) of the image set via **image-path** or **image-name**. |

## RETURN-TYPE

When **return-type** is set to **json**, Waybar expects the **exec**-script to output its data in JSON format. This should look like this:

    {"text": "$text", "alt": "$alt", "tooltip": "$tooltip", "class": "$class", "percentage": $percentage }

The whole JSON object must be printed on a single line. This can be achieved by piping the output of your script through **jq --unbuffered --compact-output**.

The **class** parameter also accepts an array of strings.

To have multiline tooltips, use **\r** in your script to separate the lines. If using PowerShell for scripting, use the standard newline operator "\`n" in double quotes; **\r** and **\n** will not work.

If nothing or an invalid option is specified, Waybar expects i3blocks style output. Values are **newline** separated. This should look like this:

    $text\n$tooltip\n$class*

**class** is a CSS class, to apply different styles in **style.css**

## FORMAT REPLACEMENTS

**{}**: Output of the script. Equivalent to **{text}**.

**{text}**: Output of the script.

**{alt}**: The **alt** value from a json return type.

**{percentage}** Percentage which can be set via a json return type.

**{icon}**: An icon from 'format-icons' according to percentage.

The **{}** placeholder is special: it automatically displays the text output of your script, but it cannot be combined with other placeholders like **{icon}** in the same format string. To display both an icon and text, use **{icon}** together with **{text}** explicitly (e.g. **"format": "{icon} {text}"**).

## EXAMPLES

### Spotify:

    "custom/spotify": {
    	"format": " {text}",
    	"max-length": 40,
    	"interval": 30, // Remove this if your script is endless and write in loop
    	"exec": "$HOME/.config/waybar/mediaplayer.sh 2> /dev/null", // Script in resources folder
    	"exec-if": "pgrep spotify",
    	"return-type": "json"
    }

### mpd:

    "custom/mpd": {
    	"format": "♪ {text}",
    	//"max-length": 15,
    	"interval": 10,
    	"exec": "mpc current",
    	"exec-if": "pgrep mpd",
    	"on-click": "mpc toggle",
    	"on-click-right": "sonata"
    }

### cmus:

    "custom/cmus": {
    	"format": "♪ {text}",
    	//"max-length": 15,
    	"interval": 10,
    	"exec": "cmus-remote -C "format_print '%a - %t'"", // artist - title
    	"exec-if": "pgrep cmus",
    	"on-click": "cmus-remote -u",                        //toggle pause
    	"escape": true                                       //handle markup entities
    }

### Pacman


    "custom/pacman": {
    	"format": "{text}  ",
    	"interval": "once",
    	"exec": "pacman_packages",
    	"on-click": "update-system",
    	"signal": 8
    }

### Alternate Pacman

    "custom/pacman": {
    	"format": "{text}  ",
    	"exec": "checkupdates | wc -l",       // # of updates
    	"exec-if": "exit 0",                  // always run; consider advanced run conditions
    	"on-click": "termite -e 'sudo pacman -Syu'; pkill -SIGRTMIN+8 waybar", // update system
    	"signal": 8
    }

Under the premise that interval is not defined, you can use the signal and update the number of available packages with **pkill -RTMIN+8 waybar**.

## STYLE

- **\#custom-\<name\>**

- **\#custom-\<name\>.\<class\>**

- **\<class\>** can be set by the script. For more information see **return-type**

- **.flat** and **.text-button** are always applied to the module's label.

- **.image-button** is always applied to the module's image (see **image-path**/**image-name**).

## CONTINUOUS SCRIPTS

The **exec** script may be continuous (i.e. contain some kind of infinite loop). The display is updated for each new line of data printed on stdout (following the chosen **return-type**). The **interval** option does not apply to a continuous script; use **restart-interval** instead to restart the script if it stops after some time.

Be aware that some languages buffer their output. If your module displays nothing even though your script works as expected, the output may be held in a buffer. Look up how to flush the output buffer for your language of choice (for example, in Ruby call **\$stdout.flush** after each print).

## OUTPUT NAME

The **exec** script is run with the **WAYBAR_OUTPUT_NAME** environment variable set to the name of the output (monitor) the bar is displayed on.

## TROUBLESHOOTING

**Self-looping module does not show up**

If your module is self-looping and it does not even show up in the bar, check that:

- Its configuration does **not** include an **interval** parameter.

- Output to stdout is not buffered.

**Custom json class not displayed**

If a class set in your custom script is not picked up by **style.css**, ensure that the output carrying the most variables is emitted first.

# custom/graph

## DESCRIPTION

The **custom-graph** module displays a graph with the percentage output of a script.

## CONFIGURATION

Addressed by **custom-graph/\<name\>**

| **Option** | **Typeof** | **Default** | **Description** |
|:--:|:--:|:--:|:--:|
| **exec** | string |  | The path to the script, which should be executed. |
| **exec-if** | string |  | The path to a script, which determines if the script in **exec** should be executed. **exec** will be executed if the exit code of **exec-if** equals 0. |
| **exec-on-event** | bool | true | If an event command is set (e.g. **on-click** or **on-scroll-up**) then re-execute the script after executing the event command. |
| **return-type** | string |  | See **return-type** |
| **interval** | integer or float |  | The interval (in seconds) in which the information gets polled. Minimum value is 0.001 (1ms). Values smaller than 1ms will be set to 1ms. Use **once** if you want to execute the module only on startup. You can update it manually with a signal. If no **interval** or **signal** is defined, it is assumed that the out script loops itself. If a **signal** is defined then the script will run once on startup and will only update with a signal. |
| **restart-interval** | integer |  | The restart interval (in whole seconds). Can't be used with the **interval** option, so only with continuous scripts. Once the script exits, it'll be re-executed after the **restart-interval**. |
| **signal** | integer |  | The signal number used to update the module. The number is valid between 1 and N, where **SIGRTMIN+N** = **SIGRTMAX**. If no interval is defined then a signal will be the only way to update the module. |
| **graph_type** | string | line | The style of graph to render. One of **line**, **bar** or **gauge**. |
| **width** | integer | 100 | The width of the graph in pixels. |
| **datapoints** | integer | 20 | The number of most recent values to retain and plot on the graph. |
| **on-click** | string |  | Command to execute when clicked on the module. |
| **on-click-middle** | string |  | Command to execute when middle-clicked on the module using mousewheel. |
| **on-click-right** | string |  | Command to execute when you right-click on the module. |
| **on-update** | string |  | Command to execute when the module is updated. |
| **on-scroll-up** | string |  | Command to execute when scrolling up on the module. |
| **on-scroll-down** | string |  | Command to execute when scrolling down on the module. |
| **smooth-scrolling-threshold** | double |  | Threshold to be used when scrolling. |
| **tooltip** | bool | true | Option to disable tooltip on hover. |
| **tooltip-format** | string |  | The tooltip format. If specified, overrides any tooltip output from the script in **exec**. See **FORMAT REPLACEMENTS**. |
| **escape** | bool | false | Option to enable escaping of script output. |
| **menu** | string |  | Action that popups the menu. |
| **menu-file** | string |  | Location of the menu descriptor file. There need to be an element of type GtkMenu with id **menu** |
| **menu-actions** | array |  | The actions corresponding to the buttons of the menu. |
| **expand** | bool | false | Enables this module to consume all left over space dynamically. |

## RETURN-TYPE

When **return-type** is set to **json**, Waybar expects the **exec**-script to output its data in JSON format. This should look like this:

    {"text": "$text", "tooltip": "$tooltip", "class": "$class", "percentage": $percentage }

The **class** parameter also accepts an array of strings.

If nothing or an invalid option is specified, Waybar expects i3blocks style output. Values are **newline** separated. This should look like this:

    $text\n$tooltip\n$class*

**class** is a CSS class, to apply different styles in **style.css**

## FORMAT REPLACEMENTS

These replacements are available in **tooltip-format**.

**{text}**: Output of the script.

**{alt}**: The **alt** value from a json return type.

**{percentage}** Percentage which can be set via a json return type.

## EXAMPLES

### Memory:

    "custom-graph/memory": {
        "interval": 60,
        "graph_type": "gauge",
        "width": 52,
        "exec": "/path/mem.sh",
        "signal": 8,
        "return-type": "json"
    },

mem.sh:

    #!/bin/bash

    mem_info=$(cat /proc/meminfo)
    mem_total=$(echo "$mem_info" | grep '^MemTotal:' | awk '{print $2}')
    mem_available=$(echo "$mem_info" | grep '^MemAvailable:' | awk '{print $2}')

    mem_used=$((mem_total - mem_available))
    mem_percent=$((mem_used * 100 / mem_total))

    echo "{"text": "${mem_percent}%", "percentage": ${mem_percent},"tooltip": "Memory: ${mem_used}KB used / ${mem_total}KB total"}'"

## STYLE

- **\#custom-graph-\<name\>**

- **\#custom-graph-\<name\>.\<class\>**

- **\<class\>** can be set by the script. For more information see **return-type**
