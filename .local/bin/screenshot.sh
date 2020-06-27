#!/bin/bash
set -e
# get the screen shot of current window or full screen
if [ $1 == "window" ];then
    id=`xprop -root _NET_ACTIVE_WINDOW | grep -o "0x.*"`
    subname="window"
else
    id="root"
    subname="full"
fi
# import is from imagemagick
dir="$HOME/Pictures/screenshots"
time=$(timedatectl | awk '/Local/ {print $4,$5}' | sed 's/-//g;s/ /-/g')
import -window $id "$dir/screenshot-$subname-$time.png"
