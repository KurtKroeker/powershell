$c = gc .\tb2022_sessions.html -raw
$c = $c.replace("<br>","<br />").replace("&nbsp;"," ")

$a = $c.IndexOf('<div class="sz-timezone" style="display: none;">')
$b = $c.IndexOf('<div class="sz-tab-container sz-tab-container--active" id="sz-tab-0">')
$toReplace = $c.Substring($a, $b-$a)
$c = $c.Replace($toReplace,"")

$c|Out-File .\tb2022_sessions.xml