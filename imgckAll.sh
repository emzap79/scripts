#!/bin/sh

# config                   {{{1
infile="$1"
outfile="$(basename $1 .png)_edited.png"
tmpfile="/tmp/$(basename $1 .png)".png
ww=`convert $infile -format "%w" info:`
hh=`convert $infile -format "%h" info:`

# photoediting             {{{1
# copy to /tmp/
cp $infile $tmpfile

# remove white background  {{{2
# http://www.imagemagick.org/discourse-server/viewtopic.php?t=12619
fun_transp(){
    convert $infile -fuzz $1% -transparent white $tmpfile
    # convert $infile -transparent white $tmpfile
}

# nice reflection          {{{2
# http://stackoverflow.com/questions/198928/imagemagick-reflection
# http://www.alleluia.ch/systeme-dexploitation/commande/107-reflexion-sous-une-image
fun_reflect(){
    outfile="$(basename $tmpfile .png)"_reflect.png
    convert $tmpfile \
        \( -size "${ww}x${hhr}" xc:none \
        \( \( -flip $tmpfile -crop ${ww}x${hhr}+0+0 \) \
        -size "${ww}x${hhr}" gradient: -gamma $1 \
        -compose Copy_Opacity -composite \) \
        -compose blend -composite \) \
        -append \
        $outfile
    tmpfile=$outfile
}

# add reflections altern   {{{2
# http://www.imagemagick.org/Usage/advanced/#reflections
fun_reflect_altern(){
    outfile="$(basename $tmpfile .png)"_reflect.png
    hhr=`convert xc: -format "%[fx:$hh*$1/100]" info:`
    convert $tmpfile -alpha on \
        \( +clone -flip \
        -size ${ww}x${hhr} gradient: +level 0x${2}% \
        -alpha off -compose CopyOpacity -composite \
        \) -append \
        -gravity North -crop ${ww}x${hhr}\! \
        -background white -compose Over -flatten -trim   \
        $outfile
    tmpfile=$outfile
}

# add shadow               {{{2
# https://www.imagemagick.org/discourse-server/viewtopic.php?t=16882
fun_add_shadow(){
    outfile="$(basename $tmpfile .png)"_shadow.png
    convert "$tmpfile" \
        \( -clone 0 -background gray -shadow 80x3+10+10 \) \
        \( -clone 0 -background gray -shadow 80x3-5-5 \) \
        -reverse -background none -layers merge +repage \
        $outfile
    tmpfile=$outfile
}

fun_display(){
    # mv $tmpfile $outfile
    display "$outfile"
}

fun_transp 3 # white-tolerance in %
# fun_reflect
fun_reflect_altern 50 100 # ramp, fade
fun_add_shadow
fun_display $tmpfile    # $outfile
file $outfile
