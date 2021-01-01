#!/bin/bash
: <<'END'
DESCRIPTION:
Batch conversion for the runner, this will execute the conversion script for each file in the current directory.
USE:
Simply run ./batch_conversion.sh
DISCLAIMER:
I do not take any responsibility for use of this script, I find it useful myself, feel free to use it.
END

for file in *.mp4 
do
	./runner.sh "$file"
done
