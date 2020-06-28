# # Created by newuser for 5.8

bindkey -v
# Enable colors and change prompt:
autoload -U colors && colors	# Load colors
# PS1="%B%{$fg[green]%}%n@%M %{$fg[blue]%}%~%{$reset_color%}$%b "
PS1="%K{240}%F{195} %~ %F{240}%k %f%b"
RPS1="%B%{$fg[red]%}%(?..(%?%))%b%{$fg[magenta]%}%T"
# RPS1="%B%{$fg[red]%}%(?..(%?%))%b%{$fg[magenta]%}%{$bg[magenta]%}%{$fg[black]%}%T"
setopt autocd		# Automatically cd into typed directory.
stty stop undef		# Disable ctrl-s to freeze terminal.

# use middle-click for pass rather than clipboard
export PASSWORD_STORE_X_SELECTION=primary
export PASSWORD_STORE_CLIP_TIME=10

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
bindkey -v '^?' backward-delete-char

# history stuff
HISTFILE=$HOME/.cache/zsh/history
HISTSIZE=10000
SAVEHIST=10000
setopt append_history
setopt hist_expire_dups_first
setopt hist_ignore_space
setopt inc_append_history
setopt share_history

# alias
[ -f ~/.config/shell_aliases ] && . ~/.config/shell_aliases

# fix zsh annoying history behavior
h() { if [ -z "$*" ]; then history 1; else history 1 | egrep "$@"; fi; }

autoload -Uz up-line-or-beginning-search
autoload -Uz down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey '\eOA' up-line-or-beginning-search
bindkey '\e[A' up-line-or-beginning-search
bindkey '\eOB' down-line-or-beginning-search
bindkey '\e[B' down-line-or-beginning-search

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
