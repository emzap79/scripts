#!/bin/bash
#required packages: pdftk and pdfjam (as well as tex-live, pdflatex required by pdfjam)
#source: https://gist.github.com/847095
 
if [ $1 == 0 ]; then
    echo "usage: $0 {PDF-File}"
    exit 1
fi

FILE=$(echo $1 | sed 's/.pdf//')
echo "$ pdfcrop $FILE.pdf --margins 12"
pdfcrop $FILE.pdf --margins 12
 
echo "$ pdftops $FILE-crop.pdf"
pdftops $FILE-crop.pdf
 
echo "$ psbook $FILE-crop.ps book-$FILE.ps"
psbook $FILE-crop.ps book-$FILE.ps
 
echo "ps2pdf book-$FILE.ps book-$FILE.pdf"
ps2pdf book-$FILE.ps book-$FILE.pdf
 
echo "$ pdfnup book-$FILE.pdf --nup 2x1 --suffix '2x1'"
pdfnup book-$FILE.pdf --nup 2x1 --suffix '2x1'
 
echo "pdftk book-$FILE-2x1.pdf cat 1-endE output $FILE-Booklet.pdf"
pdftk book-$FILE-2x1.pdf cat 1-endE output $FILE-Booklet.pdf
 
echo "$FILE-crop.pdf $FILE-crop.ps book-$FILE.ps book-$FILE.pdf book-$FILE-2x1.pdf"
rm $FILE-crop.pdf $FILE-crop.ps book-$FILE.ps book-$FILE.pdf book-$FILE-2x1.pdf

echo -e "Die PDF $FILE.pdf wurde ins Booklet-Format umgewandelt."
read -p "Willst du $FILE jetzt im Booklet Format öffnen (Y|n)? " answer
case "$answer" in
    Yes|yes|Y|y|"") 
        evince $FILE-Booklet.pdf
        exit 0
        ;;
    No|no|N|n) 
        echo "Du Findest die Datei unter dem Namen: $FILE-Booklet.pdf"
        exit 0
        ;;
    *) 
        echo -e "Unbekannter Parameter... Operation abgebrochen!" 
        exit 1
        ;;
esac
exit 0
