param([string]$mics,[string]$ffmpeg)

$outfile="D:\rec\mics.wav"

& $ffmpeg -f dshow -i audio=$mics $outfile