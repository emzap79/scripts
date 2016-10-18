#! /bin/bash

origdir="/tmp/originalpics"
currdir=$(pwd)

if [[ ! -d $origdir ]]; then mkdir $origdir; fi

echo "Enter the file-suffix you do want select: "
select SUFFIX in $(ls * | sed 's/.*\.\(\w\+\)$/\1/g' | sort | uniq);
do
    suffix=$SUFFIX
    echo $suffix
    break
done

echo "verschiebe Dateien mit Endung $suffix"
mv -v ./*[[:digit:]].$suffix $origdir/

# Begin Loop
for i in $origdir/*.$suffix; do
    pic="$(basename $i).png"

    # Convert to PNG           {{{1
    # convert $i $currdir/$pic # Converting $suffixs to png

    # Adjust Contrast-Stretch  {{{1
    # http://www.linupedia.org/opensuse/ImageMagick_n%C3%BCtzliche_Beispiele#Farb_und_Kontrastverbesserung_bei_Unterwasserbildern
    echo ""
    echo "Adjusting Contrast-Stretch ..."
    convert "$i" -channel 'RGBA' -contrast-stretch 1% $(basename $i)_contr_str.png;

    # # Adjust Colorlevel
    # /bin/bash $HOME/bin/imgckAutolevel "$i" $(basename $i)_level.png;

    # # Enhance Color-Level
    # /bin/bash $HOME/bin/imgckAutoGamma -c luminance "$i" $(basename $i)_lumin.png;
    # /bin/bash $HOME/bin/imgckAutoGamma -c rgb "$i" $(basename $i)_rgb.png;

    # Enhance Whitening-Level
    # /bin/bash $HOME/bin/imgckAutowhite -m 1 -p 1 "$i" $(basename $i)_white_1.png;
    # /bin/bash $HOME/bin/imgckAutowhite -m 2 -p 1 "$pic" $(basename $i)_white_2.png;
    # /bin/bash $HOME/bin/imgckAutowhite -m 1 -p 2 "$pic" $(basename $i)_white_3.png;
    # /bin/bash $HOME/bin/imgckAutowhite -m 2 -p 2 "$pic" $(basename $i)_white_4.png;

done

# # rm -rvf $origdir
