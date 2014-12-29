#!/bin/sh
# http://ubuntuforums.org/showthread.php?t=1265894

mplayer -cache 2048 \
    'mms://80.246.121.90/ctv' \
    -dumpstream -dumpfile $HOME/tmp/centertv_wetterhelden.asf  &
sleep 20m
kill $!
