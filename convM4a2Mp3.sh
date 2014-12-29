#!/bin/bash
# http://linuxcoded.blogspot.de/2012/07/m4a-to-mp3.html
#
# Convert m4a to mp3

if [ -n "$1" ]; then
  for i in $1/*.m4a
  do
    faad -o "$i.wav" "$i"
    dest=`echo "$i.wav"|sed -e 's/m4a.wav$/mp3/'`
    lame -h -b 128 "$i.wav" "$dest"
    rm "$i.wav"
    rm "$i#"
  done
else
  echo "Usage: m4a2mp3 [directory_containing_m4a_files]"
fi
