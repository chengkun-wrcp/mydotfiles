# [[ -f ~/.bashrc ]] && . ~/.bashrc
# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# clean my home directory
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
# config fiel
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export WGETRC="$XDG_CONFIG_HOME/wget/wgetrc"
export MPLAYER_HOME="$XDG_CONFIG_HOME/mplayer"
# data file
export PASSWORD_STORE_DIR="$XDG_DATA_HOME/password-store"
export WWW_HOME="$XDG_DATA_HOME/w3m"
# export XAUTHORITY="$XDG_DATA_HOME/Xauthority" #ERROR
# historyfile
export LESSHISTFILE="$XDG_CACHE_HOME/lesshist"

# use vim for manual page
export MANPAGER="/bin/sh -c \"col -b | vi --not-a-term -c 'setlocal ft=man ts=8 nonu nornu nomod nolist nobl noma ignorecase' -\""
export TERMINAL='st'
