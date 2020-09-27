#!/bin/bash
# baraction.sh for spectrwm status bar
block(){
    # $1 is the color index, the nth color of fg and bg should be equal in spectrwm.conf,n>2
    # $1 : color of the block, $2: color of the text, $3: text
    echo "+@fg=$1;+@bg=$1;+@fg=$2; $3 "
}

# 5 blocks, use color @fg=3,4,5,6,7
## BRIGHTNESS盛盛  ☼  
bright() {
    current=`cat /sys/class/backlight/intel_backlight/brightness`
    max=`cat /sys/class/backlight/intel_backlight/max_brightness`
    b=`block $1 2 "+@fn=3; +@fn=0;$((100*current/max))%"`
    echo -e $b
}

## VOLUME 墳 婢
vol() {
    vol=`amixer get Master | awk -F'[][]' 'END{ print $4" "$2 }' | sed 's/on /+@fn=2;墳 +@fn=0;/;s/off /+@fn=2;婢 +@fn=0;/'`
    # cat /proc/asound/card1/codec\#0 | grep Pin-ctl | sed -n 3p # check whether headphone is plugged
    b=`block $1 2 "$vol"`
    echo -e $b
}

## CPU ⎚  +@fn=3;
# iconcpu="+@fn=2;+@fn=0;"
iconcpu="+@fn=3;+@fn=0;"
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
    root="$(df -h | awk '/sdb3/{print $6":"$5}')"
    home="$(df -h | awk '/sdb4/{print $6":"$5}')"
    b=`block $1 1 "$root $home"`
    echo -e $b
}

USER=`whoami`
usbcount=0
others(){
    android=`ls /run/user/1000/gvfs`
    # usb=`ls /run/media/$USER`
    usbnum=`ls -A /run/media/$USER | wc -l`
    if [ $usbnum -eq 0 ];then
        usbcount=0 
        # echo 0
        other='0'
    else
        usbcount=$(( usbcount % usbnum + 1 ))
        usbname=`ls -A /run/media/$USER | sed -n "$usbcount p"`
        usbAvailable=`df -h | grep "$usbname" | awk '{print $4}'`
        # echo $usbname': '$usbAvailable' avail'
        other=$usbname': '$usbAvailable' avail'
    fi
    # for usb in $usblist; do usbAvailable="$usbAvailable${usb##*/}:"`df -h | grep "$usb" | awk '{print $4}'`; done;
    # echo usbAvailable
}

## NETWORK 直睊
wifiname(){
    iw dev | awk '/ssid/{print $2}'
}
SLEEP_SEC=2
NET=wlp3s0
downicon="+@fn=3; +@fn=0;"
upicon="+@fn=3; +@fn=0;"
netspeed() {
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
    # if network speed is zero, show wifiname
    [ $up_time -lt 2 ] && [ $down_time -lt 2 ] && netstatus=`block 2 0 "+@fn=5;直 +@fn=0;$(wifiname)"`
    # check vpn is on  ☑ 
    v2ray=`systemctl status v2ray | awk '/Active:/ {print $2}'`
    [ $v2ray = "active" ] && netstatus=$netstatus"+@fg=5;+@fg=0;"
    echo -e $netstatus
}

while :; do
    others #global variables won't change if I assign the result of this function to a variable: other=$(others)
    [ $other = 0 ] && files=$(hdd 8) || files=`block 2 5 "$other"`
    # echo "$network $(bright 3) $(vol 4) $(cpu 5) $(mem 6) $(power 7) $(hdd 8) +@fg=1;+@fn=2;+@bg=0;+@fg=7;+@fn=1;"
    echo "$network $(bright 3) $(vol 4) $(cpu 5) $(mem 6) $(power 7) $files +@fg=1;+@fn=2;+@bg=0;+@fg=7;+@fn=1;"
    network=$(netspeed)
done
# 
