# Import System.Web assembly
Add-Type -AssemblyName System.Web

# location of AD users file
$file = "C:\Users\Administrator\Documents\adkasutajad.csv"
# import file content
$users = Import-Csv $file -Encoding Default -Delimiter ";"

foreach ($user in $users) {
    # username is firstname.lastname
    $username = $user.FirstName + "." + $user.LastName
    $username = $username.ToLower()
    $username = Translit($username)
    # user principal name
    $upname = $username + "@sv-kool0.local"
    # display name - eesnimi + perenimi
    $displayname = $user.FirstName + " " + $user.LastName

    # Generate a strong and compliant password
    $password = GenerateStrongPassword 12

    # Check if user already exists
    if (Get-ADUser -Filter {SamAccountName -eq $username}) {
        Write-Host "User $username already exists - cannot add this user"
    } else {
        # User does not exist, create new user
        New-ADUser -Name $username `
            -DisplayName $displayname `
            -GivenName $user.FirstName `
            -Surname $user.LastName `
            -Department $user.Department `
            -Title $user.Role `
            -UserPrincipalName $upname `
            -AccountPassword (ConvertTo-SecureString $password -AsPlainText -Force) -Enabled $true

        Write-Host "New user $username added successfully"

        # Save username and generated password to a CSV file
        $user | Select-Object @{Name='Username';Expression={$username}}, @{Name='Password';Expression={$password}} | Export-Csv -Path "$username.csv" -NoTypeInformation
        Write-Host "Username and password saved to $username.csv"
    }
}

# function translit UTF-8 characters to LATIN
function Translit {
    param(
        [string] $inputString
    )
    $Translit = @{
        [char]'ä' = "a"
        [char]'ö' = "o"
        [char]'ü' = "u"
        [char]'õ' = "o"
    }
    $outputString=""
    foreach ($character in $inputCharacter = $inputString.ToCharArray()) {
        if ($Translit[$character] -cne $null){
            $outputString += $translit[$character]
        } else {
            $outputString += $character
        }
    }
    Write-Output $outputString
}

# Function to generate a strong and compliant password
function GenerateStrongPassword {
    param (
        [Parameter(Mandatory=$true)][int]$PasswordLength
    )

    $PassComplexCheck = $false
    do {
        $newPassword = [System.Web.Security.Membership]::GeneratePassword($PasswordLength, 3)
        if ($newPassword -cmatch "[A-Z\p{Lu}\s]" -and
            $newPassword -cmatch "[a-z\p{Ll}\s]" -and
            $newPassword -match "[\d]" -and
            $newPassword -match "[^\w]") {
            $PassComplexCheck = $true
        }
    } while ($PassComplexCheck -eq $false)

    return $newPassword
}

