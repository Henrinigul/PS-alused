Get-Process | ?{$_.ProcessName -eq "notepad"} | Select ProcessName,Id

Second question:
Get-ChildItem -Path "C:\temp\test"
$fail = Get-ChildItem -Path "C:\temp\test" | where {$_.Name -like "*.csv"} | Select
Name,Length
$KBmaht = $fail.Length/1KB
$MBmaht = $fail.Length/1MB
Write-Host "`nFileName : "$fail.Name
Write-Host "Size in KB : "$KBmaht
Write-Host "Size in MB : "$MBmaht