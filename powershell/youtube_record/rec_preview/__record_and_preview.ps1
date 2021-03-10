param([switch]$rec, [switch]$stop)

Function Show{
    param(
    [string[]]$JOBS, $FF, [string[]]$CAPTURE, [string[]]$SCRIPTS
    )
    # Set up args for each job and run script as background process
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
    # Set up args for each job and run script as background process
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
    # Stop running jobs and back them up in a rotation
    ForEach ($JobObj in Get-Job -State 'Running')
    {
        if ($JOBS.Contains($JobObj.name)) {
            Write-Host "Stopping ", $JobObj.name
            Stop-Job $JobObj
        }
    }

    Get-ChildItem ./rec/ -recurse | Where-Object {$_.extension -in ".mkv",".wav"} | % {
        $i = 1
        $StopLoop = $false
        $DIR = $_.DirectoryName
        do {
            try {
                $SAVEDFILE = "$($_.BaseName)_$i.backup" 
                Rename-Item -Path $_.FullName `
                -NewName $SAVEDFILE -ErrorAction 'Stop'

                [string[]]$SAVEDFILES `
                += $(Join-Path -Path $DIR `
                -ChildPath $SAVEDFILE)

                $StopLoop = $true
            } 
            catch {
                Start-Sleep -m 100
                $i++
            }      
        } until ($StopLoop -eq $true)
    }

    $CRED = Get-Content "${PSScriptRoot}\credentials.txt" | ConvertFrom-StringData
    $server = $($CRED.SERVER | Out-String).Trim()
    $password = ConvertTo-SecureString -AsPlainText $CRED.PASSWORD -Force
    $cred = New-Object System.Management.Automation.PSCredential $CRED.USERNAME,$password		

    ForEach ($string in $SAVEDFILES) {
        $savefile = Split-Path $string -Leaf
        Write-Host "Backed up file: ", $savefile
        
        Transfer -SOURCE $string -SAVEFILE $savefile -SERVER $server
    }

    if ($SAVEDFILES) {	
        Invoke-Command -ComputerName $server -Credential $cred -ScriptBlock { X:\DNxHD\ffmpeg_convert.ps1 }
        Invoke-Command -ComputerName $server -Credential $cred -ScriptBlock { Y:\DNxHD2\ffmpeg_convert.ps1 }
    }

    Exit
}

Function Transfer {
    param([string[]]$SOURCE, $SAVEFILE, $SERVER)
    # Transfer to workstation for DNxHD conversion
    $DIR_SOURCE = $(Split-Path -Path $SOURCE)
    if ($SAVEFILE -Match 'top') {
        $DIR_DEST = "\\${SERVER}\DNxHD\"
    }
    elseif ($SAVEFILE -Match 'front') {
        $DIR_DEST = "\\${SERVER}\DNxHD2\"
    }
	elseif ($SAVEFILE -Match 'mics') {
		$DIR_DEST = "\\${SERVER}\DNxHD\_audio\"
	}
    
    robocopy $DIR_SOURCE $DIR_DEST $SAVEFILE /min:10 
}


if ($MyInvocation.InvocationName -ne '.')
{  
    [string[]]$JOBS = @("play_top", "play_front", "rec_cap_top", "rec_cap_front", "rec_mics")
    if($stop) { 
      Stop -JOBS $JOBS
    }

    $CONFIG_FILE = "${PSScriptRoot}\config.txt"
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
    Get-ChildItem ./ -recurse | Where-Object {$_.extension -eq ".ps1"} | % {
        [string[]]$SCRIPTS += $_.FullName
    }

    Show -JOBS $JOBS -FF $FF -CAPTURE $CAPTURE -SCRIPTS $SCRIPTS
    if($rec) { 
        Rec -JOBS $JOBS -FF $FF -CAPTURE $CAPTURE -SCRIPTS $SCRIPTS -AUDIO $AUDIO
	}
}
