-- Module options:
local register_global_module_table = false
local global_module_name = 'ps'

local ps = { version = "msps 1.0.1" }

-- This module is only supported on Windows systems
local isUnix = package.config:sub(1, 1) == "/"
if isUnix then
    error("msps module is only supported on Windows systems.")
end

if register_global_module_table then
    _G[global_module_name] = ps
end

--- Displays a customizable message box using PowerShell and Microsoft.VisualBasic.
--- @param title string The title of the message box. Must be non-empty.
--- @param prompt string The message text to display. Must be non-empty.
--- @param boxType string|nil The type of buttons to display. Valid values: "OKOnly", "OKCancel", "AbortRetryIgnore", "YesNoCancel", "YesNo", "RetryCancel". Default is "OKOnly".
--- @param icon string|nil The icon to display. Valid values: "None", "Critical", "Question", "Exclamation", "Information". Default is "None".
--- @param defaultButton number|nil The default button (1, 2, or 3). Default is 1.
--- @return string|nil result The result of the user's interaction with the message box. Returns `nil` if the user cancels or closes the box.
function ps.msgBox(title, prompt, boxType, icon, defaultButton)
    if not title or type(title) ~= "string" then
        error("Title must be a string")
    end
    if title == "" then
        error("Title cannot be empty")
    end

    if not prompt or type(prompt) ~= "string" then
        error("Prompt must be a string")
    end
    if prompt == "" then
        error("Prompt cannot be empty")
    end

    if not boxType or type(boxType) ~= "string" then
        error("BoxType must be a string")
    end

    if not boxType or type(boxType) ~= "string" or boxType == "" then
        boxType = "OKOnly"
    end
    if boxType ~= "OKOnly" and boxType ~= "OKCancel" and boxType ~= "AbortRetryIgnore" and boxType ~= "YesNoCancel" and boxType ~= "YesNo" and boxType ~= "RetryCancel" then
        error("BoxType must be one of: OKOnly, OKCancel, AbortRetryIgnore, YesNoCancel, YesNo, RetryCancel")
    end

    if not icon or type(icon) ~= "string" or icon == "" then
        icon = "None"
    end
    if icon and type(icon) == "string" and icon ~= "Critical" and icon ~= "Question" and icon ~= "Exclamation" and icon ~= "Information" and icon ~= "None" then
        error("Icon must be one of: None, Critical, Question, Exclamation, Information")
    end

    if defaultButton and type(defaultButton) ~= "number" then
        error("DefaultButton must be a number")
    end
    if defaultButton and defaultButton ~= 1 and defaultButton ~= 2 and defaultButton ~= 3 then
        error("DefaultButton must be one of: 1, 2, 3")
    end
    if not defaultButton then
        defaultButton = 1
    end

    local command = string.format([[
powershell -Command "Add-Type -AssemblyName Microsoft.VisualBasic; $title = \"%s\"; $prompt = \"%s\"; $boxType = \"%s\"; $icon = \"%s\"; $defaultButton = %s; switch ($icon) { "Question" { $visualBasicIcon = [Microsoft.VisualBasic.MsgBoxStyle]::Question }; "Critical" { $visualBasicIcon = [Microsoft.VisualBasic.MsgBoxStyle]::Critical }; "Exclamation" { $visualBasicIcon = [Microsoft.VisualBasic.MsgBoxStyle]::Exclamation }; "Information" { $visualBasicIcon = [Microsoft.VisualBasic.MsgBoxStyle]::Information } }; switch ($boxType) { "OKOnly" { $visualBasicButtons = [Microsoft.VisualBasic.MsgBoxStyle]::OKOnly }; "OKCancel" { $visualBasicButtons = [Microsoft.VisualBasic.MsgBoxStyle]::OkCancel }; "AbortRetryIgnore" { $visualBasicButtons = [Microsoft.VisualBasic.MsgBoxStyle]::AbortRetryIgnore }; "YesNoCancel" { $visualBasicButtons = [Microsoft.VisualBasic.MsgBoxStyle]::YesNoCancel }; "YesNo" { $visualBasicButtons = [Microsoft.VisualBasic.MsgBoxStyle]::YesNo }; "RetryCancel" { $visualBasicButtons = [Microsoft.VisualBasic.MsgBoxStyle]::RetryCancel } }; switch ($defaultButton) { 1 { $visualBasicDefaultButton = [Microsoft.VisualBasic.MsgBoxStyle]::DefaultButton1 }; 2 { $visualBasicDefaultButton = [Microsoft.VisualBasic.MsgBoxStyle]::DefaultButton2 }; 3 { $visualBasicDefaultButton = [Microsoft.VisualBasic.MsgBoxStyle]::DefaultButton3 } }; $popuptype = $visualBasicIcon -bor $visualBasicButtons -bor $visualBasicDefaultButton; $result = [Microsoft.VisualBasic.Interaction]::MsgBox($prompt, $popuptype, $title); if ($result) { Write-Output $result; exit 0 } else { exit 1 }"
]], title, prompt, boxType, icon, defaultButton)

    local handle = io.popen(command, "r")
    if not handle then
        error("Failed to execute PowerShell command")
    end

    local result = handle:read("*a")
    local suc, exitcode, code = handle:close()

    if code == 0 then
        result = result:gsub("\r", ""):gsub("\n", "")
        return result
    end

    return nil
end

--- Displays an input box using PowerShell and Microsoft.VisualBasic.
--- @param title string The title of the input box window. Must be non-empty.
--- @param prompt string The text to display as the prompt in the input box. Must be non-empty.
--- @param default string|nil The default text to display in the input box. Default is an empty string.
--- @return string|nil result The text entered by the user. Returns `nil` if the user cancels the input box.
function ps.inputBox(title, prompt, default)
    if not title or type(title) ~= "string" then
        error("Title must be a string")
    end
    if title == "" then
        error("Title cannot be empty")
    end

    if not prompt or type(prompt) ~= "string" then
        error("Prompt must be a string")
    end
    if prompt == "" then
        error("Prompt cannot be empty")
    end

    if default and type(default) ~= "string" then
        error("Default value must be a string")
    end
    if not default then
        default = ""
    end

    local command = string.format([[
powershell -Command "Add-Type -AssemblyName Microsoft.VisualBasic; $prompt = \"%s\"; $title = \"%s\"; $default = \"%s\"; $result = [Microsoft.VisualBasic.Interaction]::InputBox($prompt, $title, $default); if ($result) {  Write-Output $result; exit 0 } else { exit 1 }"
]], prompt, title, default)

    local handle = io.popen(command, "r")
    if not handle then
        error("Failed to execute PowerShell command")
    end

    local result = handle:read("*a")
    local suc, exitcode, code = handle:close()

    if code == 0 then
        result = result:gsub("\r", ""):gsub("\n", "")
        return result
    end

    return nil
end

--- Copies the given text to the system clipboard using PowerShell and System.Windows.Forms.
--- @param text string The text to copy to the clipboard. Must be a non-empty string.
function ps.setText(text)
    if not text or type(text) ~= "string" then
        error("Text must be a string")
    end
    if text == "" then
        error("Text cannot be empty")
    end

    local command = string.format([[
powershell -Command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.Clipboard]::SetText('%s'); exit 0"
]], text)

    os.execute(command)
end

--- Produces a beep sound using PowerShell and Microsoft.VisualBasic
function ps.beep()
    os.execute([[
powershell -Command "Add-Type -AssemblyName Microsoft.VisualBasic; [Microsoft.VisualBasic.Interaction]::Beep(); exit 0"
]])
end

return ps