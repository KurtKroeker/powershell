# TODO: add typed parameters
# TODO: show passing arguments
# TODO: validate parameters
function GetRandomNumber
{
    $rand = Get-Random -Minimum 1 -Maximum 1000
    return $rand
}
GetRandomNumber