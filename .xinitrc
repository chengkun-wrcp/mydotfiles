#!/bin/sh
# 用 login manager 的话会用 .xsession 而不会source此文件
# 把主要设置都写到.xsession里面
[ -f $HOME/.xsession ] && . $HOME/.xsession
[ -f $HOME/.Xresources ] && xrdb -load $HOME/.Xresources
exec spectrwm
