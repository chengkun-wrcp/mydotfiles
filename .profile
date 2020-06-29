# [[ -f ~/.bashrc ]] && . ~/.bashrc
# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# use vim for manual page
export MANPAGER="/bin/sh -c \"col -b | vim --not-a-term -c 'set ft=man ts=8 nonu nornu nomod nolist nobl noma ignorecase' -\""

setxkbmap -option caps:escape
