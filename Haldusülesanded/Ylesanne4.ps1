# Function to translit UTF-8 characters to LATIN
function Translit {
    param(
        [string] $inputString
    )

    $translit = @{
        [char]'ä' = "a"
        [char]'ö' = "o"
        [char]'ü' = "u"
        [char]'õ' = "o"
    }

    $outputString = ""

    foreach ($character in $inputCharacter = $inputString.ToCharArray()) {
        if ($translit[$character] -ne $null) {
            $outputString += $translit[$character]
        } else {
            $outputString += $character
        }
    }

    Write-Output $outputString
}

# Prompt user for first and last name
$firstName = Read-Host "Enter the first name of the user"
$lastName = Read-Host "Enter the last name of the user"

# Create username by combining and transliterating the names
$username = Translit("$firstName.$lastName").ToLower()

# Display name
$displayName = "$firstName $lastName"

# Try to remove the user
try {
    Remove-ADUser -Identity $username -Confirm:$false
    Write-Host "User $displayName is removed successfully"
} catch {
    Write-Host "User not exists or problem is occuring during user removing, please try again"
}
