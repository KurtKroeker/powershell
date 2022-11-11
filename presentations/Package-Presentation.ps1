<#
.SYNOPSIS
	Package the presentation bits for people.
	Assumes that it lives in the /ps repository root.
#>
param(
	[parameter(Mandatory = $true)]
	[string]$OutputDirPath,
	[string]$ZipName = "DevelopersLovePowershell.zip"
)

$tmpDir = mkdir ([guid]::NewGuid()).tostring()
$outputDir = New-Object System.IO.DirectoryInfo $OutputDirPath
if(-not $outputDir.Exists){
	$outputDir.Create()
}

# Copy relevant files to temp folder
@(
	".\demo_*.ps1",
	".\sessions.json",
	".\PowerShell_Presentation.pptx"
)|%{ cp $_ $tmpDir }

Compress-Archive -Path "$($tmpDir.FullName)\*.*" -DestinationPath ([system.io.path]::combine($outputDir.FullName,$ZipName)) -Force
rmdir $tmpDir -Force -Recurse