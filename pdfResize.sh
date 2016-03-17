#!/bin/bash
# vim:fdm=marker

# Configuration                   {{{1
# Define inputfile                {{{2
TMPDIR=`mktemp -d /tmp/frames.XXXXXXXX` || exit 1
size_old=$(ls -s "$1" | cut -d ' ' -f 1)
inputfile="$1"
if [ "$1" = "" ]; then
    echo "usage: $0 name_of_file.pdf"
    exit 0
fi

# Backup File                     {{{2
echo ""
echo "copy $1 to /tmp/$$.pdf"
cp -v "$1" /tmp/$$.pdf
sleep 1

# Dialogs                         {{{2

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

# Work on PDF                     {{{1
# Fit to pagescale                {{{2
if [[ $fitformat == "yes" ]]; then
    # Ausgabe
    echo ""
    echo -n "pdf gets scaled into size $pagescale..."

    # Starte Ghostscript
    output1_format_a4="$TMPDIR/pdfres_out_pagescale".pdf
    gs\
        -sDEVICE=pdfwrite\
        -dFIXEDMEDIA\
        -dPDFFitPage\
        -dCompatibilityLevel=1.4\
        -sPAPERSIZE=$pagescale\
        -o $output1_format_a4 $inputfile
    input1=$output1_format_a4
    input0_resize=$input1
fi

# Convert PDF to Grayscale        {{{2

# http://handyfloss.net/2008.09/making-a-pdf-grayscale-with-ghostscript/
if [[ $togray == "yes" ]]; then
    if [[ ! -f $input1 ]]; then
        input1=$inputfile
    fi

    output2_grayscale="$TMPDIR/pdfres_out_grayscale".pdf
    gs \
        -sDEVICE=pdfwrite \
        -sColorConversionStrategy=Gray \
        -dProcessColorModel=/DeviceGray \
        -dCompatibilityLevel=1.4 \
        -dNOPAUSE \
        -dBATCH \
        -sOutputFile=$output2_grayscale $input1
    input0_resize=$output2_grayscale
fi

# Resizing PDF #1                 {{{2
echo ""
echo "$inputfile resize with ghostscript"
if [[ ! -f $input0_resize ]]; then
    input0_resize=$inputfile
fi
output3_resize="$TMPDIR/pdfres_out_resized_gs".pdf
gs\
    -sDEVICE=pdfwrite\
    -dCompatibilityLevel=1.4\
    -dPDFSETTINGS="$qual"\
    -dNOPAUSE\
    -dQUIET\
    -dColorConversionStrategy="$col"\
    -dBATCH\
    -sOutputFile=$output3_resize $input0_resize

input0_resize=$output3_resize
size_new="$(ls -s $output3_resize | cut -d ' ' -f 1)"
size_new_hs="$(ls -hs $output3_resize | cut -d ' ' -f 1)"

# Resizing PDF #2                 {{{2
if [ $size_old -le $size_new ]; then
    echo "start second intent ... "
    output4_resize="$TMPDIR/postscript_out".ps
    output5_resize="$TMPDIR/pdfres_out_resized_ps2pdf".pdf

    pdftops $inputfile $output4_resize
    ps2pdf $output4_resize $output5_resize
    size_new=$(ls -s $output5_resize | cut -d ' ' -f 1)
    size_new_hs=$(ls -hs $output5_resize | cut -d ' ' -f 1)
fi

# Resizing PDF #3                 {{{2
if [ $size_old -le $size_new ]; then
    ppmout="$TMPDIR/${inputfile%%.*}"
    output6_resize="$TMPDIR/pdfres_out_resized_ppm_images".pdf
    pdfimages $inputfile $ppmout
    for i in "$TMPDIR/$ppmout*".ppm
    do
        mogrify -resize 45% $i
        sam2p -pdf:2 $i "$TMPDIR/$(basename $i .ppm)".pdf
        pdftk $TMPDIR/$ppmout*.pdf cat output $output6_resize # $TMPDIR/$ppmout%03d.png
    done
fi

# Final Output                    {{{1
# Define Final Output File        {{{2
if [ -f $output6_resize ];then output_final=$output6_resize
elif [ -f $output5_resize ];then output_final=$output5_resize
elif [ -f $output3_resize ];then output_final=$output3_resize
elif [ -f $output2_grayscale ];then output_final=$output2_grayscale
elif [ -f $output1_format_a4 ];then output_final=$output1_format_a4
fi

# Filesize To Human Readability   {{{2

if [ $size_old -le $size_new ]; then
    echo "sorry, couldn't resize $inputfile"
    rm -rfv $TMPDIR
    exit 1;
else
    echo "new size $size_new_hs old size $size_old_hr"
    mv -v $output_final ./"${inputfile%%.*}_resized".pdf
    echo ""
    echo "`basename $1`... resized from $size_old to $size_new bites (~ $size_new_hs mb)!"
fi

# Annotations                     {{{2

#-dPDFSETTINGS=configuration to presets the "distiller parameters" to one of four
#predefined settings:

#/screen selects low-resolution output similar to the Acrobat Distiller "Screen Optimized" setting.
#/ebook selects medium-resolution output similar to the Acrobat Distiller "eBook" setting.
#/printer selects output similar to the Acrobat Distiller "Print Optimized" setting.
#/prepress selects output similar to Acrobat Distiller "Prepress Optimized" setting.
#/default selects output intended to be useful across a wide variety of uses, possibly at the expense of a larger output file.
