param([switch]$rec, [switch]$stop)

Function Show{
    param(
    [string[]]$JOBS, $FF, [string[]]$CAPTURE, [string[]]$SCRIPTS
    )

    $i = 0
    ForEach ($job in $JOBS) {
        if ($job -And $job.Contains('play')) {
            ForEach ($file in $SCRIPTS) {
                if ($file -Match $job) {
                    $THIS_SCRIPT = $file
                }
            }
            Start-Job -Name $job -ScriptBlock {
                & $args[2] -capture $args[0] -ffplay $args[1]
            } -ArgumentList $CAPTURE[$i], $FF.FFPLAY, $THIS_SCRIPT
            $i++
        }
    }
}

Function Rec{
    param(
    [string[]]$JOBS, $FF, [string[]]$CAPTURE, [string[]]$SCRIPTS, $AUDIO
    )
    if (-Not(Test-Path -Path ".\rec")) {
        New-Item -ItemType Directory -Force -Path ".\rec"
    }

    $i = 0
    ForEach ($job in $JOBS) {
        if ($job) {
            if ($job.Contains('rec_cap')) {
                ForEach ($file in $SCRIPTS) {
                    if ($file -Match $job) {
                        $THIS_SCRIPT = $file
                    }
                }
                Start-Job -Name $job -ScriptBlock {
                    & $args[2] -capture $args[0] -ffmpeg $args[1] -name $args[3]

                } -ArgumentList $CAPTURE[$i], $FF.FFMPEG, $THIS_SCRIPT, $job
                $i++
            }
            
            elseif ($job -eq 'rec_mics') {
                ForEach ($file in $SCRIPTS) {
                    if ($file -Match $job) {
                        $THIS_SCRIPT = $file
                    }
                }
                Start-Job -Name $job -ScriptBlock {
                    & $args[2] -mics $args[0] -ffmpeg $args[1] -name $args[3]

                } -ArgumentList $AUDIO, $FF.FFMPEG, $THIS_SCRIPT, $job            
            }
        }
    }
}

Function Stop{
    param(
        [string[]]$JOBS, $FF, [string[]]$CAPTURE, [string[]]$SCRIPTS, $AUDIO
    )
    
    ForEach ($JobObj in Get-Job -State 'Running')
    {
        if ($JOBS.Contains($JobObj.name)) {
            Write-Host "Stopping ", $JobObj.name
            Stop-Job $JobObj
        }
    }

    Get-ChildItem ./rec/ -recurse | Where {$_.extension -in ".mkv",".wav"} | % {
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
    ForEach ($string in $OUTFILES) {
        $savefile = Split-Path $string -leaf
        Write-Host "Backed up file: ", $savefile
    }

	Exit
}


if ($MyInvocation.InvocationName -ne '.')
{  
    [string[]]$JOBS = @("play_top", "play_front", "rec_cap_top", "rec_cap_front", "rec_mics")
    if($stop) { 
      Stop -JOBS $JOBS
    }

    $CONFIG_FILE = 'config.txt'
    $CAPTURE_CARD_PATTERN = '*Game Capture*Video*'
    $AUDIO_DEVICE_PATTERN = '*Mic/Line In 05/06*'
    
    # Load ffmpeg settings from config file, save to Hash
    $FF = Get-Content $CONFIG_FILE | ConvertFrom-StringData

    # Store dshow devices to Array
    $DATA = & $FF.FFMPEG -list_devices true -f dshow -i dummy 2>&1
    ForEach ($line in $DATA) {
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
    ForEach ($string in $CAPTURE) {
        Write-Host $string
    }
    if ($AUDIO) { Write-Host $AUDIO }
    
    # Get all script files in working directory, save to string array
    Get-ChildItem ./ -recurse | Where {$_.extension -eq ".ps1"} | % {
        [string[]]$SCRIPTS += $_.FullName
    }

    Show -JOBS $JOBS -FF $FF -CAPTURE $CAPTURE -SCRIPTS $SCRIPTS
    if($rec) { 
		Rec -JOBS $JOBS -FF $FF -CAPTURE $CAPTURE -SCRIPTS $SCRIPTS -AUDIO $AUDIO
	}
}
