#!/bin/sh
# setxkbmap only work with display
setxkbmap -option caps:escape &
fcitx &

# display stuff
xwallpaper --zoom $HOME/bg.png &
compton &
redshift &

# automount usb
udiskie &

# natual scroll
touchpadid=`xinput | awk -F'=' '/Synaptics/ {print $2}' | awk '{print $1}'`
natualscrollid=`xinput list-props $touchpadid | awk -F'[()]' '/Natural/ {print $2;exit;}'`
xinput set-prop $touchpadid $natualscrollid 1

# clipboard and primary
# autocutsel -selection PRIMARY &
