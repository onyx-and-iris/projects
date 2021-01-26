#!/bin/bash

if [ $# -eq 0 ]; then
        exit
fi

IP1=X.X.X.X
IP2=Y.Y.Y.Y

sound_test () {
        if [[ "$1" == "onyx" ]]; then
                if [[ "$2" -eq 1 ]]; then
                        /home/onyx/github/vban/src/vban_sendtext -i $IP1 -p 6990 \
-sonyx_sound_t "Strip(0).A1=1; Strip(0).A2=1; Strip(0).B1=0; Strip(0).B2=0; Strip(0).mono=1;"
                else
                        /home/onyx/github/vban/src/vban_sendtext -i $IP1 -p 6990 \
-sonyx_sound_t "Strip(0).A1=0; Strip(0).A2=0; Strip(0).B1=1; Strip(0).B2=1; Strip(0).mono=0;"
                fi

        elif [[ "$1" == "iris" ]]; then
                if [[ "$2" -eq 1 ]]; then
                        /home/onyx/github/vban/src/vban_sendtext -i $IP2 -p 6990 \
-siris_sound_t "Strip(0).A1=1; Strip(0).A2=1; Strip(0).B1=0; Strip(0).B2=0; Strip(0).mono=1;"
                else
                        /home/onyx/github/vban/src/vban_sendtext -i $IP2 -p 6990 \
-siris_sound_t "Strip(0).A1=0; Strip(0).A2=0; Strip(0).B1=1; Strip(0).B2=1; Strip(0).mono=0;"
                fi
        fi
}

case "$1" in
        "-sound_t" )
                sound_test "$2" "$3"
                ;;
        * )
        ;;
esac