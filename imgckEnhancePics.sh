#! /bin/bash

if [[ ! -d ../originalpics ]]; then mkdir ../originalpics; fi

echo "Enter the file-suffix you do want select: "
select SUFFIX in $(ls * | sed 's/.*\.\(\w\+\)$/\1/g' | sort | uniq);
do
    suffix=$SUFFIX
    echo $suffix
    break
done

echo "verschiebe Dateien mit Endung $suffix"
mv -v ./*[[:digit:]].$suffix ../originalpics/

# Begin Loop
for i in ../originalpics/*.$suffix; do
    pic=$(basename $i .$suffix)_orig.png
    # Convert to PNG            {{{
    convert -resize 44% ../originalpics/$i ./"$pic"; # Converting $suffixs to png

    # Adjust Contrast-Stretch   {{{
    # http://www.linupedia.org/opensuse/ImageMagick_n%C3%BCtzliche_Beispiele#Farb_und_Kontrastverbesserung_bei_Unterwasserbildern
    echo ""
    echo "Adjusting Contrast-Stretch ..."
    convert "$pic" -channel 'RGBA' -contrast-stretch 1% $(basename $i .$suffix)_contr-str.png;

    # Adjust Colorlevel         {{{
    /bin/bash $HOME/bin/imgckAutolevel "$pic" $(basename $i .$suffix)_level.png;

    # Enhance Color-Level       {{{
    #/bin/bash $HOME/bin/imgckAutoGamma -c luminance "$pic" $(basename $i .$suffix)_lumin.png;
    #/bin/bash $HOME/bin/imgckAutoGamma -c rgb "$pic" $(basename $i .$suffix)_rgb.png;

    # Enhance Whitening-Level   {{{
    /bin/bash $HOME/bin/imgckAutowhite -m 1 -p 1 "$pic" $(basename $i .$suffix)_white_1.png;
    # /bin/bash $HOME/bin/imgckAutowhite -m 2 -p 1 "$pic" $(basename $i .$suffix)_white_2.png;
    # /bin/bash $HOME/bin/imgckAutowhite -m 1 -p 2 "$pic" $(basename $i .$suffix)_white_3.png;
    # /bin/bash $HOME/bin/imgckAutowhite -m 2 -p 2 "$pic" $(basename $i .$suffix)_white_4.png;

done
rm -rvf ../originalpics
