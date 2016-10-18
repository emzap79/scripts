#!/bin/bash
### WiFi nach "aufwecken" einschalten
echo "#!/bin/sh
case "$1" in
    suspend|hibernate)
        /sbin/rmmod ath9k
        ;;
    resume|thaw)
        /sbin/rmmod ath9k
        /sbin/modprobe ath9k
        ;;
esac
exit 0" | sudo tee /etc/pm/sleep.d/00_wireless_sleep
gksudo chmod 755 /etc/pm/sleep.d/00_wireless_sleep
exit 0
