
function Play-Sound($wavFilePath)
{
    if([io.file]::Exists($wavFilePath) -ne $true)
    {
        throw "Ain't no file at $wavFilePath, fool!"
    }

    $PlayWav=New-Object System.Media.SoundPlayer

    $PlayWav.SoundLocation = $wavFilePath

    $PlayWav.playsync()
}

New-Alias -Name "playwav" -Value "Play-Sound"

function clap {
    Play-Sound C:\ps\media\light_applause.wav
}

function endclap {
    Play-Sound C:\ps\media\end_claps.wav
}

function laughclap {
    Play-Sound C:\ps\media\laugh_applause.wav
}

"this is some output to the console"