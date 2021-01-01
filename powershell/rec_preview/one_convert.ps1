$DIREXE_FFMPEG="E:\ffmpeg\ffmpeg\bin\ffmpeg.exe"

$CAPTURE_ONE="Game Capture 4K60 Pro MK.2"

$OUT_ONE="E:\ffmpeg\rec\top.mkv"

#NVENC TESTING SEEMS GOOD:
#& $DIREXE_FFMPEG -f dshow -rtbufsize 300M -i video="$CAPTURE_ONE" -r 60 -vsync 0 -c:v h264_nvenc -rc:v vbr_hq -cq:v 19 -b:v 5000k -maxrate:v 8000k -profile:v high -t 00:01:00 "$OUT_ONE"
#LETS PUSH IT FURTHER SEEMS DECENT STILL ABOUT 20 MBPS
& $DIREXE_FFMPEG -f dshow -rtbufsize 300M -i video="$CAPTURE_ONE" -r 60 -vsync 0 -c:v h264_nvenc -rc:v vbr_hq -cq:v 19 -b:v 12000k -maxrate:v 20000k -profile:v high -t 00:01:00 "$OUT_ONE"

#SIMPLE CRF GOOD! ================) X264 CRF WINS
#& $DIREXE_FFMPEG -f dshow -rtbufsize 400M -i video="$CAPTURE_ONE" -r 60 -c:v libx264 -preset slow -crf 22 -t 00:01:00 "$OUT_ONE"