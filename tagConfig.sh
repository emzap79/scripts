#!/bin/bash
############################################################
################ Konfigurationszeilen ######################
############################################################
FBN=`basename "$1" .mp3`
NAME=${1%%.*}
EXT=${1##*.}
YEAR=`id3v2 -l "$1" | grep TYER | cut -d ':' -f 2 | sed '/^ /s/^ *//'`
ARTIST=`id3v2 -l "$1" | grep TPE1 | cut -d ':' -f 2 | sed '/^ /s/^ *//'`
TRACK=`id3v2 -l "$1" | grep TRCK | cut -d ':' -f 2 | sed '/^ /s/^ *//'`
TITLE=`id3v2 -l "$1" | grep TIT2 | cut -d ':' -f 2 | sed '/^ /s/^ *//'`
ALBUM=`id3v2 -l "$1" | grep TALB | cut -d ':' -f 2 | sed '/^ /s/^ *//'`
GENRE=`id3v2 -l "$1" | grep TCON | cut -d ':' -f 2 | sed '/^ /s/^ *//'`
IDVERS=`id3v2 -l "$1" | grep TRCK | wc -l` #1 falls IDv3 Tag vorhanden, 0 falls nicht!

TRCKv1=`id3v2 -l "$1" | grep Track | cut -d ':' -f 2 | sed '/^ /s/^ *//'`
ALBUMv1=`id3v2 -l "$1" | grep Album | cut -d ':' -f 2 | sed '/^ /s/^ *//;s/ *Year//' | awk 'FNR == 2 {print}'`
TITLEv1=`id3v2 -l "$1" | grep Title | cut -d ':' -f 2 | sed '/^ /s/^ *//' | awk 'FNR == 1 {print}'`
ARTISTv1=`id3v2 -l "$1" | grep Artist | cut -d ':' -f 3 | sed '/^ /s/^ *//;s/ *$//g;s/ /\./g'`
GENREv1=`id3v2 -l "$1" | grep Genre | cut -d ':' -f 4 | sed '/^ /s/^ *//;s/ *$//g;s/ /\./g'`

ARTISTogg=`lltag -S "$1" | grep artist | cut -d '=' -f 2 | sed '/^ /s/^ *//;s/ /\./g' | awk 'FNR == 3 {print}'`
ALBUMogg=`lltag -S "$1" | grep album | cut -d '=' -f 2 | sed '/^ /s/^ *//;s/ /\./g' | awk 'FNR == 3 {print}'`
TRACKogg=`lltag -S "$1" | grep track | cut -d '=' -f 2 | sed '/^ /s/^ *//;s/ /\./g' | awk 'FNR == 1 {print}'`
ALBARTISTogg=`lltag -S "$1" | grep albumartist | cut -d '=' -f 2 | sed '/^ /s/^ *//;s/ /\./g'`
TRACKogg=`lltag -S "$1" | grep tracknumber | cut -d '=' -f 2 | sed '/^ /s/^ *//;s/ /\./g'`
