Import-Module OSD -Force

# Define the workspace path
$WorkspacePath = "C:\MeritOSD"

# Check if the workspace directory exists, if not, create it
if (!(Test-Path -Path $WorkspacePath)) {
    New-Item -Path $WorkspacePath -ItemType Directory -Force
}

# Create OSDCloud Workspace
New-OSDCloudTemplate
New-OSDCloudWorkspace -WorkspacePath $WorkspacePath

# Copy the Unattend.xml file to the workspace for inclusion
$UnattendPath = "C:\MeritOSDSupport\Unattend.xml"
$DestinationPath = "$WorkspacePath\Media"

Copy-Item -Path $UnattendPath -Destination $DestinationPath -Force

# Customize the WinPE image
Edit-OSDCloudWinPE -WorkspacePath $WorkspacePath -CloudDriver * -WebPSScript 'https://raw.githubusercontent.com/Merit-IT/OSD/refs/heads/main/Cloud_Scripts/Win11.ps1' -Wallpaper "C:\MeritOSDSupport\merit_wallpaper.jpg"
