$value1 = Read-Host "Sisesta esimene väärtus"
$value2 = Read-Host "Sisesta teine väärtus"

if ($value1 -gt $value2) {
    Write-Host "Suurem number on : $value1"
} else {
    Write-Host "Suurem number on : $value2"
}

Write-Host "Vali Riik" -ForegroundColor Yellow
Write-Host "1 : India" -ForegroundColor Cyan
Write-Host "2 : Australia" -ForegroundColor Cyan
Write-Host "3 : China" -ForegroundColor Cyan

$valik = Read-Host "Palun vali riik"
if ($valik -eq "1") {
    Write-Host "India pealinn on New Delhi" -ForegroundColor Green
} elseif ($valik -eq "2") {
    Write-Host "Austraalia pealinn on Canberra" -ForegroundColor Green
} elseif ($valik -eq "3") {
    Write-Host "Hiina pealinn on Beijing" -ForegroundColor Green
} else {
    Write-Host "Vale valik" -ForegroundColor Red
}
