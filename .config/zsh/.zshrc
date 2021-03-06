# # Created by newuser for 5.8

# general alias for bash and zsh
[ -f ~/.config/shell_aliases ] && . ~/.config/shell_aliases

# colors and prompt:
# https://stackoverflow.com/questions/689765/how-can-i-change-the-color-of-my-prompt-in-zsh-different-from-normal-text
autoload -U colors && colors	# Load colors
# PS1="%B%{$fg[green]%}%n@%M %{$fg[blue]%}%~%{$reset_color%}$%b "
PS1="%B%K{240}%F{014} %~ %F{240}%k%b %f"
RPS1="%B%F{209}%(?..(%?%))%b%{$fg[magenta]%}%T%f"

# vim mode:
bindkey -v
# bindkey in vim normal mode
bindkey -a '' backward-char
bindkey -a "[P"  delete-char
bindkey -a "[3~" delete-char
bindkey -a "[H" vi-beginning-of-line
bindkey -a "[7~" vi-beginning-of-line
bindkey -a "[4~" vi-end-of-line
bindkey -a "[8~" vi-end-of-line
# bindkey in vim insert mode (man zshzle)
bindkey -v '' backward-delete-char
bindkey -v "[P"  delete-char
bindkey -v "[3~" delete-char
bindkey -v "[H" vi-beginning-of-line
bindkey -v "[4~" vi-end-of-line
 ## history search
bindkey -v '\eOA' history-beginning-search-backward
bindkey -v '\e[A' history-beginning-search-backward
bindkey -v '\eOB' history-beginning-search-forward
bindkey -v '\e[B' history-beginning-search-forward
bindkey -v '' history-beginning-search-backward
# bindkey -v ' ' history-beginning-search-forward


# use middle-click for pass rather than clipboard
# export PASSWORD_STORE_X_SELECTION=primary
# export PASSWORD_STORE_CLIP_TIME=10

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.
# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect '' send-break


# history stuff
HISTFILE=$HOME/.cache/zsh_history   # set bash history and zsh history seperately
HISTSIZE=2000
SAVEHIST=2000
setopt append_history
setopt hist_expire_dups_first
setopt hist_ignore_space
setopt inc_append_history
setopt share_history
# https://stackoverflow.com/questions/1444406/how-to-delete-duplicate-lines-in-a-file-without-sorting-it-in-unix
hist_clear_duplicate(){
    tempfile=`mktemp`
    tac $HISTFILE | sed 's/ $//' | awk '!seen[$0]++' | tac > $tempfile
    mv $tempfile $HISTFILE
}
# alias e='hist_clear_duplicate && exit'
hist_clear_duplicate

# others
setopt autocd		# Automatically cd into typed directory.
setopt correct
stty stop undef		# Disable ctrl-s to freeze terminal.

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
