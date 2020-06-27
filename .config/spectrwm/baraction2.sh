#!/bin/bash
# baraction.sh for spectrwm status bar
block(){
    # $1 is the color index, the nth color of fg and bg should be equal in spectrwm.conf,n>2
    # $1 : color of the block, $2: color of the text, $3: text
    echo "+@fg=$1;+@bg=$1;+@fg=$2; $3 "
}

# 5 blocks, use color @fg=3,4,5,6,7
## VOLUME 墳 婢
vol() {
    vol=`amixer get Master | awk -F'[][]' 'END{ print $6" "$2 }' | sed 's/on/墳/;s/off/婢/'`
    b=`block 3 2 "$vol"`
    echo -e $b
}

## BRIGHTNESS☀️ ☼ ☉ 🌣
bright() {
    current=`cat /sys/class/backlight/intel_backlight/brightness`
    max=`cat /sys/class/backlight/intel_backlight/max_brightness`
    b=`block 4 2 "+@fn=3; +@fn=0;$((100*current/max))%"`
    echo -e $b
}

## CPU ⎚ 
cpu() {
    read cpu a b c previdle rest < /proc/stat
    prevtotal=$((a+b+c+previdle))
    sleep 0.5
    read cpu a b c idle rest < /proc/stat
    total=$((a+b+c+idle))
    cpu=$((100*( (total-prevtotal) - (idle-previdle) ) / (total-prevtotal) ))
    clength=${#cpu}
    clength=$((3-clength))
    iconcpu="+@fn=3; +@fn=0;"
    #温度
    tem=`sensors | awk '/Core 0/ {print $3}' | sed 's/+//'`
    b=`block 5 2 "$iconcpu$tem+$clength<$cpu%"`
    echo -e $b
}

## RAM 
mem() {
    mem=`free | awk '/Mem/ {printf "%.1f%\n", 100*$3/$2}'`
    iconmem="+@fn=4;+@fn=0;"
    b=`block 6 2 "$iconmem$mem"`
    echo -e $b
}

## POWER ⚡           
power() {
    bat=`cat /sys/class/power_supply/BAT1/capacity`
    status=`cat /sys/class/power_supply/BAT1/status`
    # status: Discharging , Charging , Full , Uknown
    #       not connected                     connected but not charging
    [ $bat -gt 20 ] && icon=""
    [ $bat -gt 30 ] && icon=""
    [ $bat -gt 40 ] && icon=""
    [ $bat -gt 50 ] && icon=""
    [ $bat -gt 60 ] && icon=""
    [ $bat -gt 70 ] && icon=""
    [ $bat -gt 80 ] && icon=""
    [ $bat -gt 90 ] && icon=""
    [ $bat -gt 94 ] && icon=""
    [ $status == "Charging" ] && icon=""
    b=`block 7 2 "$icon $bat%"`
    echo -e $b
}

## DISK
hdd() {
    root="$(df -h | awk 'NR==4{print $6":"$5}')"
    home="$(df -h | awk 'NR==8{print $6":"$5}')"
    b=`block 8 2 "$root $home"`
    # b="+@fg=1;+@bg=0;+@fg=3; $root $home "
    echo -e $b
}

SLEEP_SEC=2
NET=wlp3s0
# calculate the upload/download speed in the loop
while :; do
    up_time1=`ifconfig $NET | awk '/TX packets/ {print $5}'`
    down_time1=`ifconfig $NET | awk '/RX packets/ {print $5}'`
    sleep $SLEEP_SEC
    up_time2=`ifconfig $NET | awk '/TX packets/ {print $5}'`
    down_time2=`ifconfig $NET | awk '/RX packets/ {print $5}'`
    up_time=$((up_time2-up_time1))
    down_time=$((down_time2-down_time1))
    up_time=$((up_time/1024/SLEEP_SEC))
    down_time=$((down_time/1024/SLEEP_SEC))
    downicon="+@fn=3; +@fn=0;"
    upicon="+@fn=3; +@fn=0;"
    netstatus=`block 2 0 "$upicon$up_time kb/s $downicon$down_time kb/s"`
    # check whether v2ray is onⓥ ☑
    v2ray=`systemctl status v2ray | awk '/Active:/ {print $2}'`
    [ $v2ray == "active" ] && netstatus=$netstatus"+@fg=6;+@fn=1;ⓥ+@fg=0;+@fn=0;"
    echo "$netstatus $(vol) $(bright) $(cpu) $(mem) $(power) $(hdd)"
done
