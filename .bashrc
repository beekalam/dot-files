# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples


# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth:erasedups

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=50000
HISTFILESIZE=50000

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

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# ====================================
alias emacsnw="emacs -nw"
alias api="sudo apt install"
# ------------ protovpn --------------
alias proc="sudo protonvpn connect"
alias prod="sudo protonvpn disconnect"
alias pros="sudo protonvpn status"
alias proc.de="sudo protonvpn connect --cc DE -p udp"
alias proc.nl="sudo protonvpn connect --cc NL -p udp"
alias proc.uae="sudo protonvpn connect --cc AE -p udp"
alias pro.reset="prod && proc.nl && whatismyip"
#----------python,virtualenv--------
alias activate="source venv/bin/activate"
#-----------------------------------
alias bashrcreload="source ~/.bashrc"
alias bashrcedit="vim ~/.bashrc"
alias hs="history"
alias hsg="history | grep "
alias als="alias | grep "
alias xampp="sudo /opt/lampp/xampp"
alias xampp.manager="sudo /opt/lampp/manager-linux-x64.run"
alias cleanservices="sudo service anydesk stop && \
                                  sudo service snapd stop && \
				  sudo service libvirtd stop"
alias ..="cd .."
alias secondmonitoronly="xrandr --output VGA-0  --auto --output LVDS-0 --off"
alias firstmonitoronly="xrandr --output LVDS-0  --auto --output VGA-0 --off"
# clean up evolution services that is not needed in i3wm
alias evoclean="systemctl --user stop evolution-addressbook-factory &&  systemctl --user stop evolution-calendar-factory &&  systemctl --user stop evolution-source-registry"

# keyboard shortcuts for i3wm
alias setkeyboardlayouts="setxkbmap -option 'grp:win_space_toggle' 'us,ir'"
alias killminerfs="sudo pkill miner"

# alias myi3init="secondmonitoronly && evoclean && setkeyboardlayouts && cleanservices && xmodmap ~/.xmodmaprc && killminerfs && xset r rate 190 40"

# ---------- php laravel -----------
alias punit="./vendor/bin/phpunit "
alias setphp72="cd /opt && sudo rm /opt/lampp && sudo ln -s /opt/lampp-7.2 lampp"
alias setphp74="cd /opt && sudo rm /opt/lampp && sudo ln -s /opt/lampp-7.4 lampp"
#--------------------------------
#alias emrenice="sudo renice -20 -p `echo pgrep emacs`"
alias grepi="grep -i"
alias mongostart="sudo systemctl start mongod.service"
alias mongodstop="sudo systemctl stop mongod.service"
alias suai="sudo apt install -y"
alias sus="sudo systemctl "
alias susstart="sudo systemctl start"
alias susstop="sudo systemctl stop"
alias susstart="sudo systemctl start"
alias susstatus="sudo systemctl status"
alias whatismyip="curl ipinfo.io"
alias pingg="ping google.com"
#-- docker aliases
alias dk='docker'
alias dklc='docker ps -l'  # List last Docker container
alias dklcid='docker ps -l -q'  # List last Docker container ID
alias dklcip='docker inspect -f "{{.NetworkSettings.IPAddress}}" $(docker ps -l -q)'  # Get IP of last Docker container
alias dkps='docker ps'  # List running Docker containers
alias dkpsa='docker ps -a'  # List all Docker containers
alias dki='docker images'  # List Docker images
alias dkrmac='docker rm $(docker ps -a -q)'  # Delete all Docker containers
alias dkelc='docker exec -it $(dklcid) bash --login' # Enter last container (works with Docker 1.3 and above)
alias dkrmflast='docker rm -f $(dklcid)'
alias dkbash='dkelc'
alias dkex='docker exec -it ' # Useful to run any commands into container without leaving host
alias dkri='docker run --rm -i '
alias dkric='docker run --rm -i -v $PWD:/cwd -w /cwd '
alias dkrit='docker run --rm -it '
alias dkritc='docker run --rm -it -v $PWD:/cwd -w /cwd '
# lampp server shortcuts
PATH=/opt/lampp/bin:$PATH
PATH=/home/moh/.local/bin:$PATH
PATH=$PATH:/usr/local/go/bin
# ------------ functions ---------------

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
}

function mygnomeinit {
    xmodmap ~/.xmodmaprc

    #xset r rate 190 110
    gsettings set org.gnome.desktop.peripherals.keyboard repeat-interval  20
    gsettings set org.gnome.desktop.peripherals.keyboard delay 170

    #gsettings set org.gnome.desktop.peripherals.keyboard repeat-interval 15 
    #gsettings set org.gnome.desktop.peripherals.keyboard delay 130
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

source ~/.bash_utils

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
pwd
