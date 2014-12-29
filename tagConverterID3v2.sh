#!/bin/bash
#########################################
FBNAME=`basename "$1" .mp3`
NAME=${1%%.*}
EXT=${1##*.}
IDVERS=`id3v2 -l "$1" | grep TIT2 | wc -l`
ALBUM=`id3v2 -l "$1" | grep TALB | cut -d ':' -f 2 | sed '/^ /s/^ *//'`
ARTIST=`id3v2 -l "$1" | grep TPE2 | cut -d ':' -f 2 | sed '/^ /s/^ *//'`
ALBUMv1=`id3v2 -l "$1" | grep Album | cut -d ':' -f 2 | sed '/^ /s/^ *//;s/ *Year//' | awk 'FNR == 1 {print}'`
GENREv1=`id3v2 -l "$1" | grep Genre | cut -d ':' -f 2 | sed '/^ /s/^ *//'`
ARTISTv1=`id3v2 -l "$1" | grep Artist | cut -d ':' -f 2 | sed '/^ /s/^ *//'`
TRCKv1=`id3v2 -l "$1" | grep Track | cut -d ':' -f 2 | sed '/^ /s/^ *//'`
#########################################

case $EXT in
    ogg|wav|txt|jpg|jpeg|gif|png)
        ;;
    *)
        if [ $IDVERS = 0 ]; then
            id3v2 --TCON "$GENREv1" --TALB "$ALBUMv1" "$1"
            id3v2 -C "$1"
            id3v2 -s "$1"
        else
            id3v2 -s "$1"
        fi
        ;;
esac
