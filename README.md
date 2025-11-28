# msps
A Lua library for Windows that provides simple functions for user interaction, such as message boxes, input dialogs, clipboard handling, and system notifications. Easy to integrate in Lua scripts with minimal setup.

# Compatibility Notice
- This library is designed for Windows systems only.  
- It requires PowerShell to be available in the system PATH.  
- Unix-based systems are **not supported**.

# Installation
Simply copy `msps.lua` into your Lua project or modules folder:

```lua
local ps = require("msps")
```

# Features
| Function        | Description                                                                                       | Parameters                                                                                  | Returns                   |
|-----------------|---------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------|---------------------------|
| `ps.msgBox`     | Displays a customizable message box using PowerShell and Microsoft.VisualBasic.                  | `title` (string), `prompt` (string), `boxType` (string, optional), `icon` (string, optional), `defaultButton` (number, optional) | `string` or `nil`         |
| `ps.inputBox`   | Displays an input box using PowerShell and Microsoft.VisualBasic.                                 | `title` (string), `prompt` (string), `default` (string, optional)                          | `string` or `nil`         |
| `ps.setText`    | Copies the given text to the system clipboard using PowerShell and System.Windows.Forms.         | `text` (string)                                                                            | `nil`                     |
| `ps.beep`       | Produces a beep sound using PowerShell and Microsoft.VisualBasic.                                 | None                                                                                       | `nil`                     |

# TODO
- Implement a system for creating custom windows using XAML, developed with a WPF project in Visual Studio. This will allow for fully custom user interfaces.
