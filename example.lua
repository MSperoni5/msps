local ps = require("msps")

-- Example usage of the msgBox function
local msgBoxResult = ps.msgBox("AbortRetryIgnore Example", "This is an AbortRetryIgnore message box example.", "AbortRetryIgnore", "Exclamation", 2)
if msgBoxResult then
    print("User selected: " .. msgBoxResult)
else
    print("User cancelled or closed the message box.")
end

-- Example usage of the inputBox function
local inputBoxResult = ps.inputBox("Input Box Example", "Please enter some text:", "Default Text")
if inputBoxResult then
    print("User input: " .. inputBoxResult)
else
    print("User cancelled or closed the input box.")
end

-- Example usage of the setText function
ps.setText("Text copied to clipboard using msps module!")
print("Text has been copied to the clipboard.")

-- Example usage of the beep function
ps.beep()
print("Beep sound has been played.")

-- Example usage of the showDialog function
local files = ps.showDialog("Select Files", "All files (*.*)|*.*", true)
if files then
    local temp = table.concat(files, ", ")
    print("User selected files: " .. temp)
else
    print("User cancelled or closed the file dialog.")
end