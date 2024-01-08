function countstart
{
$start = Get-Service | ?{$_.Status -eq "Running"}
Write-Host "Total services in running state = "$start.count
}
function countstop
{
$stop = Get-Service | ?{$_.Status -eq "Stopped"}
Write-Host "Total services in stopped state = "$stop.count
}
countstart
countstop

function countservice
{
param
(
[string]$status
)
if($status -eq "Running")
{
$start = Get-Service | ?{$_.Status -eq "Running"}
Write-Host "Total services in running state = "$start.count
}
elseif($status -eq "Stopped")
{
$stop = Get-Service | ?{$_.Status -eq "Stopped"}
Write-Host "Total services in stopped state = "$stop.count
}
}
countservice -status Running
countservice -status Stopped