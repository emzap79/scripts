#!/bin/bash

add-apt-repository ppa:medibuntu-maintainers/ppa
add-apt-repository ppa:am-monkeyd/nautilus-elementary-ppa
add-apt-repository ppa:rye/ubuntuone-extras
add-apt-repository ppa:natesm/ease
add-apt-repository ppa:ubuntu-wine/ppa

apt-get update 
apt-get dist-upgrade 
apt-get install ubuntuone-indicator ease wine

apt-get install ding aspell-de aspell-fr screenlets gramps pidgin openoffice.org-emailmerge zeitgeist-core pdfshuffler hugin kstreamripper gnome-mplayer
