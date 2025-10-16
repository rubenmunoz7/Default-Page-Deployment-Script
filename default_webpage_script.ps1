# Default Page Deployment Script
# Ruben Munoz 10/10/2025

# This script will set the default homepage on edge to *insertURLhere* when the browser is open
# Make the browsers run that page on startup (this is policy managed)
# Have it run as a variable at runtime that way we can set it as anything





# Set default homepage to "https://paginc.com" for Edge + Chrome 
param(
    [string]$Homepage = "*insertURLhere*"
)

$ErrorActionPreference = "Stop" # fail fast that logs errors

# Ensure correct registry view
# Gaurentees we write to the 64-bit HKLM path
if ($env:PROCESSOR_ARCHITECTURE -ne "AMD64" -and [Environment]::Is64BitOperatingSystem) {
    & "$env:WINDIR\sysnative\WindowsPowershell\v1.0\powershell.exe" -NoProfile -ExecutionPolicy Bypass -File "$PSCommandPath" $PSBoundParameters
    exit $LASTEXITCODE 
}

# Helper to write fresh registry
# Remove the existing value, then recreate it 
function Set-Multistring {
    param([string]$Path,[string]$Name,[string[]]$Values) # Registry key path, value name, array of strings to store
    if (-not (Test-Path $Path)) { New-Item -Path $Path -Force | Out-Null } # make key if missing
    Remove-ItemProperty -Path $Path -Name $Name -ErrorAction SilentlyContinue # delete old value
    New-ItemProperty -Path $Path -Name $Name -PropertyType Multistring -value $Values -Force | Out-Null # create new value
}   

# Microsoft Edge Policies
$edge = "HKLM:\SOFTWARE\Policies\Microsoft\Edge"
if (-not (Test-Path $edge)) { New-Item -Path $edge -Force | Out-Null }
New-ItemProperty -Path $edge -Name "HomepageLocation"   -PropertyType String -Value $Homepage -Force | Out-Null # The homepage URL used for the home button and policy
New-ItemProperty -Path $edge -Name "RestoreOnStartup"   -PropertyType DWord  -Value 4 -Force | Out-Null # Open list of URLs
Remove-ItemProperty -Path $edge -Name "restoreOnStartupURLs" -ErrorAction SilentlyContinue
New-ItemProperty -Path $edge -Name "RestoreOnStartupURLs" -Value @($Homepage) -PropertyType MultiString -Force | Out-Null

# Show Home button to same URL (edge)   
New-ItemProperty -Path $edge -Name "ShowHomeButton"         -PropertyType DWord -Value 1 -Force | Out-Null  
New-itemProperty -Path $edge -Name "HomepageIsNewTabPage" -PropertyType DWord -Value 0 -Force | Out-Null

# Google Chrome Policies
$chrome = "HKLM:\SOFTWARE\Policies\Google\Chrome"
if (-not (Test-Path $chrome)) { New-Item -Path $chrome -Force | Out-Null } # ensure that key exists
New-ItemProperty -Path $chrome -Name "Homepagelocation"     -PropertyType String -Value $Homepage -Force | Out-Null
New-ItemProperty -Path $chrome -Name "RestoreOnStartup"     -PropertyType DWord -Value 4 -Force | Out-Null
Set-Multistring -Path $chrome -Name "RestoreOnStartupURLs" -Values @($Homepage)

# Show Home Button to same URL (chrome)
New-ItemProperty -Path $chrome -Name "ShowHomeButton"       -PropertyType DWord -Value 1 -Force | Out-Null
New-ItemProperty -Path $chrome -Name "HomePageIsNewTabPage" -PropertyType DWord -Value 0 -Force | Out-Null


