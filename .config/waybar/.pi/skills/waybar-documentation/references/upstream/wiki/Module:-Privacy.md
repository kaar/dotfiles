> [!NOTE]
> This page is **auto-generated from [`man/waybar-privacy.5.scd`](https://github.com/Alexays/Waybar/blob/master/man/waybar-privacy.5.scd)** on the `master` branch.
> Do not edit it here — changes will be overwritten on the next sync.
> To update it, edit the man page(s) and open a PR.

# DESCRIPTION

The **privacy** module displays if any application is capturing audio, sharing  
the screen or playing audio.

# CONFIGURATION

| **Option** | **Typeof** | **Default** | **Description** |
|:--:|:--:|:--:|:--:|
| **icon-spacing** | integer | 4 | The spacing between each privacy icon. |
| **icon-size** | integer | 20 | The size of each privacy icon. Set to **0** for auto size. |
| **transition-duration** | integer | 250 | Option to disable tooltip on hover. |

**modules**  
typeof: array of objects  
default: \[{"type": "screenshare"}, {"type": "audio-in"}, {"type": "location"}\]  
Which privacy modules to monitor. See **MODULES CONFIGURATION** for  
more information.

| **Option** | **Typeof** | **Default** | **Description** |
|:--:|:--:|:--:|:--:|
| **expand** | bool | false | Enables this module to consume all left over space dynamically. |

**ignore-monitor**  
typeof: bool  
default: true  
Ignore streams with **stream.monitor** property.

**ignore**  
typeof: array of objects  
default: \[\]  
Additional streams to be ignored. See **IGNORE CONFIGURATION** for  
more information.

# MODULES CONFIGURATION

| **Option** | **Typeof** | **Default** | **Description** |
|:--:|:--:|:--:|:--:|
| **type** | string |  | values: "screenshare", "audio-in", "audio-out", "location" Specifies which module to use and configure. |
| **icon-name** | string |  | If set, changes the modules icon. Accepts any valid GTK icon name. Note: the icon is only visible when the resource is actively in use; the item is hidden when idle. |
| **tooltip** | bool | true | Option to disable tooltip on hover. |
| **tooltip-icon-size** | integer | 24 | The size of each icon in the tooltip. |

# IGNORE CONFIGURATION

| **Option** | **Typeof** | **Default** | **Description** |
|:----------:|:----------:|:-----------:|:---------------:|
|  **type**  |   string   |             |                 |
|  **name**  |   string   |             |                 |

# EXAMPLES

    "privacy": {
    	"icon-spacing": 4,
    	"icon-size": 18,
    	"transition-duration": 250,
    	"modules": [
    		{
    			"type": "screenshare",
    			"tooltip": true,
    			"tooltip-icon-size": 24
    		},
    		{
    			"type": "audio-out",
    			"tooltip": true,
    			"tooltip-icon-size": 24
    		},
    		{
    			"type": "audio-in",
    			"tooltip": true,
    			"tooltip-icon-size": 24
    		},
    		{
    			"type": "location",
    			"icon-name": "location-services-active-symbolic"
    		}
    	],
    	"ignore-monitor": true,
    	"ignore": [
    		{
    			"type": "audio-in",
    			"name": "cava"
    		},
    		{
    			"type": "screenshare",
    			"name": "obs"
    		}
    	]
    },

# STYLE

- **\#privacy**

- **\#privacy-item**

- **\#privacy-item.screenshare**

- **\#privacy-item.audio-in**

- **\#privacy-item.audio-out**

- **\#privacy-item.location**
