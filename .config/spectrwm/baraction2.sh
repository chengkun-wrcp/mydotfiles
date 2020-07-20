#!/bin/bash
# baraction.sh for spectrwm status bar
block(){
    # $1 is the color index, the nth color of fg and bg should be equal in spectrwm.conf,n>2
    # $1 : color of the block, $2: color of the text, $3: text
    echo "+@fg=$1;+@bg=$1;+@fg=$2; $3 "
}

# 5 blocks, use color @fg=3,4,5,6,7
## BRIGHTNESS盛  ☼  🌣
bright() {
    current=`cat /sys/class/backlight/intel_backlight/brightness`
    max=`cat /sys/class/backlight/intel_backlight/max_brightness`
    b=`block $1 2 "+@fn=2;盛 +@fn=0;$((100*current/max))%"`
    echo -e $b
}

## VOLUME 墳 婢
vol() {
    vol=`amixer get Master | awk -F'[][]' 'END{ print $4" "$2 }' | sed 's/on/+@fn=2;墳+@fn=0;/;s/off/+@fn=2;婢+@fn=0;/'`
    b=`block $1 2 "$vol"`
    echo -e $b
}

## CPU ⎚  +@fn=3;
iconcpu="+@fn=2;+@fn=0;"
cpu() {
    read cpu a b c previdle rest < /proc/stat
    prevtotal=$((a+b+c+previdle))
    sleep 0.5
    read cpu a b c idle rest < /proc/stat
    total=$((a+b+c+idle))
    cpu=$((100*( (total-prevtotal) - (idle-previdle) ) / (total-prevtotal) ))
    clength=${#cpu}
    clength=$((3-clength))
    #温度
    tem=`sensors | awk '/Core 0/ {print $3}' | sed 's/+//'`
    b=`block $1 2 "$iconcpu $tem+$clength<$cpu%"`
    echo -e $b
}

## RAM 
iconmem="+@fn=4;+@fn=0;"
# iconmem="+@fn=2; +@fn=0;"
mem() {
    mem=`free | awk '/Mem/ {printf "%.1f%\n", 100*$3/$2}'`
    b=`block $1 2 "$iconmem$mem"`
    echo -e $b
}

## POWER            
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
    [ $status = "Charging" ] && icon=""
    b=`block $1 2 "$icon $bat%"`
    echo -e $b
}


## DISK
hdd() {
    root="$(df -h | awk 'NR==4{print $6":"$5}')"
    home="$(df -h | awk 'NR==8{print $6":"$5}')"
    b=`block $1 2 "$root $home"`
    echo -e $b
}

## NETWORK
SLEEP_SEC=2
NET=wlp3s0
downicon="+@fn=3; +@fn=0;"
upicon="+@fn=3; +@fn=0;"
net() {
    up_time1=`ifconfig $NET | awk '/TX packets/ {print $5}'`
    down_time1=`ifconfig $NET | awk '/RX packets/ {print $5}'`
    sleep $SLEEP_SEC
    up_time2=`ifconfig $NET | awk '/TX packets/ {print $5}'`
    down_time2=`ifconfig $NET | awk '/RX packets/ {print $5}'`
    up_time=$((up_time2-up_time1))
    down_time=$((down_time2-down_time1))
    up_time=$((up_time/1024/SLEEP_SEC))
    down_time=$((down_time/1024/SLEEP_SEC))
    netstatus=`block 2 0 "$upicon$up_time kb/s $downicon$down_time kb/s"`
    # check vpn is on  ☑ 
    v2ray=`systemctl status v2ray | awk '/Active:/ {print $2}'`
    [ $v2ray = "active" ] && netstatus=$netstatus"+@fg=5;+@fg=0;"
    echo -e $netstatus
}

while :; do
    echo "$network $(bright 3) $(vol 4) $(cpu 5) $(mem 6) $(power 7) $(hdd 8) +@fg=1;+@fn=2;+@bg=0;+@fg=7;+@fn=1;"
    network=$(net)
done
# 
