$DIREXE_FFMPEG="E:\ffmpeg\ffmpeg\bin\ffmpeg.exe"
$DIREXE_FFPLAY="E:\ffmpeg\ffmpeg\bin\ffplay.exe"

$MICS="Mic/Line In 05/06 (Soundcraft MADI-USB Combo card)"

$OUT_WAV="E:\ffmpeg\rec\mics.wav"

& $DIREXE_FFMPEG -f dshow -i audio="$MICS" -t 01:00:00 $OUT_WAV
