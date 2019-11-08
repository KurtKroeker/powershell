New-Item -ItemType Directory -Name "pipelines"

Get-ChildItem *.md |
    ForEach-Object {
		$file = [io.path]::GetFileNameWithoutExtension($_) + "_copied.md"
		Copy-Item $_ -Destination "pipeline\\"
	}
# TODO: fix me

# TODO: come up with a better pipelines demo; in the cmd console