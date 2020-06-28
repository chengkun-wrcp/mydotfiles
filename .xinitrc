#!/bin/sh
# 用 login manager 的话会用 .xsession 而不会source此文件
. ~/.xsession
exec spectrwm
