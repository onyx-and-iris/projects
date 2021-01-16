param([string]$mics,[string]$ffmpeg)

$outfile="D:\ffmpeg\rec\mics.wav"

& $ffmpeg -f dshow -i audio=$mics $outfile