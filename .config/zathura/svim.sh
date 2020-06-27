#! /bin/zsh
# Created	: Wed 08 Feb 2006 10:40:21 AM CST
# Modified	: Tue 10 Dec 2019 11:41:01 AM CET
# Author	: Gautam Iyer <gautam@math.uchicago.edu>
# Description	: Shell script to start vim in client-server mode (e.g. from
#		  xdvi for inverse searching). If a file named foo.tex is one of
#		  the arguments, then it attempts to connect to the vim server
#		  FOO (also raises / focuses the window in Fvwm). If the server
#		  is not found (or no tex file is supplied), it starts a new vim
#		  instance.
#
# Usage		: Just run it as you would run vim. If the first option is "-G",
#		  then instead of using a console vim, this script runs "gvim
#		  -v". This is because some systems have a console vim installed
#		  without X, or client server capabilities.

# 2016-01-17: Sometime Vim leaks memeory and gobbles everything. Limit memory
# usage of all subprocesses to 1Gb
ulimit -Sv 1000000

# Check if we should use vim, or "gvim -v"
if [[ $1 == "-G" ]]; then
    vimProg=(gvim -v)
    shift
elif vim --version | grep -q -- '\+clientserver'; then
    vimProg=(${=EDITOR:-vim})
else
    vimProg=(${=VISUAL:-gvim})
fi

if [[ $1 == '-a' ]]; then
    vimProg+=(-c ':AutoCompile 0')
    shift
fi

declare -a vimServers
vimServers=($($vimProg --serverlist))

# Set vim servername to be the root name of tex file (if specified)
for i in "$@"; do
    if [[ ${i} == *.tex ]]; then
	fileName=$i;
	# Strip off path and extension, and convert to uppercase.
	serverName=$(sed -e 's:\(.*/\)\?\(.*\)\.tex:\U\2\E:' <<< $i)
	break;
    fi
done

# Check if file is being edited in an already running vim server
#for i in "${vimServers[@]}"; do
#    if (( $(vim --servername $i --remote-expr "bufloaded('$fileName')") ));
#    then
#	#
#	# Console vim sessions need to be manually raised. Easy to do on
#	# Fvwm2. All other WM's suck. This needs the servername to be the
#	# last word (space preceded) in the title (default on vim).
#	#
#	FvwmCommand "Next (konsole, '* - $i — Konsole') WindowListFunc"
#	exec $vimProg --servername $i --remote "$@"
#    fi
#done

## If we got here, then we couldn't find a matching server.
## Look for a swap file; if present use the first vim server.
#if [[ -e ${fileName:h}/.${fileName:t}.swp ]] && (( ${#vimServers[@]} > 0 ));
#then
#    serverName=${vimServers[1]}
#    
#    FvwmCommand "Next (konsole, '* - $serverName — Konsole') WindowListFunc"
#    exec $vimProg --servername $serverName --remote "$@"
#fi

# All else failed, start a new server.
[[ -z $serverName ]] && serverName=VIM

# 2006-02-24: Checking if we're on a tty using tty -s is not enough. If xdvi
# launched this script, and xdvi was launched from a terminal, then "tty -s"
# will return true, and our vim process will hog up the terminal.
#
# Explicitly check if the parent process is a shell.

parentProcess=$(ps h -o comm --pid $PPID)
if tty -s && [[ $parentProcess =~ ^((ba)?sh|t?csh|zsh)$ ]]; then
    exec $vimProg --servername $serverName "$@"
elif [[ -n $DISPLAY ]]; then
    exec gvim --servername $serverName "$@"
else
    echo "Not running on tty or X"
fi
