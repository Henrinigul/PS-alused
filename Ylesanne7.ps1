$groups = @("Red", "Green", "Yellow", "Blue")
$result = @()

for ($i = 1; $i -le 20; $i++) {
    $group = Get-Random $groups
    $temp = [PSCustomObject]@{
        RollNumber = $i
        Group = $group
    }
    $result += $temp
}

$result
