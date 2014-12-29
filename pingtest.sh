#!/bin/bash
# HOSTS="IP1 IP2 IP3 IP4 IP5"
HOSTS="$1"
COUNT=4

pingtest(){
    for myHost in "$@"
    do
        ping -c "$COUNT" "$myHost" && return 1
    done
    return 0
}

if pingtest $HOSTS
then
    # 100% failed
    # echo "Server failed at $(date)" | mail -s "Server Down" myadress@gmail.com
    echo "All hosts ($HOSTS) are down (ping failed) at $(date)"
else
    notify-send "Connection to ($HOSTS) is now available at $(date)"
fi
