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

-- Example usage of the openFile function
local files = ps.openFile("Select Files", "All files (*.*)|*.*", true)
if files then
    local temp = table.concat(files, ", ")
    print("User selected files: " .. temp)
else
    print("User cancelled or closed the file dialog.")
end

-- Example usage of the folderBrowser function
local folder = ps.folderBrowser("Select a Folder", true)
if folder then
    print("User selected folder: " .. folder)
else
    print("User cancelled or closed the folder dialog.")
end

-- Example usage of the customXaml function
local xaml = [=[
<Window xmlns='http://schemas.microsoft.com/winfx/2006/xaml/presentation'
        Title='Esempio ComboBox' Height='350' Width='350'>
    <Grid>
        <TextBox Name='MyTextBox' Width='200' Height='25' Margin='50,10,50,0' VerticalAlignment='Top'/>
        <PasswordBox Name='MyPasswordBox' Width='200' Height='25' Margin='50,45,50,0' VerticalAlignment='Top'/>
        <DatePicker Name='MyDatePicker' Margin='50,80,50,0' VerticalAlignment='Top'/>
        <CheckBox Name='MyCheckBox' Content='Accetto' Margin='50,115,0,0' VerticalAlignment='Top'/>
        <ComboBox Name='MyComboBox' Width='200' Margin='50,145,50,0' VerticalAlignment='Top'>
            <ComboBoxItem Content='Opzione 1'/>
            <ComboBoxItem Content='Opzione 2'/>
        </ComboBox>
        <Slider Name='MySlider' Minimum='0' Maximum='100' Value='25' Width='200' Margin='50,180,50,0' VerticalAlignment='Top'/>
        <Button Name='Close' Content='Conferma' Width='80' Height='25' HorizontalAlignment='Right' Margin='0,0,10,10' VerticalAlignment='Bottom'/>
    </Grid>
</Window>
]=]
local inputs = { "MyTextBox", "MyPasswordBox", "MyDatePicker", "MyCheckBox", "MyComboBox", "MySlider" }
local customXamlResult = ps.customXaml(xaml, inputs)
if customXamlResult then
    print(customXamlResult)
else
    print("User cancelled or closed the custom XAML dialog.")
end