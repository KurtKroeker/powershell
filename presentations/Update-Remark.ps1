param(
    $PresentationFileName = "Presentation.html",    
    $PresentationMarkdownFileName = "powershell_presentation_notes.md",
    $PresentationTitle = ""
)

$isAbs = Split-Path $PresentationMarkdownFileName -IsAbsolute
if($isAbs -eq $false){    
    $PresentationMarkdownFileName = [io.path]::Combine($PSScriptRoot, $PresentationMarkdownFileName)
}

$presentation = Get-ChildItem $PresentationMarkdownFileName -ErrorAction Stop

$remarkTemplatePath = [io.path]::Combine($PSScriptRoot, "remark.html")

$presentationContent = Get-Content $PresentationMarkdownFileName -Encoding utf8
$presentationContent = $presentationContent.Replace("{{Title}}", $PresentationTitle)
$presentationContent = $presentationContent.Replace("{{PresentationContent}}", $presentationContent)

Copy-Item .\remark.html -Destination $PresentationFile

# Write presentation file
$presentationContent | Out-File $PresentationFileName