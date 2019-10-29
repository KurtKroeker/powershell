$l = Get-Location

# TODO: get my CD catalog
[xml]$cds = Get-Content .\cd_catalog.xml

"There are $($cds.catalog.cd.Count) CDs in my catalog"

# $matches = 0

# # TODO: output any cds from the 80s
# # TODO: find bob dylan cds

# foreach($cd in $cds.catalog.cd){
# 	if($cd.year -ge 1980 -and $cd.year -le 1989){
# 		$cd
# 		$matches++
# 	}
# }

# "$matches matches for the conditions"

# TODO: show match/notmatch
# TODO: show -replace, -split
# TODO: whatif for destructive actions

Set-Location $l