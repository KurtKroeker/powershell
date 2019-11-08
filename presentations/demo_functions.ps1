# TODO: add typed parameters in line/multiple rows
# TODO: show passing arguments
# TODO: validate parameters
function GetRandomNumber(
    [Parameter(Mandatory=$true)]
    $MinValue,
    [Parameter(Mandatory=$true)]
    $MaxValue
)
{
    $rand = Get-Random -Minimum $MinValue -Maximum $MaxValue
    return $rand
}
GetRandomNumber