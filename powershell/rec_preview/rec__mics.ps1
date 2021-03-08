param([string]$mics, [string]$ffmpeg)

$outfile = "${PSScriptRoot}\rec\mics.wav"

& $ffmpeg -f dshow -i audio=$mics $outfile
