#!/bin/bash
### Elantech Touchpad
#gksudo cp /etc/modprobe.d/options /etc/modprobe.d/options.bkp
sudo modprobe -r psmouse
sudo modprobe psmouse proto=imp
#echo "options psmouse proto=imps" | sudo tee /etc/modprobe.d/options
exit 0
