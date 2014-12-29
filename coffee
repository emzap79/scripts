#!/bin/bash

# Configuration {{{ -
#.###.Define.Strings
quest=$1
slpmin=600

#.###.Set.Delay.Time
del_idle=600
del_sleep_ac=600
del_sleep_batt=120
del_dim=300

#.###.Sleep.&.Suspend
gsettings set org.gnome.desktop.screensaver lock-enabled false
gsettings set org.gnome.desktop.screensaver idle-activation-enabled true
gsettings set org.gnome.desktop.screensaver ubuntu-lock-on-suspend true

#.###.Dimming.Screen
gsettings set org.gnome.settings-daemon.plugins.power idle-dim false

#.###.Activating.Hibernate/Suspend
gsettings set org.gnome.settings-daemon.plugins.power lid-close-ac-action 'suspend'
gsettings set org.gnome.settings-daemon.plugins.power button-sleep 'suspend'
# }}} Configuration -

# Functions {{{ -
set_on ()
{ #{{{
	# Set Sleep Time in Minutes
	slpmin=120
	# Disactivate Sleep
	notify-send --hint=int:transient:1 'Bildschirmschoner wird für 120 Minuten ausgeschaltet'
} #}}}
set_espr ()
{ #{{{
	# Reset Delay Time
	del_idle=0
	del_sleep_ac=0
	del_sleep_batt=0
	del_dim=0

	# Set Sleep Time in Minutes
	slpmin=0

	# Send Notification & Apply
	notify-send --hint=int:transient:1 'Bildschirmschoner abgeschaltet!'
} #}}}
set_other ()
{ #{{{
	# Set Sleep Time in Minutes
	slpmin="$quest"

	# Send Notification & Apply
	notify-send --hint=int:transient:1 "Bildschirmschoner wird für $quest Minuten ausgeschaltet"
	appl_disactivate
	appl_activate
} #}}}
start_exec ()
{ #{{{
	case "$quest" in
		"help")
			echo "Unbekannter Parameter"
			echo "usage: $0 [on|off|espr(esso)|help] { delay of time } "
			;;

		"off")

			# Set Sleep Time
			slpmin=0

			# Send Notification & Apply
			notify-send --hint=int:transient:1 'Bildschirmschoner wird (erneut) aktiviert!'
			appl_activate
			;;

		"on"|"start")
			set_on
			appl_disactivate
			appl_activate
			;;

		"espr"|"espresso")
			set_espr
			appl_activate
			;;

		*)
			set_other
			;;
	esac
} #}}}
appl_disactivate ()
{ #{{{
	echo disact
	gsettings set org.gnome.desktop.session idle-delay 0
	gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-timeout 0
	gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-timeout 0
} #}}}
appl_activate ()
{ #{{{
	echo activate
	sleep "$slpmin"m
	gsettings set org.gnome.desktop.session idle-delay $del_idle
	gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-timeout $del_sleep_ac
	gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-timeout $del_sleep_batt
	#gsettings set org.gnome.settings-daemon.plugins.power idle-dim-time $del_dim
} #}}}
# }}} Functions -
start_exec
