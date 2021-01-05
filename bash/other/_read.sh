#!/bin/bash
#This script allows you to extract ebooks in of any supported format from an archive library.
#Library archive type must be supported by p7zip-full package
#This script was written for use on LIVE distros for fast ebook reading. Script assumes it sits in the same directory
#as your e-book libraries :)

TYPE=7z		#Set the archive type (.zip,.7z,.tar.gz etc...)
DEST=~/curBooks	#Set the destination directory to extract to
USER=$(whoami)

if [ $(dpkg-query -W -f='${Status}' fbreader 2>/dev/null | grep -c "ok installed") -eq 0 ];
then
echo "deb http://fbreader.org/desktop/debian stable main" >> /etc/apt/sources.list

echo "deb-src http://fbreader.org/desktop/debian stable main" >> /etc/apt/sources.list

apt-get update && apt-get install fbreader

else
echo "EPUB reader already installed!"
fi


if [ $(dpkg-query -W -f='${Status}' p7zip-full 2>/dev/null | grep -c "ok installed") -eq 0 ];
then

apt-get update && apt-get install p7zip-full

else
echo "7zip already installed!"
fi

echo "Possible libraries to choose from:"
ls -l ./*.$TYPE | cut -d/ -f2

echo "Give full or partial library name"
read library

echo "Give format of book (epub,pdf etc...)"
read format

echo "List of  possible books:"
7z l "$library*.$TYPE" "$format/*" | cut -d] -f2

echo "Give full or partial file name"
read file

mkdir -p $DEST

7z e $library*.$TYPE -o$DEST \[*\]*$file*.$format -r

echo "Your book(s) has been extracted to $DEST"

chown $USER:$USER -R $DEST

sleep 0.2

if [ $format == "epub" ]; then
	echo "Opening book in FBREADER"
	cd $DEST && fbreader *$file*.$format &
else
	echo "Opening book in EVINCE"
	cd $DEST && evince *$file*.$format &
fi
