#!/bin/bash

wlan_find ()
{
    while true; do
        # Stärkstes unsicheres Wlan finden
        nm-tool | grep Strength | egrep -v '(WEP|WPA)' | sed 's/^ *//g' | sort -t ',' -k 5
        # essid=$(nm-tool | grep Strength | egrep -v '(WEP|WPA)' | sed 's/^ *//g' | sort -t ',' -k 5 | tail -n 1 |  sed -e 's/^ *//g;s/: .*//g')
        essid="eduroam"
        echo $essid

        # Verbinden zum Wlan
        #if [ $essid = "" ]; then
        #echo "usage: $0 ESSID"
        #fi

        echo "connecting to $essid requires"
        echo "root rigths ..."
        sleep 1

        #sudo ifconfig wlan0 down
        #sudo dhclient -r wlan0
        #sudo ifconfig wlan0 up
        sudo iwconfig wlan0 essid "$essid"
        sudo iwconfig wlan0 mode Managed
        sudo echo "activate"
        sudo dhclient wlan0 &
        sleep 5

        # Internetverbindung überprüfen
        testconnection=`wget --tries=3 --timeout=15 www.google.com -O /tmp/.testinternet &>/dev/null 2>&1`
        if [[ $? = 0 ]]; then
            echo Internetverbindung - ok
            rm /tmp/.testinternet  > /dev/null 2>&1
            break
        fi
    done
}

wlan_restart_network_manager ()
{
    # #############
    # ### Restart.Network-Manager
    # #############
    sudo /etc/init.d/network-manager stop
    sudo iwconfig wlan0 power off
    sudo /etc/init.d/network-manager restart
    sudo service network-manager restart
}

inet_refresh ()
{
    # http://ubuntuforums.org/showthread.php?t=1877120&p=11434781#post11434781
    # sudo ifconfig wlan0 down
    # sudo modprobe -rf ath9k
    sudo rmmod -f ath9k
    sudo modprobe -v ath9k nohwcrypt=1
    sudo depmod -a
    # sudo ifconfig wlan0 up
}

print_config_settings() {
    echo "check what drivers get loaded"
    lspci -v | less

    read -p "More results [enter] "
    # http://ubuntuforums.org/showthread.php?t=1877120&page=10&p=11585392#post11585392
    lsmod | less
    nm-tool | less
    iwconfig | less
    rfkill list all | less
    sudo ifconfig -a | less
}

#.#############
#.##.Variante.2
#.#############
selTitle="Auswahlmenue"
selPrompt="Wähle eine der Optionen:"
selOptions=("find wlan" "refresh inet connection" "restart network-manager" "print details")

echo "$selTitle"
select opt in "${selOptions[@]}" "Quit";
do
    case "$REPLY" in
        1 ) echo "Du hast Option $REPLY gewählt: $opt"
            wlan_find
            break
            ;;
        2 ) echo "Du hast Option $REPLY gewählt: $opt"
            inet_refresh
            break
            ;;
        3 ) echo "Du hast Option $REPLY gewählt: $opt"
            wlan_restart_network_manager
            break
            ;;
        4 ) echo "Du hast Option $REPLY gewählt: $opt"
            print_config_settings
            break
            ;;
        $(( ${#selOptions[@]}+1 )) ) echo "Goodbye!"; break
            ;;
        *) echo "Ungültige Option. Wähle etwas anderes.";continue
            exit 0
            ;;
    esac
done
