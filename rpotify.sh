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


case "$1" in

        play | pause)	$PLAYER.PlayPause 	1>/dev/null ;;
		stop) 			$PLAYER.Stop 		1>/dev/null ;;
		next) 			$PLAYER.Next 		1>/dev/null ;;
		prev) 			$PLAYER.Previous 	1>/dev/null ;;
        *)				echo "Bad argument" 			;;
esac