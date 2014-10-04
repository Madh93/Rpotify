#!/bin/bash

PLAYER="dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player"
title=`dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get string:'org.mpris.MediaPlayer2.Player' string:'Metadata'|egrep -A 1 "title"|egrep -v "title"|cut -b 44-|cut -d '"' -f 1|egrep -v ^$`
artist=`dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get string:'org.mpris.MediaPlayer2.Player' string:'Metadata'|egrep -A 2 "artist"|egrep -v "artist"|egrep -v "array"|cut -b 27-|cut -d '"' -f 1|egrep -v ^$`
album=`dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get string:'org.mpris.MediaPlayer2.Player' string:'Metadata'|egrep -A 1 "album"|egrep -v "album"|cut -b 44-|cut -d '"' -f 1|egrep -v ^$`
year=`dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get string:'org.mpris.MediaPlayer2.Player' string:'Metadata' | grep T00 | cut -d '"' -f2  | cut -d '-' -f1`
duration=`dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get string:'org.mpris.MediaPlayer2.Player' string:'Metadata' | grep uint64 | cut -d "u" -f2 | cut -d " " -f2`
uri=`dbus-send --print-reply --session --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get string:'org.mpris.MediaPlayer2.Player' string:'Metadata' | grep spotify:track | cut -d ":" -f3 | cut -d '"' -f1 | sed -n '1p'`

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