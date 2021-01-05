#!/bin/bash
name=${PWD##*/}

echo "Give name of any external libraries to link"
read ANS

echo "Enable debugging? (y/n)"
read DEBUG

if [ -z "$ANS" ]; then
	if [ "$DEBUG" == "y" ] || [ "$DEBUG" == "yes" ]; then
		cc	-DDEBUG	$name.c -O -Wall -W -pedantic -ansi 	-o $name
	else
		cc	$name.c -O -Wall -W -pedantic -ansi 	-o $name	
	fi
else
	if [ "$DEBUG" == "y" ] || [ "$DEBUG" == "yes" ]; then
		cc	-DDEBUG $name.c -O -Wall -W -pedantic -ansi -l$ans	 	-o $name
	else
		cc	$name.c -O -Wall -W -pedantic -ansi -l$ans	 	-o $name	
	fi
fi

echo -e "\e[0;$[32]mBuilding and running program...\e[m"
./$name
