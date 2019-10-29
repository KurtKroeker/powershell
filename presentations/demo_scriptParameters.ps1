# TODO: add parameters
# TODO: act upon parameters

param(
	$param1,
	$param2
)

if($param1 -eq "foo"){
	"you must be a developer!"
}

Write-Host "$param1 $param2" -ForegroundColor Magenta