> [!NOTE]
> This page is **auto-generated from [`man/waybar-mpd.5.scd`](https://github.com/Alexays/Waybar/blob/master/man/waybar-mpd.5.scd)** on the `master` branch.
> Do not edit it here — changes will be overwritten on the next sync.
> To update it, edit the man page(s) and open a PR.

# DESCRIPTION

The **mpd** module displays information about a running "Music Player Daemon" instance.

Note that Waybar must be compiled with MPD support in order to use this module.

# CONFIGURATION

Addressed by **mpd**

| **Option** | **Typeof** | **Default** | **Description** |
|:--:|:--:|:--:|:--:|
| **server** | string |  | The network address or Unix socket path of the MPD server. If empty, connect to the default host (\`MPD_HOST\`). |
| **port** | integer |  | The port MPD listens to. If empty, use the default port (\`MPD_PORT\`). |
| **password** | string |  | The password required to connect to the MPD server. If empty, no password is sent to MPD. |
| **interval** | integer | 5 | The interval in which the connection to the MPD server is retried |
| **playing-interval** | integer | 1000 | The interval (in milliseconds) in which the playing state is updated. |
| **timeout** | integer | 30 | The timeout for the connection. Change this if your MPD server has a low \`connection_timeout\` setting |
| **unknown-tag** | string | "N/A" | The text to display when a tag is not present in the current song, but used in \`format\` |
| **format** | string | "{album} - {artist} - {title}" | Information displayed when a song is playing. |
| **format-stopped** | string | "stopped" | Information displayed when the player is stopped. |
| **format-paused** | string |  | This format is used when a song is paused. |
| **format-disconnected** | string | "disconnected" | Information displayed when the MPD server can't be reached. |
| **tooltip** | bool | true | Option to disable tooltip on hover. |
| **tooltip-format** | string | "MPD (connected)" | Tooltip information displayed when connected to MPD. |
| **tooltip-format-disconnected** | string | "MPD (disconnected)" | Tooltip information displayed when the MPD server can't be reached. |
| **artist-len** | integer |  | Maximum length of the Artist tag. |
| **album-len** | integer |  | Maximum length of the Album tag. |
| **album-artist-len** | integer |  | Maximum length of the Album Artist tag. |
| **title-len** | integer |  | Maximum length of the Title tag. |
| **ellipsis** | string | "" | The string appended to the Artist, Album, Album Artist and Title tags when they are truncated by the corresponding length option (\`artist-len\`, \`album-len\`, \`album-artist-len\`, \`title-len\`). |
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
| **state-icons** | object | {} | Icon to show depending on the play/pause state of the player (**{ "playing": "...", "paused": "..." }**) |
| **consume-icons** | object | {} | Icon to show depending on the "consume" option (**{ "on": "...", "off": "..." }**) |
| **random-icons** | object | {} | Icon to show depending on the "random" option (**{ "on": "...", "off": "..." }**) |
| **repeat-icons** | object | {} | Icon to show depending on the "repeat" option (**{ "on": "...", "off": "..." }**) |
| **single-icons** | object | {} | Icon to show depending on the "single" option (**{ "on": "...", "off": "..." }**) |
| **menu** | string |  | Action that popups the menu. |
| **menu-file** | string |  | Location of the menu descriptor file. There need to be an element of type GtkMenu with id **menu** |
| **menu-actions** | array |  | The actions corresponding to the buttons of the menu. |
| **expand** | bool | false | Enables this module to consume all left over space dynamically. |

# FORMAT REPLACEMENTS

## WHEN PLAYING/PAUSED

**{artist}**: The artist of the current song

**{albumArtist}**: The artist of the current album

**{album}**: The album of the current song

**{title}**: The title of the current song

**{date}**: The date of the current song

**{volume}**: The current volume in percent

**{elapsedTime}**: The current position of the current song. To format as a date/time (see example configuration)

**{totalTime}**: The length of the current song. To format as a date/time (see example configuration)

**{songPosition}**: The position of the current song.

**{queueLength}**: The length of the current queue.

**{uri}**: The URI of the song relative to the MPD music directory.

**{filename}** The last part of the URI.

**{stateIcon}**: The icon corresponding to the playing or paused status of the player (see **state-icons** option)

**{consumeIcon}**: The icon corresponding the "consume" option (see **consume-icons** option)

**{randomIcon}**: The icon corresponding the "random" option (see **random-icons** option)

**{repeatIcon}**: The icon corresponding the "repeat" option (see **repeat-icons** option)

**{singleIcon}**: The icon corresponding the "single" option (see **single-icons** option)

## WHEN STOPPED

**{consumeIcon}**: The icon corresponding the "consume" option (see **consume-icons** option)

**{randomIcon}**: The icon corresponding the "random" option (see **random-icons** option)

**{repeatIcon}**: The icon corresponding the "repeat" option (see **repeat-icons** option)

**{singleIcon}**: The icon corresponding the "single" option (see **single-icons** option)

## WHEN DISCONNECTED

Currently, no format replacements when disconnected.

# EXAMPLES

    "mpd": {
    	"format": "{stateIcon} {consumeIcon}{randomIcon}{repeatIcon}{singleIcon}{artist} - {album} - {title} ({elapsedTime:%M:%S}/{totalTime:%M:%S}) ",
    	"format-disconnected": "Disconnected ",
    	"format-stopped": "{consumeIcon}{randomIcon}{repeatIcon}{singleIcon}Stopped ",
    	"interval": 2,
    	"consume-icons": {
    		"on": " " // Icon shows only when "consume" is on
    	},
    	"random-icons": {
    		"off": "<span color="#f53c3c"></span> ", // Icon grayed out when "random" is off
    		"on": " "
    	},
    	"repeat-icons": {
    		"on": " "
    	},
    	"single-icons": {
    		"on": "1 "
    	},
    	"state-icons": {
    		"paused": "",
    		"playing": ""
    	},
    	"tooltip-format": "MPD (connected)",
    	"tooltip-format-disconnected": "MPD (disconnected)"
    }

# STYLE

- **\#mpd**

- **\#mpd.disconnected**

- **\#mpd.stopped**

- **\#mpd.playing**

- **\#mpd.paused**
