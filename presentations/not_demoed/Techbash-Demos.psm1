function Write-HelloTechbash
{  
    Write-Host "Hello, TechBash!"
}
Export-ModuleMember -Function Write-HelloTechbash

function Get-WeatherStation
{
    param(
        [Parameter(Mandatory = $true)]
        $weatherStationCode
    )

    return (Invoke-WebRequest -Method Get -Uri "http://services.energycap.com/UtilityServices/weather.aspx?m=lookup&s=$weatherStationCode").Content
}
Export-ModuleMember -Function Get-WeatherStation

<#
.SYNOPSIS
    Securely accepts a user's password and stores it as a variable in "global" scope.
#>
function Set-Credentials()
{
    $username = Read-Host -Prompt "Username"
    Set-Variable -Name "global:username" -Value $username
    $securePassword = Read-Host -Prompt "Password" -AsSecureString
    Set-Variable -Name "global:securePassword" -Value $securePassword

    $global:creds = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $username, $securePassword
    Set-Variable -Name "global:password" -Value $global:creds.GetNetworkCredential().Password

    $output = '
    Credentials saved. Use any of the following variables:

        $global:creds - PSCredential with the username/password you provided
        $global:username - username
        $global:securePassword - password saved as SecureString
        $global:password - plaintext password

'

    Write-Host $output -ForegroundColor Green
}
Export-ModuleMember -Function Set-Credentials