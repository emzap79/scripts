#!/bin/sh
# http://stackoverflow.com/a/23735008/3569509

# FILENAME
FILENAME="${basename $1}"

# Ask number of pages of every pdf
echo -n "Number of Pages to make PARTS from: "
read NUM

# Save pages number of the original pdf
PAG=$(pdftk $FILENAME.pdf dump_data|grep NumberOfPages| awk '{print $2}')

# create parts 'from'-'to' given by NUM
PAG_FROM=1; PAG_TO=$NUM
while [ "$PAG_TO" -le "$PAG" ]; do
    FILE_OUT="PART-$(printf %03d $PAG_FROM)-$(printf %03d $PAG_TO)"
    pdftk $FILENAME.pdf cat $PAG_FROM-$PAG_TO output $FILE_OUT.pdf
    pdftops $FILE_OUT.pdf $FILE_OUT.ps
    PAG_FROM=$((PAG_FROM+$NUM))
    PAG_TO=$((PAG_TO+$NUM))
done

# execute pdftk on trailing pages
if [ $PAG_FROM -le $PAG ]; then
    # PAG_FROM=$((PAG_FROM+1))
    FILE_OUT="PART-$(printf %03d $PAG_FROM)-$(printf %03d $PAG)"
    pdftk $FILENAME.pdf cat $PAG_FROM-$PAG output $FILE_OUT.pdf
    pdftops $FILE_OUT.pdf $FILE_OUT.ps
fi
