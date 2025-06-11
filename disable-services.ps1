# Script to disable specified Windows services
# Run as Administrator

# Function to disable a service
function Disable-WindowsService {
    param (
        [string]$ServiceName,
        [string]$DisplayName
    )
    
    try {
        $service = Get-Service -Name $ServiceName -ErrorAction SilentlyContinue
        
        if ($service) {
            Write-Host "Disabling service: $($service.DisplayName) ($ServiceName)..." -ForegroundColor Yellow
            Stop-Service -Name $ServiceName -Force -ErrorAction SilentlyContinue
            Set-Service -Name $ServiceName -StartupType Disabled
            Write-Host "Service disabled successfully." -ForegroundColor Green
        } else {
            Write-Host "Service '$DisplayName' ($ServiceName) not found." -ForegroundColor Red
        }
    } catch {
        Write-Host "Error disabling service '$DisplayName' ($ServiceName): $_" -ForegroundColor Red
    }
    
    Write-Host ""
}

# Check for admin privileges
if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Warning "This script requires administrator privileges. Please run as Administrator."
    exit
}

Write-Host "=== Starting Windows Services Disabling Script ===" -ForegroundColor Cyan
Write-Host "This script will disable various Windows services." -ForegroundColor Cyan
Write-Host "WARNING: Disabling some services may affect system functionality." -ForegroundColor Red
Write-Host "=====================================================`n" -ForegroundColor Cyan

# Disable services (Service name, Display name)
Disable-WindowsService -ServiceName "DiagTrack" -DisplayName "Connected User Experiences and Telemetry"
Disable-WindowsService -ServiceName "dmwappushservice" -DisplayName "Data Collection and Compatibility Services"
Disable-WindowsService -ServiceName "PcaSvc" -DisplayName "Program Compatibility Assistant Service"
Disable-WindowsService -ServiceName "RemoteRegistry" -DisplayName "Remote Registry"
Disable-WindowsService -ServiceName "TrkWks" -DisplayName "Distributed Link Tracking Client"
Disable-WindowsService -ServiceName "bthserv" -DisplayName "Bluetooth Support Service"
Disable-WindowsService -ServiceName "stisvc" -DisplayName "Windows Image Acquisition"
Disable-WindowsService -ServiceName "SCardSvr" -DisplayName "Smart Card"
Disable-WindowsService -ServiceName "WbioSrvc" -DisplayName "Windows Biometric Service"
Disable-WindowsService -ServiceName "seclogon" -DisplayName "Secondary Logon"
Disable-WindowsService -ServiceName "MapsBroker" -DisplayName "Downloaded Maps Manager"

Write-Host "Operation completed!" -ForegroundColor Green
Write-Host "Note: Some services may require a system restart to fully disable." -ForegroundColor Yellow
