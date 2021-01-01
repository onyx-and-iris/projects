$DIREXE_FFPLAY="E:\ffmpeg\ffmpeg\bin\ffplay.exe"

$CAPTURE_TWO="Game Capture 4K60 Pro MK.2 (2)"

& $DIREXE_FFPLAY -f dshow -i video="$CAPTURE_TWO" -vf scale=1024:-1