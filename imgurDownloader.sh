#!/bin/bash
wget $1
LIST=files.list
mv $(ls -1 .) $LIST 
# Strip the file down to the actual image links.
cat $LIST | grep href | grep jpg | grep -v rel > $LIST
# Could be a one-liner, but I like neatness.
cat $LIST | sed 's/<a href\\="//g' | sed 's/">//g' > $LIST
# Download the files.
wget -i $LISTm $ALIST
