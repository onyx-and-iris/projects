param([string]$mics, [string]$ffmpeg, [string]$name)

$outfile = "${PSScriptRoot}\rec\$name.wav"

& $ffmpeg -f dshow -i audio=$mics $outfile
