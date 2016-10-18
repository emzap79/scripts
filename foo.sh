#!/bin/sh
# http://ryanbrooks.co.uk/posts/2015-09-05-imagemagick-circular-avatars/

EXT=${2##*.}                              # Gibt nur das Suffix der File aus (e.g. mp3, ogg ...)
BNM="$(basename $2 .$EXT)"

case $1 in
    avatar)
        convert $2 \
            -resize x800 -resize '800x<'   -resize 50% \
            -gravity center -crop 400x400+0+0 +repage \
            \( +clone -threshold -1 -negate -fill white -draw "circle 200,200 200,0" \) \
            -alpha off -compose copy_opacity -composite \
            \-auto-orient \
            cropped_"$BNM".png
        ;;
    shadow)
        convert -page +4+4 $2 -alpha set \
            \( +clone -background navy -shadow 60x4+4+4 \) +swap \
            -background none -mosaic \
            shadow_"$BNM".png
        ;;
    *)
        echo "usage: $0 [avatar|shadow] image.suffix"
        ;;
esac
