#!/bin/sh

chktitle=$(pdfinfo "$1" | grep ^Title | awk '{print $2}')

# check to make sure that calibre is installed
if ! command -v calibre; then
    echo "ERROR: calibre must be installed"
    sudo apt-get install calibre
fi

# change name of file
if [ -n "$chktitle" ]; then
    title="$(pdfinfo "$1" | grep ^Title | awk '{print substr($0,index($0,$2))}' | sed 's/ /_/g')".pdf
    mv -v "$1" "$title"
else
    title="$1"
    echo "no title available"
fi; output="$(basename $title .pdf).epub"

# ebook-convert "$title" $(basename "$title" .pdf).epub --enable-heuristics
/usr/bin/ebook-convert "$title" "$output"

# check result
/usr/bin/fbreader "$output"

read -p "Are you ok with your new file (Y|n)? " answer
case "$answer" in
Yes|yes|Y|y|"")
    echo "super, have fun while reading!"
    ;;
No|no|N|n)
    echo "sorry man, you'll have to read in pdf-format then :-("
    echo "I'll better remove the new created .epub file. cheers!"
    rm -v "$output"
    ;;
esac
