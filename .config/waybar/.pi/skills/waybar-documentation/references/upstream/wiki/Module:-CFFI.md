> [!NOTE]
> This page is **auto-generated from [`man/waybar-cffi.5.scd`](https://github.com/Alexays/Waybar/blob/master/man/waybar-cffi.5.scd)** on the `master` branch.
> Do not edit it here — changes will be overwritten on the next sync.
> To update it, edit the man page(s) and open a PR.

# DESCRIPTION

The **cffi** module gives full control of a GTK widget to a third-party dynamic library, to create more complex modules using different programming languages.

# CONFIGURATION

Addressed by **cffi/\<name\>**

| **Option** | **Typeof** | **Default** | **Description** |
|:--:|:--:|:--:|:--:|
| **module_path** | string |  | The path to the dynamic library to load to control the widget. |
| **expand** | bool | false | Enables this module to consume all left over space dynamically. |

Some additional configuration may be required depending on the cffi dynamic library being used.

# EXAMPLES

## C example:

An example module written in C can be found at https://github.com/Alexays/Waybar/resources/custom_modules/cffi_example/

Waybar config to enable the module:

    "cffi/c_example": {
    	"module_path": ".config/waybar/cffi/wb_cffi_example.so"
    }

# DEVELOPING CFFI MODULES

CFFI modules require a handful of functions and constants to be defined with C linkage. The way to achieve this depends on the programming language being used (search for FFI / Foreign Function Interface for that language).

The complete list of symbols to define can be found in the header file shipped with Waybar at **resources/custom_modules/cffi_example/waybar_cffi_module.h**, and a full example written in C is provided in **resources/custom_modules/cffi_example/**.

Language bindings exist for several languages, including Rust (the **waybar-cffi** crate) and Zig.

# STYLE

The classes and IDs are managed by the cffi dynamic library.
