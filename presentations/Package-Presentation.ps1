param(
	[parameter(Mandatory = $true)]
	[string]$Name,
	[parameter(Mandatory = $true)]
	[string]$FolderPath
)

if([IO.Directory]::Exists($FolderPath) -eq $false)
{
	throw "Folder $FolderPath does not exist"
}

$tempFolderPath = "C:\powershell\presentations\$Name"
mkdir $tempFolderPath
copy C:\powershell\presentations\*.pptx -Destination $tempFolderPath
copy C:\powershell\presentations\demo_* -Destination $tempFolderPath
copy C:\powershell\presentations\*.json	-Destination $tempFolderPath
copy C:\powershell\presentations\*.csv -Destination $tempFolderPath

$dest = "C:\powershell\downloads\$Name.zip"
Compress-Archive -Path $tempFolderPath -DestinationPath $dest -Force
rmdir $tempFolderPath -Force -Recurse