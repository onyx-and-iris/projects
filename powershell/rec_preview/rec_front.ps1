param([string]$capture,[string]$ffmpeg)

$outfile="E:\rec\front.mkv"

#LETS PUSH IT FURTHER SEEMS DECENT STILL ABOUT 30 MBPS
& $ffmpeg -f dshow -rtbufsize 2000M -i video=$capture -c:v h264_nvenc -rc:v vbr_hq -cq:v 19 -b:v 16000k -maxrate:v 30000k -profile:v high $outfile

########## TESTS ###########
#--H264

#NVENC BEST SO FAR ITS GOOD ABOUT 12 MBPS:
#& $DIREXE_FFMPEG -f dshow -rtbufsize 2000M -i video="$CAPTURE_TWO_HD" -r 60 -vsync 0 -c:v h264_nvenc -rc:v vbr_hq -cq:v 19 -b:v 5000k -maxrate:v 8000k -profile:v high -t 00:01:00 "$OUT_TWO"

#--X264

#SIMPLE CRF GOOD! ================) X264 CRF WINS LIGHTER CONVERSION FOR SLOWER CPUS
#& $DIREXE_FFMPEG -f dshow -rtbufsize 2000M -i video="$CAPTURE_TWO_HD" -r 60 -c:v libx264 -preset fast -crf 22 -t 00:01:00 "$OUT_TWO"

#SIMPLE CRF GOOD! ================) X264 CRF WINS
#& $DIREXE_FFMPEG -f dshow -rtbufsize 500M -i video="$CAPTURE_TWO_HD" -r 60 -c:v libx264 -preset slow -crf 22 -c:a copy -t 00:05:00 "$OUT_TWO"