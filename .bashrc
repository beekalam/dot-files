# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples
BASEDIR="$(dirname $(readlink -f ${BASH_SOURCE[0]}))"

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# @History
# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth:erasedups

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=50000
HISTFILESIZE=50000


# ignore common commands
export HISTIGNORE=":pwd:id:uptime:ls:clear:history:cd:"

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# lampp server shortcuts
PATH=$PATH:/opt/lampp/bin
PATH=$PATH:/usr/local/go/bin
# pip3 virtualenv
PATH=$PATH:~/.local/bin
# go
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

# ------------ @functions ---------------

function mount_drives {
	#sudo mount -t ntfs -o rw,nosuid,nodev,relatime,user_id=1000,group_id=1000,default_permissions,allow_other,uhelper=udisks2 /dev/sda5 /media/moh/sam
	#sudo mount -t ntfs -o rw,nosuid,nodev,relatime,user_id=1000,group_id=1000,default_permissions,allow_other,uhelper=udisks2 /dev/sdc1 /media/moh/tos 

	sudo mount -t ntfs-3g  /dev/sda5 /media/moh/sam
	sudo mount -t ntfs-3g /dev/sdc1 /media/moh/tos
}

function myi3init {
	echo "Setting monitors..."
	secondmonitoronly
	echo "Cleaning unnecessary evolution services...."
	evoclean
	setkeyboardlayouts
	cleanservices
	xmodmap ~/.xmodmaprc
	echo "killing minerfs service ..."
	killminerfs
	echo "setting keyboard speed..."
	xset r rate 190 110
	echo "Mounting drives..."
	mount_drives
}

function myi3init_2_monitors {
	echo "Setting monitors..."
	echo "Cleaning unnecessary evolution services...."
	evoclean
	setkeyboardlayouts
	cleanservices
	xmodmap ~/.xmodmaprc
	echo "killing minerfs service ..."
	killminerfs
	echo "setting keyboard speed..."
	xset r rate 190 110
	echo "Mounting drives..."
	mount_drives
}

function myi3init_single_monitor {
	echo "Cleaning unnecessary evolution services...."
	evoclean
	setkeyboardlayouts
	cleanservices
	xmodmap ~/.xmodmaprc
	echo "killing minerfs service ..."
	killminerfs
	echo "setting keyboard speed..."
	xset r rate 190 110
	echo "Mounting drives..."
	mount_drives
}

function mygnomeinit {
    xmodmap ~/.xmodmaprc

    #xset r rate 190 110

    # repeat-interval default is 30
    gsettings set org.gnome.desktop.peripherals.keyboard repeat-interval  20
    # delay default is 500
    gsettings set org.gnome.desktop.peripherals.keyboard delay 170

    #gsettings set org.gnome.desktop.peripherals.keyboard repeat-interval 15 
    #gsettings set org.gnome.desktop.peripherals.keyboard delay 130
}
function set_nextdns_for_vpn {
	vpn_id=`nmcli con show --active | grep -i vpn | grep -v 'dummy' | awk '{print $3}'`
	if [ ! -z "$vpn_id" ]
	then
		nmcli connection modify "$vpn_id" ipv4.ignore-auto-dns true
		nmcli connection modify "$vpn_id" ipv4.dns 45.90.28.28,45.90.30.28
	fi
}


function open {
	if [ $# -eq 0 ]
	then
		echo "no arguments supplied"
	else
		#nohup $1 >/dev/null 2>&1 &
		nohup $1 >/dev/null 2>&1 &
		disown
	fi

}

function test_spacemacs {
	HOME=/mnt/11D3A2BE6C7F0676/emacs_test/spacemacs-test emacs >/dev/null 2>&1 &
	disown
}

function vanilla_emacs {
	  HOME=/mnt/11D3A2BE6C7F0676/emacs_test/vanilla_emacs emacs >/dev/null 2>&1 &
	  disown
}

function doom_emacs {
	  HOME=/mnt/11D3A2BE6C7F0676/emacs_test/emacs-dom emacs >/dev/null 2>&1 &
    disown
}


# Allow Composer to use almost as much RAM as Chrome.
# export COMPOSER_MEMORY_LIMIT=-1
source ${BASEDIR}/.bash_utils.sh
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources
# @variables
# man pages in color
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

# =================================================

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# tabtab source for electron-forge package
# uninstall by removing these lines or running `tabtab uninstall electron-forge`
[ -f /media/moh/11D3A2BE6C7F06761/tmp/clipmaster-fem-v2/node_modules/tabtab/.completions/electron-forge.bash ] && . /media/moh/11D3A2BE6C7F06761/tmp/clipmaster-fem-v2/node_modules/tabtab/.completions/electron-forge.bash
eval "$(pyenv init -)"
