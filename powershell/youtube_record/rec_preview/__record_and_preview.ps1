param([switch]$rec, [switch]$stop)

Function Show{
    param(
        [string[]]$JOBS, $FF, [string[]]$CAPTURE, [string[]]$SCRIPTS
    )

    # Set up args for each job and run script as background process
    ForEach ($job in $JOBS) {
        if ($job -And $job.Contains('play')) {
            if ($job.Contains([Captures]::top)) { $num = [int][Captures]::top }
            elseif ($job.Contains([Captures]::front)) { $num = [int][Captures]::front }

            ForEach ($file in $SCRIPTS) {
                if ($file -Match $job) {
                    $THIS_SCRIPT = $file
                }
            }

            Start-Job -Name $job -ScriptBlock {
                & $args[2] -capture $args[0] -ffplay $args[1]
            } -ArgumentList $CAPTURE[$num], $FF.FFPLAY, $THIS_SCRIPT
        }
    }
}

Function Rec{
    param(
        [string[]]$JOBS, $FF, [string[]]$CAPTURE, [string[]]$SCRIPTS, $AUDIO
    )

    ForEach ($drive in $global:DRIVES) {
        $dir_rec = $drive + "rec"
        if (-Not(Test-Path -Path $dir_rec)) {
            Write-Host "Record path doesn't exit... creating directory"
            New-Item -ItemType Directory -Path $dir_rec
        }
    }
    # Set up args for each job and run script as background process
    ForEach ($job in $JOBS) {
        if ($job) {
            if ($job.Contains('rec_cap')) {
                if ($job.Contains([Captures]::top)) { $num = [int][Captures]::top }
                elseif ($job.Contains([Captures]::front)) { $num = [int][Captures]::front }
                
                ForEach ($file in $SCRIPTS) {
                    if ($file -Match $job) {
                        $THIS_SCRIPT = $file
                    }
                }
                Start-Job -Name $job -ScriptBlock {
                    & $args[2] -capture $args[0] -ffmpeg $args[1] -name $args[3]

                } -ArgumentList $CAPTURE[$num], $FF.FFMPEG, $THIS_SCRIPT, $job
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
    ForEach ($JobObj in Get-Job -State "Running")
    {
        if ($JOBS.Contains($JobObj.name)) {
            Write-Host "Stopping ", $JobObj.name
            Stop-Job $JobObj
        }
    }

    ForEach ($drive in $global:DRIVES) {
        Get-ChildItem $(Join-Path -Path $drive -ChildPath "rec") -recurse `
        | Where-Object {$_.extension -in ".mkv",".wav" -And $_.Length -gt 0kb } `
        | % {
            $i = 1
            $StopLoop = $false
            $DIR = $_.DirectoryName
            
            do {
                try {
                    $SAVEDFILE = "$($_.BaseName)_$i.backup" 
                    Rename-Item -Path $_.FullName `
                    -NewName $SAVEDFILE -ErrorAction "Stop"

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
    }

    if ($SAVEDFILES) { Remote -SAVEDFILES $SAVEDFILES }
    
    Exit
}

Function Remote {
    param([string[]]$SAVEDFILES)

    # Get PSRemote Credentials and run Transfer and Conversion operations
    $CRED = Get-Content "${PSScriptRoot}\credentials.txt" | ConvertFrom-StringData
    $server = $($CRED.SERVER | Out-String).Trim()
    $password = ConvertTo-SecureString -AsPlainText $CRED.PASSWORD -Force
    $CredObj = New-Object System.Management.Automation.PSCredential $CRED.USERNAME,$password		

    ForEach ($string in $SAVEDFILES) {
        $savefile = Split-Path $string -Leaf
        Write-Host "Backed up file: ", $savefile
        
        Transfer -SOURCE $string -SAVEFILE $savefile -SERVER $server
    }

    Convert -CRED $CRED -CredObj $CredObj
}

Function Transfer {
    param([string[]]$SOURCE, $SAVEFILE, $SERVER)

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
    
    robocopy $DIR_SOURCE $DIR_DEST $SAVEFILE
}

Function Convert {
    param($CRED, $CredObj)

    Write-Host "Invoking:", $CRED.SCRIPT_TOP
    Invoke-Command -ComputerName $server -Credential $CredObj `
    -ScriptBlock { param($command) Invoke-Expression $command } `
    -ArgumentList $CRED.SCRIPT_TOP

    Write-Host "Invoking:", $CRED.SCRIPT_FRONT
    Invoke-Command -ComputerName $server -Credential $CredObj `
    -ScriptBlock { param($command) Invoke-Expression $command } `
    -ArgumentList $CRED.SCRIPT_FRONT    
}


if ($MyInvocation.InvocationName -ne '.')
{  
    $global:DRIVES=@("X:\", "Y:\")

    Get-ChildItem ./ -recurse `
    | Where-Object {$_.extension -eq ".ps1" -And $_.Name -notmatch "^__*"} `
    | % {
        [string[]]$SCRIPTS += $_.FullName
        [string[]]$JOBS += $_.BaseName
    }

    Enum Captures{ 
        top
        front
    }

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
    else { Write-Host "No audio device connected" }

    Show -JOBS $JOBS -FF $FF -CAPTURE $CAPTURE -SCRIPTS $SCRIPTS
    if($rec) { 
        Rec -JOBS $JOBS -FF $FF -CAPTURE $CAPTURE -SCRIPTS $SCRIPTS -AUDIO $AUDIO
    }
}
