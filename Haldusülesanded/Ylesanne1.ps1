$eesnimi = Read-Host "Sisesta oma nimi"
$perenimi = Read-Host "Sisesta oma perenimi"

$kasutajanimi = "$eesnimi.$perenimi"

$taisnimi = "$eesnimi $perenimi"

$teade = "See on kasutaja $taisnimi"

$kasutajanimiVaiketahtedega = $kasutajanimi.ToLower()

$securePassword = ConvertTo-SecureString "Parool1!" -AsPlainText -Force

try {
    New-LocalUser -Name $kasutajanimiVaiketahtedega -Description $teade -Password $securePassword -ErrorAction Stop

    
    Set-LocalUser -Name $kasutajanimiVaiketahtedega -PasswordNeverExpires $true

    Write-Host "Kasutaja $kasutajanimi on loodud."
}
catch {
    Write-Host "Viga kasutaja loomisel: $_"
}



