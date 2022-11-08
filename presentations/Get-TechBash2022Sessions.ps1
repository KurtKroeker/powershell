# Get TechBash sessions
Import-Module C:\tools\chromedriver\WebDriver.dll
$Chrome = New-Object OpenQA.Selenium.Chrome.ChromeDriver
$Chrome.Navigate().GoToUrl("https://www.techbash.com/sessions")
Start-Sleep -Seconds 1
$criteria = [OpenQA.Selenium.By]::Id("sessionize")
$e = $Chrome.FindElement($criteria)
$html = $e.GetAttribute("outerHTML")
$Chrome.Close()
$html|Out-File -FilePath .\tb2022_sessions.html

# Convert HTML to valid XML
$c = gc .\tb2022_sessions.html -raw
$c = $c.replace("<br>","<br />").replace("&nbsp;"," ")
$a = $c.IndexOf('<div class="sz-timezone" style="display: none;">')
$b = $c.IndexOf('<div class="sz-tab-container sz-tab-container--active" id="sz-tab-0">')
$toReplace = $c.Substring($a, $b-$a)
$c = $c.Replace($toReplace,"")
$c|Out-File .\tb2022_sessions.xml

# Convert XML to JSON
[xml]$sessions=gc .\tb2022_sessions.xml
$sessions.div.div[0].ul.li
    |%{ 
        $session=$_; 
        @{ 
            sessionId=$session.'data-sessionId'; 
            speaker=$session.ul.li.a.InnerText; 
            title=$session.h3.InnerText.trim(); 
            description=$session.p.InnerText; 
            room=($session.div|?{$_.class -eq 'sz-session__room'}|%{ @{ roomName=$_.innerText; roomId=$_.'data-roomid'} });
            time=($session.div|?{$_.class -eq 'sz-session__time'}).innerText }
    }|select sessionId,title,speaker,room|ConvertTo-Json|out-file .\sessions.json