$eesnimi = Read-Host "Sisesta kasutaja eesnimi"
$perenimi = Read-Host "Sisesta kasutaja perenimi"

$kasutajanimi = "$eesnimi.$perenimi"
$taisnimi = "$eesnimi $perenimi"

try {
    Remove-LocalUser -Name $kasutajanimi -ErrorAction Stop
    Write-Host "Kasutaja $taisnimi on kustutatud."
}
catch {
    Write-Host "Viga kasutaja kustutamisel: $_"
}
