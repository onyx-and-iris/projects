param([switch]$rec, [switch]$stop)

Function Show{
    param($FF, [string[]]$CAPTURE, [string[]]$SCRIPTS)

    # Setup script arguments for play_top
    $run = "play_top"
    FOREACH ($file in $SCRIPTS) {
        if ($file -Match $run) {
            $THIS_SCRIPT = $file
        }
    }
    Start-Job -Name $run -ScriptBlock {
        & $args[2] -capture $args[0] -ffplay $args[1]
    } -ArgumentList $CAPTURE[0], $FF.FFPLAY, $THIS_SCRIPT

    # Setup script arguments for play_front
    $run = "play_front"
    FOREACH ($file in $SCRIPTS) {
        if ($file -Match $run) {
            $THIS_SCRIPT = $file
        }
    }
	Start-Job -Name $run -ScriptBlock {
        & $args[2] -capture $args[0] -ffplay $args[1]
	} -ArgumentList $CAPTURE[1], $FF.FFPLAY, $THIS_SCRIPT
}

Function Rec{
    param($FF, [string[]]$CAPTURE, [string[]]$SCRIPTS, $AUDIO)
    New-Item -ItemType Directory -Force -Path ".\rec"

    # Setup script arguments for play_top
    $run = "rec_top"
    FOREACH ($file in $SCRIPTS) {
        if ($file -Match $run) {
            $THIS_SCRIPT = $file
        }
    }
	Start-Job -Name $run -ScriptBlock {
		& $args[2] -capture $args[0] -ffmpeg $args[1]

	} -ArgumentList $CAPTURE[0], $FF.FFMPEG, $THIS_SCRIPT

    # Setup script arguments for play_front
    $run = "rec_front"
    FOREACH ($file in $SCRIPTS) {
        if ($file -Match $run) {
            $THIS_SCRIPT = $file
        }
    }
	Start-Job -Name $run -ScriptBlock {
		& $args[2] -capture $args[0] -ffmpeg $args[1]

	} -ArgumentList $CAPTURE[1], $FF.FFMPEG, $THIS_SCRIPT

    # Record mics
    $run = "rec__mics"
    FOREACH ($file in $SCRIPTS) {
        if ($file -Match $run) {
            $THIS_SCRIPT = $file
        }
    }
	Start-Job -Name $run -ScriptBlock {
		& $args[2] -mics $args[0] -ffmpeg $args[1]

	} -ArgumentList $AUDIO, $FF.FFMPEG, $THIS_SCRIPT
}

Function Stop{
    [string[]]$jobs = @("play_top", "play_front", "rec_top", "rec_front", "rec__mics")
    FOREACH ($job in Get-Job -State 'Running')
    {
        if ($jobs.Contains($job.name)) {
            Write-Host "Stopping ", $job.name
            Stop-Job $job
        }
    }

    Get-ChildItem ./rec/ -recurse | where {$_.extension -in ".mkv",".wav"} | % {
        $i = 1
        $StopLoop = $false
        do {
            try {
                Rename-Item -Path $_.FullName `
                -NewName "$($_.FullName).backup.$i" -ErrorAction 'Stop'
                $StopLoop = $true
            } 
            catch {
                Start-Sleep -m 100
                $i++
            }
        } until ($StopLoop -eq $true)
        
        [string[]]$OUTFILES += $_.FullName
    }
    FOREACH ($string in $OUTFILES) {
        $savefile = Split-Path $string -leaf
        Write-Host "Backed up file: ", $savefile
    }

	Exit
}


if ($MyInvocation.InvocationName -ne '.')
{  
    if($stop) { 
      Stop
    }

    $CONFIG_FILE = 'config.txt'
    $CAPTURE_CARD_PATTERN = '*Game Capture*Video*'
    $AUDIO_DEVICE_PATTERN = '*Mic/Line In 05/06*'


    # Load ffmpeg settings from config file, save to Hash
    $FF = Get-Content $CONFIG_FILE | ConvertFrom-StringData

    # Store dshow devices to Array
    $DATA = & $FF.FFMPEG -list_devices true -f dshow -i dummy 2>&1
    FOREACH ($line in $DATA) {
        if ($line -like $CAPTURE_CARD_PATTERN) {
            $line = $($line | Out-String).split('"')[1]
            [string[]]$CAPTURE += $line
        }

        if ($line -like $AUDIO_DEVICE_PATTERN) {
            $line = $($line | Out-String).split('"')[1].Trim()
            $AUDIO = $line.replace("`n",'').replace("`r",'')
        }
    }

    Write-Host "Using Devices:"
    FOREACH ($string in $CAPTURE) {
        Write-Host $string
    }
    Write-Host $AUDIO
    
    # Get all script files in working directory, save to string array
    Get-ChildItem ./ -recurse | where {$_.extension -eq ".ps1"} | % {
        [string[]]$SCRIPTS += $_.FullName
    }

    Show -FF $FF -CAPTURE $CAPTURE -SCRIPTS $SCRIPTS
    if($rec) { 
		Rec -FF $FF -CAPTURE $CAPTURE -SCRIPTS $SCRIPTS -AUDIO $AUDIO
	}
}
