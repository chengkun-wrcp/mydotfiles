#!/bin/bash
# baraction.sh for spectrwm status bar

## POWER
power() {
    bat=`cat /sys/class/power_supply/BAT1/capacity`
    echo -e $bat
}

## DISK
hdd() {
    root="$(df -h | awk 'NR==4{print $6":"$5}')"
    home="$(df -h | awk 'NR==8{print $6":"$5}')"
    echo -e "+@fg=2;+@fn=2;|+@fg=6;+@fn=0; $root $home"
}

## RAM
mem() {
    mem=`free | awk '/Mem/ {printf "%.1f%\n", 100*$3/$2}'`
    echo -e "+@fg=2;+@fn=2;|+@fg=5;+@fn=0; RAM $mem"
}

## CPU
cpu() {
    read cpu a b c previdle rest < /proc/stat
    prevtotal=$((a+b+c+previdle))
    sleep 0.5
    read cpu a b c idle rest < /proc/stat
    total=$((a+b+c+idle))
    cpu=$((100*( (total-prevtotal) - (idle-previdle) ) / (total-prevtotal) ))
    length=${#cpu}
    length=$((3-length))
    echo -e "+@fg=2;+@fn=2;|+@fg=4;+@fn=0; CPU+$length<$cpu%"
}

## VOLUME
vol() {
    vol=`amixer get Master | awk -F'[][]' 'END{ print $2 }' | sed 's/on://g'`
    echo -e "+@fg=2;+@fn=2;|+@fg=3;+@fn=3; 墳 $vol"
}

SLEEP_SEC=3
#loops forever outputting a line every SLEEP_SEC secs

# It seems that we are limited to how many characters can be displayed via
# the baraction script output. And the the markup tags count in that limit.
# So I would love to add more functions to this script but it makes the
# echo output too long to display correctly.
while :; do
    echo "$(vol)  $(cpu) $(mem) $(hdd) +@fg=0;"
    # echo "+@fg=1; +@fn=1;💻+@fn=0; $(cpu) +@fg=0; | +@fg=2; +@fn=1;💾+@fn=0; $(mem) +@fg=0; | +@fg=3; +@fn=1;💿+@fn=0; $(hdd) +@fg=0; | +@fg=4; +@fn=1;🔈+@fn=0; $(vol) +@fg=0; |"
    sleep $SLEEP_SEC
done
