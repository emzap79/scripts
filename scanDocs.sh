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

set -o nounset                              # Treat unset variables as an error

# ### Variablen setzen   {{{1
read -ep "Wie soll die PDF-File nach dem Einscannen heißen? " NAME
NAME="${NAME%%.*}".pdf

read -ep "Gib das Zielverzeichnis für die Mitschrift an: /tmp/" OUTDIR
read -ep "Soll das PDF anschließend in Grayscale umgewandelt werden (Y/n)? " answer
mkdir -p /tmp/$OUTDIR

# ### Funktionen         {{{1
scan_image ()
{
    mkdir -p $IMAGES
    scanimage -l 0 -t 0 -x 210 -y 296 --resolution=200 --contrast=10 --brightness=10 \
        --batch=$IMAGES/scanned_image-%03d.pnm
}

conv_to_graysc ()
{
    for i in $IMAGES/scanned_image*; do
        echo "$i wird in Graustufen umgewandelt"
        mogrify -colorspace gray "$i"
    done
}

conv_to_pdf ()
{
    for i in $IMAGES/scanned_image*.pnm; do sam2p -pdf:2 "$i" $IMAGES/$(basename $i .pnm).pdf; done
    pdftk $IMAGES/*.pdf cat output "$OUTDIR/$NAME"

    # echo ""
    # echo "resize with ghostscript"
    # gs\
    #     -sDEVICE=pdfwrite\
    #     -dCompatibilityLevel=1.4\
    #     -dPDFSETTINGS="/ebook"\
    #     -dNOPAUSE\
    #     -dQUIET\
    #     -dColorConversionStrategy="/sRGB"\
    #     -dBATCH\
    #     -sOutputFile="$OUTDIR/$NAME" "$OUTDIR/$NAME"

    evince  "$OUTDIR/$NAME" &
}
# ### Erstellen der PDF  {{{1

read -ep "Scanprozess mit <CTRL+C> beenden sobald Mitschriften eingescannt [ENTER] "
case $answer in
    Yes|yes|Y|y|"")
        IMAGES="/tmp/scan/gray"
        if test -d $IMAGES; then rm -r $IMAGES; fi
        scan_image
        conv_to_graysc
        ;;
    No|no|N|n)
        IMAGES="/tmp/scan/color"
        if test -d $IMAGES; then rm -rf $IMAGES; fi
        scan_image
        ;;
esac
conv_to_pdf
# #############
# ### EOF
# #############
