#!/bin/bash - 
#===============================================================================
#
#          FILE:  cronBeetLoop.sh
# 
#         USAGE:  ./cronBeetLoop.sh 
# 
#   DESCRIPTION:  Looping CronBeet Script
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR: Jonas Petong (), 
#       COMPANY: 
#       CREATED: 30.07.2013 09:35:47 CEST
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error
chkBeet=`top -n 1 | grep beet | wc -l`

#while true; do
    ##checkt ob beets gerade ausgeführt wird
    #if [ "$chkBeet" != 0 ]; then
        #echo "Beets läuft bereits"
        #sleep 10
        #exit 1
    #else
        #sh ~/bin/cronBeet
    #fi
#done

while true; do
#checkt ob Skript gerade ausgeführt wird
lf=/tmp/pidLockFile
touch $lf
read lastPID < $lf
[ ! -z "$lastPID" -a -d /proc/$lastPID ] && exit
echo not running
sh ~/bin/cronBeet
#echo $$ > $lf
done

