#!/bin/bash
# vim:fdm=marker

# Configuration # {{{

size_old=$(ls -s "$1" | cut -d ' ' -f 1)
inputfile="$1"
if [ "$1" = "" ]; then
    echo "usage: $0 name_of_file.pdf"
    exit 0
fi

# Configuration # }}}
# Dialoge # {{{

read -p "do you need your PDF to be scaled to a specific page size? (y|N) " answer
case $answer in
    Yes|yes|Y|y)
        PS3="Enter desired pagesize: "
        selOptions=("A3" "A4" "legal")
        select opt in "${selOptions[@]}" "No pagesize: <None>"; do
            case "$REPLY" in
                1 ) echo "You chose $REPLY: $opt"
                    fitformat=yes
                    pagescale="a3"
                    ;;
                2 ) echo "You chose $REPLY: $opt"
                    fitformat=yes
                    pagescale="a4"
                    ;;
                3 ) echo "You chose $REPLY: $opt"
                    fitformat=yes
                    pagescale="legal"
                    ;;
                $(( ${#selOptions[@]}+1 )) )
                    echo "Ok buddy, only resize then!"
                    echo ""
                    fitformat=no
                    ;;
                *) echo "#N/A... no valid option";continue
                    ;;
            esac; break
        done
        ;;
    No|no|N|n|"")
        fitformat=no
        ;;
esac

read -p "would you like your output file to be B/W? (y|N) " answer
case $answer in
    Yes|yes|Y|y)
        togray=yes
        ;;
    No|no|N|n|"")
        togray=no
        ;;
esac

echo ""
echo "define the pdfs output resolution "
echo "- [l]ow"
echo "- [m]edium"
echo "- [h]igh"
echo "- [b]est"
echo ""
read -p "your choice (recommended: medium)? " answer
case $answer in
    l|low)
        qual='/screen'
        col='/sRGB'
        ;;
    m|medium|"")
        qual='/ebook'
        col='/sRGB'
        ;;
    h|high)
        qual='/printer'
        col='/sRGB'
        #col='/UseDeviceIndependentColor'
        ;;
    b|best)
        qual='/prepress'
        col='/LeaveColorUnchanged'
esac

### Dialoge # }}}
# Backup File # {{{

echo ""
echo "copy $1 to /tmp/$$.pdf"
cp -v "$1" /tmp/$$.pdf
sleep 1

### Backup File # }}}
# Fit to pagescale # {{{

if [[ $fitformat == "yes" ]]; then
    # Ausgabe
    echo ""
    echo -n "pdf gets scaled into size $pagescale..."
    # Starte Ghostscript
    gs\
        -sDEVICE=pdfwrite\
        -dFIXEDMEDIA\
        -dPDFFitPage\
        -dCompatibilityLevel=1.4\
        -sPAPERSIZE=$pagescale\
        -o "pdfres_out_pagescale" $inputfile
    inputfile="pdfres_out_pagescale"
fi

### Fit to A4-Format # }}}
# Convert PDF to Grayscale # {{{

# http://handyfloss.net/2008.09/making-a-pdf-grayscale-with-ghostscript/
if [[ $togray == "yes" ]]; then
    gs \
        -sDEVICE=pdfwrite \
        -sColorConversionStrategy=Gray \
        -dProcessColorModel=/DeviceGray \
        -dCompatibilityLevel=1.4 \
        -dNOPAUSE \
        -dBATCH \
        -sOutputFile="pdfres_out_grayscale" $inputfile
    inputfile="pdfres_out_grayscale"
fi


### Convert PDF to Grayscale # }}}
# Resizing PDF #1 # {{{

echo ""
echo "$1 resize with ghostscript"
gs\
    -sDEVICE=pdfwrite\
    -dCompatibilityLevel=1.4\
    -dPDFSETTINGS="$qual"\
    -dNOPAUSE\
    -dQUIET\
    -dColorConversionStrategy="$col"\
    -dBATCH\
    -sOutputFile="pdfres_out_resized_1.pdf" $inputfile
inputfile="pdfres_out_resized_1.pdf"
size_new="$(ls -s $inputfile | cut -d ' ' -f 1)"
size_new_hs=$(ls -hs $inputfile | cut -d ' ' -f 1)

### Resizing PDF #1 # }}}
# Resizing PDF #2 # {{{

if [ "$size_old" -le "$size_new" ]; then
    echo "start second intent ... "
    # pdftops "$inputfile" "bar.ps"
    # pstopdf "bar.ps" "pdfres_out_resized_2.pdf"
    pdf2ps "$inputfile" "bar.ps"
    ps2pdf "bar.ps" "pdfres_out_resized_2.pdf"
    rm bar.ps
    inputfile="pdfres_out_resized_2.pdf"
    size_new=$(ls -s $inputfile | cut -d ' ' -f 1)
    size_new_hs=$(ls -hs $inputfile | cut -d ' ' -f 1)
    echo "new size $size_new old size $size_old"
    if [ "$size_old" -le "$size_new" ]; then
        echo "sorry, couldn't resize $1"
        rm $inputfile
        exit 1;
    fi
fi

### Resizing PDF #2 # }}}
# Final Output # {{{

mv "$inputfile" "$1"
echo ""
echo "`basename $1`... resized from $size_old to $size_new bites (~ $size_new_hs mb)!"

### Final Output # }}}
# Annotations#{{{

#-dPDFSETTINGS=configuration to presets the "distiller parameters" to one of four
#predefined settings:

#/screen selects low-resolution output similar to the Acrobat Distiller "Screen Optimized" setting.
#/ebook selects medium-resolution output similar to the Acrobat Distiller "eBook" setting.
#/printer selects output similar to the Acrobat Distiller "Print Optimized" setting.
#/prepress selects output similar to Acrobat Distiller "Prepress Optimized" setting.
#/default selects output intended to be useful across a wide variety of uses, possibly at the expense of a larger output file.

# EOF#}}}
