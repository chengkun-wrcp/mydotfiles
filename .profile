#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc
# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

setxkbmap -option caps:escape
