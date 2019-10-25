# TODO: add parameters
# TODO: show passing arguments
function GetRandomNumber()
{
    $rand = Get-Random -Maximum 1000 -Minimum 1
    return $rand
}
GetRandomNumber