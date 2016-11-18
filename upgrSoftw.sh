#!/bin/bash

if [[ `whoami` != "root" ]]; then
    echo "Skript kann nur als 'Root' ausgeführt werden!"
    sudo echo ""
fi

# # Remove old kernels
# sudo dpkg -l 'linux-*' | sed '/^ii/!d;/'"$(uname -r | sed\
#     "s/\(.*\)-\([^0-9]\+\)/\1/")"'/d;s/^[^ ]* [^ ]* \([^ ]*\).*/\1/;/[0-9]/!d' |\
#     xargs sudo apt-get -y purge

# Update System
yes y | sudo apt-get update
yes y | sudo apt-get upgrade
# yes y | sudo apt-get dist-upgrade
# yes y | sudo apt-get autoremove
yes y | sudo apt-get -f install
yes y | sudo pip update
yes y | sudo cabal update

#yes y | pip install --upgrade beets pyacoustid pylast pyyaml
#dpkg --clear-selections
notify-send "Dateien erfolgreich upgegraded!"
exit
