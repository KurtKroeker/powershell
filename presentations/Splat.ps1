. "C:\Users\kurtk\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1"

$hash = @{"baseURI" = "https://implement.energycap.com"; "userName"="kurt"; "password"="TechBash2019"; "dataSource"="demo"}

#EC-Login -dataSource -password -userName -baseURI
EC-Login @hash
