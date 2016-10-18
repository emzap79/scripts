#!/bin/bash

echo "#!/bin/sh
#
# 

VERSION=1.1
DEV_LIST=/tmp/usb-dev-list
DRIVERS_DIR=/sys/bus/pci/drivers
DRIVERS="ehci xhci" # ehci_hcd, xhci_hcd
HEX="[[:xdigit:]]"
MAX_BIND_ATTEMPTS=2
BIND_WAIT=0.1

unbindDev() {
    echo -n > $DEV_LIST 2>/dev/null
    for driver in $DRIVERS; do
        DDIR=$DRIVERS_DIR/${driver}_hcd
        for dev in `ls $DDIR 2>/dev/null | egrep "^$HEX+:$HEX+:$HEX"`; do
            echo -n "$dev" > $DDIR/unbind
            echo "$driver $dev" >> $DEV_LIST
        done
    done
}

bindDev() {
    if [ -s $DEV_LIST ]; then
        while read driver dev; do
            DDIR=$DRIVERS_DIR/${driver}_hcd
            while [ $((MAX_BIND_ATTEMPTS)) -gt 0 ]; do
                echo -n "$dev" > $DDIR/bind
                if [ ! -L "$DDIR/$dev" ]; then
                    sleep $BIND_WAIT
                else
                    break
                fi
                MAX_BIND_ATTEMPTS=$((MAX_BIND_ATTEMPTS-1))
            done  
        done < $DEV_LIST
    fi
    rm $DEV_LIST 2>/dev/null
}

case "$1" in
    hibernate|suspend) unbindDev;;
resume|thaw)       bindDev;;
esac" | sudo tee /etc/pm/sleep.d/20_custom-ehci_hcd 
sudo chmod 755 /etc/pm/sleep.d/20_custom-ehci_hcd
exit 0
