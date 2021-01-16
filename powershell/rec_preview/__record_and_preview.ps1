param([switch]$rec)

$FFPLAY="E:\Smallware\ffmpeg\bin\ffplay.exe"
$FFMPEG="E:\Smallware\ffmpeg\bin\ffmpeg.exe"

# Write ffmpeg direct show devices to file
& $FFMPEG -list_devices true -f dshow -i dummy > D:\ffmpeg.txt 2>&1

# Get the capture card devices and save to array
[string[]]$CAPTURE=$(select-string -Path ffmpeg.txt -Pattern '(Game Capture.*Video)')
# Parse array
$CAPTURE = $CAPTURE | ForEach-Object { $_.split('"')[1] }

# Save audio device from file into string
$AUDIO = $(select-string -Path ffmpeg.txt -Pattern 'Mic/Line In 05/06') | Out-String 
$AUDIO = $AUDIO.split('"')[1]

Write-Host "Using Devices:"
FOREACH ($string in $CAPTURE) {
    Write-Host $string
}
Write-Host $AUDIO


Start-Job -Name play_top -ScriptBlock {
    D:\play_top.ps1 -capture $args[0] -ffplay $args[1]

} -ArgumentList $CAPTURE[0], $FFPLAY

Start-Job -Name play_front -ScriptBlock {
    D:\play_front.ps1 -capture $args[0] -ffplay $args[1]

} -ArgumentList $CAPTURE[1], $FFPLAY

if(-Not $rec) { 
    Write-Host "Output video stream only... quitting gracefully"
    exit 
}

Start-Job -Name rec_top -ScriptBlock {
    D:\rec_top.ps1 -capture $args[0] -ffmpeg $args[1]

} -ArgumentList $CAPTURE[0], $FFMPEG

Start-Job -Name rec_front -ScriptBlock {
    D:\rec_front.ps1 -capture $args[0] -ffmpeg $args[1]

} -ArgumentList $CAPTURE[1], $FFMPEG

Start-Job -Name rec__mics -ScriptBlock {
    D:\rec__mics.ps1 -audio $args[0] -ffmpeg $args[1]

} -ArgumentList $AUDIO, $FFMPEG

# Start-Job -Name mics_rec -ScriptBlock { D:\ffmpeg\multi_rec.ps1 }