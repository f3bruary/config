#!/bin/bash

if [[ -z $(pgrep spotify) ]]; then
    true
else
    spotify="$(echo `dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get string:'org.mpris.MediaPlayer2.Player' string:'Metadata'|egrep -A 2 "artist"|egrep -v "artist"|egrep -v "array"|cut -b 27-|cut -d '"' -f 1|egrep -v ^$` "-" `dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get string:'org.mpris.MediaPlayer2.Player' string:'Metadata'|egrep -A 1 "title"|egrep -v "title"|cut -b 44-|cut -d '"' -f 1|egrep -v ^$`)"
    echo $spotify
fi

if [[ -z $(pgrep cmus) ]]; then
    true
else
    cmus=`cmus-remote -Q | grep 'file' | cut -d '/' -f 5 | sed -e 's/\.mp3//g'`
    echo $cmus
fi
