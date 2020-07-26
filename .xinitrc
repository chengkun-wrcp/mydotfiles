#!/bin/sh
# 用 login manager 的话会 source .xsession 而不会source此文件
# 因此把主要设置都写到.xsession里面
[ -f $HOME/.xsession ] && . $HOME/.xsession
[ -f $HOME/.Xresources ] && xrdb $HOME/.Xresources
# nvidia optimux settings, same with /etc/lightdm/display_setup.sh
xrandr --setprovideroutputsource modesetting NVIDIA-0
xrandr --auto
# start wm
exec spectrwm
