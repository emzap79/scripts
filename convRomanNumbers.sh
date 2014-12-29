#!/bin/sh

echo $(( $(echo "$1" | \
    sed -e 's/iv/\+4/gI' -e 's/ix/\+9/gI' \
    -e 's/xl/\+40/gI' -e 's/xc/\+90/gI' \
    -e 's/cd/\+400/gI' -e 's/cm/\+900/gI' \
    -e 's/i/\+1/gI' \
    -e 's/v/\+5/gI' \
    -e 's/x/\+10/gI' \
    -e 's/l/\+50/gI' \
    -e 's/c/\+100/gI' \
    -e 's/d/\+500/gI' \
    -e 's/m/\+1000/gI')))
