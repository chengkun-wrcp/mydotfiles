#!/bin/sh

# INPUT
setxkbmap -option caps:escape & # setxkbmap doesn't work in tty
fcitx &

# DISPLAY STUFF
xwallpaper --zoom $HOME/bg.png &
compton &
# xcompmgr &
redshift &

# AUTOMOUNT USB
udiskie &

# NATUAL SCROLL
touchpadid=`xinput | awk -F'=' '/Synaptics/ {print $2}' | awk '{print $1}'`
natualscrollid=`xinput list-props $touchpadid | awk -F'[()]' '/Natural/ {print $2;exit;}'`
xinput set-prop $touchpadid $natualscrollid 1

# CLIPBOARD AND PRIMARY
# autocutsel -selection PRIMARY &
