New-Item -ItemType Directory -Name "pipelines"

Get-ChildItem *.md |
    ForEach-Object {
        [io.path]::GetFileNameWithoutExtension($_) + "_copied.md"
    } |
    Copy-Item -Destination "pipelines"