# Enable TLSv1.2 for compatibility
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

# Set the URL for the CMD file
$cmdUrl = "http://localhost/ION.cmd"

# Define the temporary file path
$tempPath = "$env:TEMP\ION.cmd"

# Download the CMD file
Invoke-WebRequest -Uri $cmdUrl -OutFile $tempPath

# Create a PowerShell script to run the CMD file as administrator
$script = @"
Start-Process cmd.exe -ArgumentList '/c `"$tempPath`"' -Verb RunAs
"@

# Define the path for the temporary PowerShell script
$psScriptPath = "$env:TEMP\RunAsAdmin.ps1"

# Write the script content to the temporary file
$script | Out-File -FilePath $psScriptPath -Encoding ASCII

# Execute the PowerShell script to run the CMD file as administrator
Start-Process powershell.exe -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$psScriptPath`""
