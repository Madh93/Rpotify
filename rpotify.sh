#!/bin/bash

PLAYER="dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player"


# Check if DBUS_SESSION is set
if [ -z $DBUS_SESSION_BUS_ADDRESS ]; then

	user=`whoami`
	pid=`pgrep -o -u $user spotify`
	environ="/proc/$pid/environ"

	if [ -e $environ ]; then
		export `grep -z DBUS_SESSION_BUS_ADDRESS $environ`
	else
		echo "Unable to set DBUS_SESSION_BUS_ADDRESS"
		exit 1
	fi
fi