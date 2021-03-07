param([string]$capture,[string]$ffmpeg)

$outfile="D:\rec\top.mkv"

#LETS PUSH IT FURTHER SEEMS DECENT STILL ABOUT 30 MBPS
& $ffmpeg -f dshow -rtbufsize 2000M -i video=$capture -c:v h264_nvenc -rc:v vbr_hq -cq:v 19 -b:v 16000k -maxrate:v 30000k -profile:v high $outfile

########## TESTS ###########
#--H264

#NVENC TESTING SEEMS GOOD:
#& $DIREXE_FFMPEG -f dshow -rtbufsize 2000M -i video="$CAPTURE_ONE_HD" -c:v h264_nvenc -rc:v vbr_hq -cq:v 19 -b:v 5000k -maxrate:v 8000k -profile:v high -t 00:01:00 "$OUT_ONE"

#--X264

#SIMPLE CRF GOOD! ================) X264 CRF WINS LIGHTER CONVERSION FOR SLOWER CPUS
#& $DIREXE_FFMPEG -f dshow -rtbufsize 2000M -i video="$CAPTURE_ONE_HD" -r 60 -c:v libx264 -preset fast -crf 22 -t 00:01:00 "$OUT_ONE"

#SIMPLE CRF GOOD! ================) X264 CRF WINS NEEDS POWERFUL CPU FOR 2xCAPTURE CARDS
#& $DIREXE_FFMPEG -f dshow -rtbufsize 500M -i video="$CAPTURE_ONE_HD" -r 60 -c:v libx264 -preset slow -crf 22 -t 00:05:00 "$OUT_ONE"