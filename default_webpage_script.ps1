param(
    [string]$Homepage = "https://paginc.com",
    [string[]]$AdditionalStartupURLs = @()   # leave empty for no extra tabs
)

$ErrorActionPreference = "Stop"

# 64-bit registry view
if ($env:PROCESSOR_ARCHITECTURE -ne "AMD64" -and [Environment]::Is64BitOperatingSystem) {
    & "$env:WINDIR\sysnative\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -ExecutionPolicy Bypass -File "$PSCommandPath" @PSBoundParameters
    exit $LASTEXITCODE
}

function Ensure-Key { param([string]$Path) if (-not (Test-Path $Path)) { New-Item -Path $Path -Force | Out-Null } }

function Set-MSZ {  # set multi-string safely
    param([string]$Path,[string]$Name,[string[]]$Values)
    Ensure-Key $Path
    Remove-ItemProperty -Path $Path -Name $Name -ErrorAction SilentlyContinue
    New-ItemProperty -Path $Path -Name $Name -PropertyType MultiString -Value $Values -Force | Out-Null
}

# Build startup list (first tab = homepage)
$StartupURLs = @($Homepage) + @($AdditionalStartupURLs | Where-Object { $_ -and $_.Trim() -ne "" })

# ----- EDGE -----
$edge = "HKLM:\SOFTWARE\Policies\Microsoft\Edge"
Ensure-Key $edge
New-ItemProperty -Path $edge -Name "HomepageLocation"        -PropertyType String -Value $Homepage -Force | Out-Null
New-ItemProperty -Path $edge -Name "RestoreOnStartup"        -PropertyType DWord  -Value 4 -Force | Out-Null
Set-MSZ            -Path $edge -Name "RestoreOnStartupURLs"  -Values $StartupURLs
New-ItemProperty -Path $edge -Name "ShowHomeButton"          -PropertyType DWord  -Value 1 -Force | Out-Null
New-ItemProperty -Path $edge -Name "HomepageIsNewTabPage"    -PropertyType DWord  -Value 0 -Force | Out-Null
New-ItemProperty -Path $edge -Name "NewTabPageLocation"      -PropertyType String -Value $Homepage -Force | Out-Null

# ----- CHROME -----
$chrome = "HKLM:\SOFTWARE\Policies\Google\Chrome"
Ensure-Key $chrome
New-ItemProperty -Path $chrome -Name "HomepageLocation"      -PropertyType String -Value $Homepage -Force | Out-Null
New-ItemProperty -Path $chrome -Name "RestoreOnStartup"      -PropertyType DWord  -Value 4 -Force | Out-Null
Set-MSZ            -Path $chrome -Name "RestoreOnStartupURLs" -Values $StartupURLs
New-ItemProperty -Path $chrome -Name "ShowHomeButton"        -PropertyType DWord  -Value 1 -Force | Out-Null
New-ItemProperty -Path $chrome -Name "HomePageIsNewTabPage"  -PropertyType DWord  -Value 0 -Force | Out-Null
New-ItemProperty -Path $chrome -Name "NewTabPageLocation"    -PropertyType String -Value $Homepage -Force | Out-Null
