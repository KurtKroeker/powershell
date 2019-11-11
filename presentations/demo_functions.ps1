# TODO: add typed parameters in line/multiple rows
# TODO: show passing arguments
# TODO: validate parameters
function Get-RandomNumberCustom
{
    $rand = Get-Random -Minimum 1 -Maximum 10
    return $rand
}
Get-RandomNumberCustom