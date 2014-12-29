#!/bin/bash
#DISPLAY=":0.0"
#DISPLAY=":0"
#export DISPLAY
#export DISPLAY=:0  #Damit Notify-Send auch in Cron-gesteuerten Skripten arbeitet
#export DISPLAY=0:0  #Damit Notify-Send auch in Cron-gesteuerten Skripten arbeitet
#xhost +local:zapata
#xhost +

env DISPLAY=:0.0 /usr/bin/notify-send  "Cronjob is working1"
"/usr/bin/notify-send" "Cronjob is working2"
/usr/bin/notify-send --hint=int:transient:2 "Cronjob is working3"
#/usr/bin/notify-send "Cronjob is working4" --display=:0.0
#/usr/bin/notify-send "Cronjob is working5" --display=:0.0 >> /dev/null 2>1
/usr/bin/X11/notify-send "Cronjob is working6"
notify-send "Cronjob is working7"
#zenity --info --text "Cronjob is working9"
