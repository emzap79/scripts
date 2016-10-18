#!/bin/bash -
#===============================================================================
#
#          FILE:  scanUni.sh
#
#         USAGE:  ./scanUni.sh
#
#   DESCRIPTION:
#
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR: Jonas Petong (),
#       COMPANY:
#       CREATED: 01.11.2013 17:59:43 CET
#      REVISION:  ---
#===============================================================================

#  Variablen setzen   {{{1
set -o nounset                              # Treat unset variables as an error
CURDIR=$(pwd)

#  Funktionen         {{{1
scan_image()
{
    mkdir -p $IMAGES
    scanimage -l 0 -t 0 -x 210 -y 296 --resolution=200 --contrast=10 --brightness=10 \
        --batch=$IMAGES/scanned_image-%03d.pnm
}

conv_to_graysc()
{
    for i in $IMAGES/scanned_image*; do
        echo "$i wird in Graustufen umgewandelt"
        mogrify -colorspace gray "$i"
    done
}

conv_to_pdf()
{
    for i in $IMAGES/scanned_image*.pnm; do sam2p -pdf:2 "$i" $IMAGES/$(basename "$i" .pnm).pdf; done
    pdftk $IMAGES/*.pdf cat output "$OUTDIR/$NAME".pdf

    echo ""
    echo "resize with ghostscript"
    gs\
        -sDEVICE=pdfwrite\
        -dCompatibilityLevel=1.4\
        -dPDFSETTINGS="/ebook"\
        -dNOPAUSE\
        -dQUIET\
        -dColorConversionStrategy="/sRGB"\
        -dBATCH\
        -sOutputFile="$OUTDIR/$NAME"_resized.pdf "$OUTDIR/$NAME".pdf

    evince  "$OUTDIR/$NAME".pdf &
}
#  Erstellen der PDF  {{{1
selTitle="Dokumententyp"
selPrompt="Um welche Art von Unterlagen Handelt es sich hierbei? [1-3]"
selOptions=("Unimaterialien" "Dokumente" "Sonstige")

PS3="$selPrompt "
select opt in "${selOptions[@]}" "Quit"; do
    case "$REPLY" in
        1 ) DIR=$HOME/Unimaterialien
            ;;
        2 ) DIR=$HOME/Dokumente
            ;;
        3 ) DIR=$HOME
            ;;
        $(( ${#selOptions[@]}+1 )) ) echo "Goodbye!"; break
            ;;
        *) echo "Ungültige Option. Wähle etwas anderes.";continue
            ;;
    esac;
        if [[ -d $DIR ]]; then
        break #Ohne die Option Break wird die Abfrage wiederholt!
    else
        echo "Ordner \"$DIR\" existiert nicht oder wurde nicht eingehängt."
        echo ""
    fi
done
cd $DIR

read -ep "Wie soll die PDF-File nach dem Einscannen heißen? " NAME
read -ep "Gib das Zielverzeichnis für die Mitschrift an: $DIR/" OUTDIR
read -ep "Soll das PDF anschließend in Grayscale umgewandelt werden (Y/n)? " ANSWER
read -ep "Scanprozess mit <CTRL+C> beenden sobald Mitschriften eingescannt [ENTER] "
NAME="${NAME%%.*}"
OUTDIR="$DIR/$OUTDIR"
mkdir -p $OUTDIR; cd $CURDIR

case $ANSWER in
    Yes|yes|Y|y|"")
        IMAGES="/tmp/scan/gray"
        if test -d $IMAGES; then rm -r $IMAGES; fi
        scan_image
        echo "bar"
        conv_to_graysc
        ;;
    No|no|N|n)
        IMAGES="/tmp/scan/color"
        if test -d $IMAGES; then rm -rf $IMAGES; fi
        scan_image
        ;;
esac
conv_to_pdf
rm -I $IMAGES/*
