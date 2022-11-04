[xml]$sessions=gc .\tb2022_sessions.xml
$sessions.div.div[0].ul.li
    |%{ 
        $session=$_; 
        @{ 
            sessionId=$session.'data-sessionId'; 
            speaker=$session.ul.li.a.InnerText; 
            title=$session.h3.InnerText.trim(); 
            description=$session.p.InnerText; 
            room=($session.div|?{$_.class -eq 'sz-session__room'}|select innerText,'data-roomid');
            time=($session.div|?{$_.class -eq 'sz-session__time'}).innerText }
    }|select sessionId,title,speaker,room|ConvertTo-Json|out-file .\sessions.json