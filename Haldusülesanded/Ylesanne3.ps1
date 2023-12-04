
# location of AD users file
$file = "C:\Users\Administrator\Documents\adkasutajad.csv"
# import file content
$users = Import-Csv $file -Encoding Default -Delimiter ";"
# foreach user data row in file
foreach ($user in $users) {
    # username is firstname.lastname
    $username = $user.FirstName + "." + $user.LastName
    $username = $username.ToLower()
    $username = Translit($username)
    # user principal name
    $upname = $username + "@sv-kool0.local"
    # display name - eesnimi + perenimi
    $displayname = $user.FirstName + " " + $user.LastName

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
            -AccountPassword (ConvertTo-SecureString $user.Password -AsPlainText -Force) -Enabled $true

        Write-Host "New user $username added successfully"
    }
}

# function translit UTF-8 characters to LATIN
function Translit {
    # function use as parameter string to translit
    param(
        [string] $inputString
    )
    # define the characters which have to be translited
    $Translit = @{
        [char]'ä' = "a"
        [char]'ö' = "o"
        [char]'ü' = "u"
        [char]'õ' = "o"
    }
    # create translited output
    $outputString=""
    # transfer string to array of characters and by character
    foreach ($character in $inputCharacter = $inputString.ToCharArray())
    {
        # if character is exsists in list of characters for transliting
        if ($Translit[$character] -cne $null){
            # add to output translited character
            $outputString += $translit[$character]
        } else {
            # otherwise add the initial character
            $outputString += $character
        }
    }
    Write-Output $outputString
}

