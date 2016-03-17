#!/bin/sh
size_new_hr

echo $size_new | awk 'function human(x) {
x=x*1000
s=" B   KiB MiB GiB TiB EiB PiB YiB ZiB"
while (x>=1024 && length(s)>1)
    {x/=1024; s=substr(s,5)}
    s=substr(s,1,4)
    xf=(s==" B  ")?"%5d   ":"%8.2f"
    return sprintf( xf"%s\n", x, s)
}
{gsub(/^[0-9]+/, human($1)); print}' 

    echo $size_new_hr
