#!/bin/bash

DBUS_SEND="dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2"
PROPERTIES="org.freedesktop.DBus.Properties.Get"

PLAYER="$DBUS_SEND org.mpris.MediaPlayer2.Player"
title=`$DBUS_SEND $PROPERTIES string:'org.mpris.MediaPlayer2.Player' string:'Metadata'|egrep -A 1 "title"|egrep -v "title"|cut -b 44-|cut -d '"' -f 1|egrep -v ^$`
artist=`$DBUS_SEND $PROPERTIES string:'org.mpris.MediaPlayer2.Player' string:'Metadata'|egrep -A 2 "artist"|egrep -v "artist"|egrep -v "array"|cut -b 27-|cut -d '"' -f 1|egrep -v ^$`
album=`$DBUS_SEND $PROPERTIES string:'org.mpris.MediaPlayer2.Player' string:'Metadata'|egrep -A 1 "album"|egrep -v "album"|cut -b 44-|cut -d '"' -f 1|egrep -v ^$`
year=`$DBUS_SEND $PROPERTIES string:'org.mpris.MediaPlayer2.Player' string:'Metadata' | grep T00 | cut -d '"' -f2  | cut -d '-' -f1`
duration=`$DBUS_SEND $PROPERTIES string:'org.mpris.MediaPlayer2.Player' string:'Metadata' | grep uint64 | cut -d "u" -f2 | cut -d " " -f2`
id=`$DBUS_SEND $PROPERTIES string:'org.mpris.MediaPlayer2.Player' string:'Metadata' | grep spotify:track | sed -n '1p' | cut -d '"' -f2`
status=`$DBUS_SEND $PROPERTIES string:'org.mpris.MediaPlayer2.Player' string:'PlaybackStatus' | grep string | cut -d '"' -f2`

bold=`tput bold`
normal=`tput sgr0`


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

function control
{
	xdotool_path=`which xdotool`
	if [ -z $xdotool_path ]; then
		echo "WARNING: xdotool doesn't installed. Please install xdotool."
	else
		xdotool search --name 'Spotify - Linux Preview' key --window %@ $1
	fi
}

function nowplaying
{
	echo "${bold}Now playing: ${normal}$title - $artist"
}

function information
{
	echo "${bold}Title: ${normal}$title"
	echo "${bold}Artist: ${normal}$artist"
	echo "${bold}Album: ${normal}$album"
	echo "${bold}Year: ${normal}$year"
	echo "${bold}Duration: ${normal}$((duration/60000000))' $(((duration/1000000)%60))''"
	echo "${bold}ID: ${normal}$id"
}


case "$1" in

		play | pause)	$PLAYER.PlayPause 	1>/dev/null 	;;
		stop) 			$PLAYER.Stop 		1>/dev/null 	;;
		next) 			$PLAYER.Next 		1>/dev/null 	;;
		prev) 			$PLAYER.Previous 	1>/dev/null 	;;
		status)			echo $status 						;;
		up) 			control 'ctrl+Up' 					;;
		down) 			control 'ctrl+Down'					;;
		shuffle) 		control 'ctrl+s' 					;;
		repeat) 		control 'ctrl+r' 					;;
		now)			nowplaying							;;
		info)			information							;;
        *)				echo "Bad argument" 				;;
esac