#!/bin/sh
# setxkbmap only work with display
setxkbmap -option caps:escape &
fcitx &

# display stuff
xwallpaper --zoom $HOME/arch.png &
compton &
redshift &

# automount usb
udiskie &

# natual scroll
touchpadid=`xinput | awk '/Synaptics/ {print $5}'`
touchpadid=${touchpadid/"id="/}
natualscrollid=`xinput list-props 13 | awk -F'[()]' '/Natural/ {print $2;exit;}'`
xinput set-prop $touchpadid $natualscrollid 1

# clipboard and primary
# autocutsel -selection PRIMARY &
