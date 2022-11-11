<#
.SYNOPSIS

Says hello to the user!

.DESCRIPTION

Says hello to the user, and if they provide their name, will greet them by name.

.PARAMETER Name
Specifies the file name.

.INPUTS

System.String representing the user's name 

.OUTPUTS

None; writes to console.

.EXAMPLE

PS> Say-Hello
Hello, world!

.EXAMPLE

PS> Say-Hello -to kurt
Hello, kurt!
#>

param(
    $To = "world"
)

Write-Host "Hello, $To!" -ForegroundColor Blue -BackgroundColor Green