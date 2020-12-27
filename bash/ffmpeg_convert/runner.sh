#!/bin/bash

: <<'END'
DESCRIPTION:
Runner for batch_conversion.sh.
This bash script calls ffmpeg to convert an mp4 file to an editor friendly mxf file. It tests if the file extension was given.
It also tests if the file exists and whether or not it has already been converted.
USE:
Can be used as a runner for by executing ./batch_conversion.sh
Can be used standalone to convert a single mp4 to mxf by passing the filename to as argument variable.
eg. ./convert.sh filename.mp4
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

#check if file exists
if [ -f "$FILE_IN" ]
then
	#check if file was converted already
	if [ ! -f "$FILE_OUT" ]
	then
		echo "DEBUG:	Converting $FILE_IN to $FILE_OUT"
		ffmpeg -i $FILE_IN -c:v dnxhd -b:v 290M -c:a pcm_s16le -r 60 $FILE_OUT
	else
		echo "ERROR: $FILE_IN was already converted!"
	fi
else
	echo "ERROR: File does not exist"
fi
