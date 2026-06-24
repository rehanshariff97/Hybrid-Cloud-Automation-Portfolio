# 1. Define local directories and naming conventions
$LogDirectory = "C:\ServerLogs"
$CurrentDate = Get-Date -Format "yyyy-MM-dd"
$OutputFile = "$LogDirectory\HealthReport_$CurrentDate.csv"

# 2. Ensure the local log directory exists on the server
if (-not (Test-Path -Path $LogDirectory)) {
    New-Item -ItemType Directory -Path $LogDirectory | Out-Null
    Write-Host "Created local log directory at $LogDirectory" -ForegroundColor Cyan
}

# 3. Query system volume telemetry metrics
Write-Host "Gathering server storage telemetry metrics..." -ForegroundColor Yellow
$Disks = Get-CimInstance -ClassName Win32_LogicalDisk -Filter "DriveType=3"

# 4. Parse data and aggregate metrics into a custom PowerShell object
$ReportData = foreach ($Disk in $Disks) {
    [PSCustomObject]@{
        ServerName  = $env:COMPUTERNAME
        Timestamp   = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
        Drive       = $Disk.DeviceID
        VolumeName  = $Disk.VolumeName
        TotalSizeGB = [math]::Round($Disk.Size / 1GB, 2)
        FreeSpaceGB = [math]::Round($Disk.FreeSpace / 1GB, 2)
        UsedSpaceGB = [math]::Round(($Disk.Size - $Disk.FreeSpace) / 1GB, 2)
        PercentFree = [math]::Round(($Disk.FreeSpace / $Disk.Size) * 100, 2)
    }
}

# 5. Export aggregated telemetry dataset to a structured CSV log
$ReportData | Export-Csv -Path $OutputFile -NoTypeInformation -Append

Write-Host "Success! Local health report generated at: $OutputFile" -ForegroundColor Green
