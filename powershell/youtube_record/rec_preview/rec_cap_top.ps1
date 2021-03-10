param([string]$capture, [string]$ffmpeg, [string]$name)

$outfile = "X:\rec\$name.mkv"

& $ffmpeg -f dshow `
-rtbufsize 2000M -framerate 60 -i video=$capture `
-c:v h264_nvenc -rc constqp -qp 19 -profile:v high `
$outfile
