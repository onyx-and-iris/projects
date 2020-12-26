#!/bin/bash

: <<'END'
This bash script calls ffmpeg to convert an mp4 file to an editor friendly mxf file. It tests if the file extension was given.
It also tests if the file exists and whether or not it has already been converted.
DISCLAIMER:
I take no responsibility for use of this script, I find it useful myself, feel free to use it at your own risk.
END


FILE_IN="$1"

#check if mp4 extension was passed to script
if [ "${FILE_IN: -4}" != ".mp4" ]
then
	FILE_IN+=".mp4"
fi

#replace .mp4 extension with .mxf 
FILE_OUT="${FILE_IN%.mp4}.mxf"

if [ -f "$FILE_IN" ]
then
	if [ ! -f "$FILE_OUT" ]
	then
		echo "DEBUG:	Converting $FILE_IN to $FILE_OUT"
		ffmpeg -i $FILE_IN -c:v dnxhd -b:v 290M -c:a pcm_s16le -r 60 $FILE_OUT
	else
		echo "ERROR: File was already converted!"
	fi
else
	echo "ERROR: File does not exist"
fi
