#!/usr/bin/env python
#
# A simple daemon script, that copies the current desktop wallpaper 
# to the xsplash image folder whenever it is changed, to keep xsplash
# and gdm consitent with the desktop.
#
# Author: meerkat (meerkat@gmx.de)
# Version: 1.21 
# License: GPL v3

import gtk
import gconf
import subprocess
import sys
import time

def key_changed_callback (client, cnxn_id, entry, info):
    if not entry.value:
	print '<unset>'
    else:
	if entry.value.type == gconf.VALUE_STRING:
	    print entry.value.to_string ()
	    command = "convert \""+entry.value.to_string ()+"\" /usr/share/images/xsplash/bg.jpg\ncd /usr/share/images/xsplash\nln -s -f -T bg.jpg bg_800x600.jpg\nln -s -f -T bg.jpg bg_1024x768.jpg\nln -s -f -T bg.jpg bg_1280x800.jpg\nln -s -f -T bg.jpg bg_1280x1024.jpg\nln -s -f -T bg.jpg bg_1440x900.jpg\nln -s -f -T bg.jpg bg_1680x1050.jpg\nln -s -f -T bg.jpg bg_1920x1200.jpg\nln -s -f -T bg.jpg bg_2560x1600.jpg"
	    subprocess.Popen(command, shell=True, stdout=subprocess.PIPE,)
	else:
	    print '<wrong type>'

install = False

if len(sys.argv) > 1:
	for arg in sys.argv:	
	    if arg == "--install":
	        xsplashpath="/usr/share/images/xsplash"
	        command = "sudo chmod -R a+rw "+xsplashpath
	        subprocess.Popen(command, shell=True, stdout=subprocess.PIPE,).wait()
	        command = "tar -cf "+xsplashpath+"/backup."+str(int(time.time()))+" "+xsplashpath+"/*"
	        subprocess.Popen(command, shell=True, stdout=subprocess.PIPE,).wait()
	        command = "sudo -u gdm gconftool-2 -t string -s /desktop/gnome/background/picture_filename /usr/share/images/xsplash/bg_2560x1600.jpg"
	        subprocess.Popen(command, shell=True, stdout=subprocess.PIPE,).wait()
	        install = True
	        print "installation done"
	    if arg == "--gdm":
	        command = "my_gtk_theme=`gconftool-2 --get /desktop/gnome/interface/gtk_theme`\nsudo -u gdm gconftool-2 --set --type string /desktop/gnome/interface/gtk_theme \"$my_gtk_theme\""
	        subprocess.Popen(command, shell=True, stdout=subprocess.PIPE,).wait()
	        command = "my_icon_theme=`gconftool-2 --get /desktop/gnome/interface/icon_theme`\nsudo -u gdm gconftool-2 --set --type string /desktop/gnome/interface/icon_theme \"$my_icon_theme\""
	        subprocess.Popen(command, shell=True, stdout=subprocess.PIPE,).wait()
	        print "applied current gtk and icon theme on gdm login"
	    if arg == "--restore-gdm":
	        command = "sudo -u gdm gconftool-2 --set --type string /desktop/gnome/interface/gtk_theme HumanLogin"
	        subprocess.Popen(command, shell=True, stdout=subprocess.PIPE,).wait()
	        command = "sudo -u gdm gconftool-2 --set --type string /desktop/gnome/interface/icon_theme HumanLoginIcons"
	        subprocess.Popen(command, shell=True, stdout=subprocess.PIPE,).wait()
	        print "restored default gdm theme"

if len(sys.argv) == 1 or install:
	client = gconf.client_get_default ()
	client.add_dir ('/desktop/gnome/background',gconf.CLIENT_PRELOAD_NONE)
	client.notify_add ("/desktop/gnome/background/picture_filename",key_changed_callback)
	print "daemon started"
	gtk.main()

