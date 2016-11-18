#!/bin/bash

#.################
#.#.Check.for.Root
#.################
if [[ `id -u` -ne 0 ]]; then
    echo ""
    echo "hi `id -un`!"
    echo "please reenter as root"
    echo ""
    exit 1
fi

### Dependencies installieren #
yes y | apt-get install libtool

### Neueste Perl-Version installieren
sudo -u $USER read -p "Bei Befehl 'cpan[1]> upgrade' eingeben "
cpan

### Gpaste-Applet installieren
make install
glib-compile-schemas /usr/share/glib-2.0/schemas/
