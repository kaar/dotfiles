> [!NOTE]
> This page is **auto-generated from [`man/waybar-jack.5.scd`](https://github.com/Alexays/Waybar/blob/master/man/waybar-jack.5.scd)** on the `master` branch.
> Do not edit it here — changes will be overwritten on the next sync.
> To update it, edit the man page(s) and open a PR.

# DESCRIPTION

The **jack** module displays the current state of the JACK server. It supports both the JACK2 \<https://github.com/jackaudio/jack2\> and PipeWire \<https://pipewire.org/\> implementations of the JACK API.

PipeWire users are advised to run at least v0.3.57; earlier versions cause the Waybar client to hang indefinitely if the server shuts down while the module is running.

# CONFIGURATION

Addressed by **jack**

| **Option** | **Typeof** | **Default** | **Description** |
|:--:|:--:|:--:|:--:|
| **format** | string | **{load}%** | The format, how information should be displayed. This format is used when other formats aren't specified. |
| **format-connected** | string |  | This format is used when the module is connected to the JACK server. |
| **format-disconnected** | string |  | This format is used when the module is not connected to the JACK server. |
| **format-xrun** | string |  | This format is used for one polling interval when the JACK server reports an xrun. |
| **realtime** | bool | **true** | Option to drop real-time privileges for the JACK client opened by Waybar. |
| **tooltip** | bool | **true** | Option to disable tooltip on hover. |
| **tooltip-format** | string | **{bufsize}/{samplerate} {latency}ms** | The format of information displayed in the tooltip. |
| **interval** | integer or float | 1 | The interval in which the information gets polled. |
| **rotate** | integer |  | Positive value to rotate the text label (in 90 degree increments). |
| **max-length** | integer |  | The maximum length in character the module should display. |
| **min-length** | integer |  | The minimum length in characters the module should accept. |
| **align** | float |  | The alignment of the label within the module, where 0 is left-aligned and 1 is right-aligned. If the module is rotated, it will follow the flow of the text. |
| **justify** | string |  | The alignment of the text within the module's label, allowing options 'left', 'right', or 'center' to define the positioning. |
| **on-click** | string |  | Command to execute when clicked on the module. |
| **on-click-middle** | string |  | Command to execute when middle-clicked on the module using mousewheel. |
| **on-click-right** | string |  | Command to execute when you right-click on the module. |
| **on-update** | string |  | Command to execute when the module is updated. |
| **menu** | string |  | Action that popups the menu. |
| **menu-file** | string |  | Location of the menu descriptor file. There need to be an element of type GtkMenu with id **menu** |
| **menu-actions** | array |  | The actions corresponding to the buttons of the menu. |
| **expand** | bool | false | Enables this module to consume all left over space dynamically. |

# FORMAT REPLACEMENTS

**{load}**: The current CPU load estimated by JACK.

**{bufsize}**: The size of the JACK buffer.

**{samplerate}**: The sample rate at which the JACK server is running.

**{latency}**: The duration, in ms, of the current buffer size.

**{xruns}**: The number of xruns reported by the JACK server since starting Waybar.

# EXAMPLES

    "jack": {
    	"format": "DSP {}%",
    	"format-xrun": "{xruns} xruns",
    	"format-disconnected": "DSP off",
    	"realtime": true
    }

# STYLE

- **\#jack**

- **\#jack.connected**

- **\#jack.disconnected**

- **\#jack.xrun**
