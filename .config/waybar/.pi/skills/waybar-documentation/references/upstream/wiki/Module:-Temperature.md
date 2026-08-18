> [!NOTE]
> This page is **auto-generated from [`man/waybar-temperature.5.scd`](https://github.com/Alexays/Waybar/blob/master/man/waybar-temperature.5.scd)** on the `master` branch.
> Do not edit it here — changes will be overwritten on the next sync.
> To update it, edit the man page(s) and open a PR.

# DESCRIPTION

The **temperature** module displays the current temperature from a thermal zone.

# CONFIGURATION

Addressed by **temperature**

| **Option** | **Typeof** | **Default** | **Description** |
|:--:|:--:|:--:|:--:|
| **thermal-zone** | integer |  | The thermal zone, as in **/sys/class/thermal/**. |
| **hwmon-path** | string |  | The temperature path to use, e.g. **/sys/class/hwmon/hwmon2/temp1_input** instead of one in **/sys/class/thermal/**. This can also be an array of strings. In this case, waybar will check each item in the array and use the first valid one. This is suitable if you want to share the same configuration file among different machines with different hardware configurations. |
| **hwmon-path-abs** | string |  | The path of the hwmon-directory of the device, e.g. **/sys/devices/pci0000:00/0000:00:18.3/hwmon**. (Note that the subdirectory **hwmon/hwmon#**, where **\#** is a number is not part of the path!) Has to be used together with **input-filename**. This can also be an array of strings, for which, it just works like **hwmon-path**. |
| **hwmon-name** | string |  | Select a hwmon device by its name (from /sys/class/hwmon/\*/name), e.g. **amdgpu**. Requires **input-filename** to be set. Cannot be used together with **hwmon-path** or **hwmon-path-abs**. |
| **input-filename** | string |  | The temperature filename of your **hwmon-path-abs** (also used by **hwmon-by-name**), e.g. **temp1_input** |
| **hwmon-by-name** | string |  | The substring to search for in **/sys/class/hwmon/hwmonX/name** (where hwmonX is any folder in **/sys/class/hwmon/**). Waybar will search for every directory in **/sys/class/hwmon/** and uses the directory in which the **name** matches **hwmon-by-name**. |
| **warning-threshold** | integer |  | The threshold before it is considered warning (Celsius). |
| **critical-threshold** | integer |  | The threshold before it is considered critical (Celsius). |
| **interval** | integer or float | 10 | The interval in which the information gets polled. |
| **format-warning** | string |  | The format to use when temperature is considered warning |
| **format-critical** | string |  | The format to use when temperature is considered critical |
| **format** | string | {temperatureC}°C | The format (Celsius/Fahrenheit/Kelvin) in which the temperature should be displayed. |
| **format-icons** | array |  | Based on the current temperature (Celsius) and **critical-threshold** if available, the corresponding icon gets selected. The order is **low** to **high**. |
| **tooltip-format** | string | {temperatureC}°C | The format for the tooltip |
| **rotate** | integer |  | Positive value to rotate the text label (in 90 degree increments). |
| **max-length** | integer |  | The maximum length in characters the module should display. |
| **min-length** | integer |  | The minimum length in characters the module should accept. |
| **align** | float |  | The alignment of the label within the module, where 0 is left-aligned and 1 is right-aligned. If the module is rotated, it will follow the flow of the text. |
| **justify** | string |  | The alignment of the text within the module's label, allowing options 'left', 'right', or 'center' to define the positioning. |
| **on-click** | string |  | Command to execute when you click on the module. |
| **on-click-middle** | string |  | Command to execute when middle-clicked on the module using mousewheel. |
| **on-click-right** | string |  | Command to execute when you right-click on the module. |
| **on-update** | string |  | Command to execute when the module is updated. |
| **on-scroll-up** | string |  | Command to execute when scrolling up on the module. |
| **on-scroll-down** | string |  | Command to execute when scrolling down on the module. |
| **smooth-scrolling-threshold** | double |  | Threshold to be used when scrolling. |
| **tooltip** | bool | true | Option to disable tooltip on hover. |
| **menu** | string |  | Action that popups the menu. |
| **menu-file** | string |  | Location of the menu descriptor file. There need to be an element of type GtkMenu with id **menu** |
| **menu-actions** | array |  | The actions corresponding to the buttons of the menu. |
| **expand** | bool | false | Enables this module to consume all left over space dynamically. |

# FORMAT REPLACEMENTS

**{temperatureC}**: Temperature in Celsius.

**{temperatureF}**: Temperature in Fahrenheit.

**{temperatureK}**: Temperature in Kelvin.

**{icon}**: Icon, as selected from **format-icons** based on the current temperature.

# EXAMPLES

     "temperature": {
    	// "thermal-zone": 2,
    	// "hwmon-path": ["/sys/class/hwmon/hwmon2/temp1_input", "/sys/class/thermal/thermal_zone0/temp"],
    	// "critical-threshold": 80,
    	// "format-critical": "{temperatureC}°C ",
    	"format": "{temperatureC}°C "
    }

# STYLE

- **\#temperature**

- **\#temperature.warning**

- **\#temperature.critical**

# TROUBLESHOOTING

## Finding your thermal zone

To list all the thermal zone types, run:

    for i in /sys/class/thermal/thermal_zone*; do echo "$i: $(<$i/type)"; done

## Finding an hwmon path

If you do not have a thermal zone, use **sensors** to find the preferred temperature source, then run:

    for i in /sys/class/hwmon/hwmon*/temp*_input; do echo "$(<$(dirname $i)/name): $(cat ${i%_*}_label 2>/dev/null || echo $(basename ${i%_*})) $(readlink -f $i)"; done

to find the path to the desired file, then set it in **hwmon-path**.
