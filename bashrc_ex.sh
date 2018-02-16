

if [ -f ~/bin/bash_aliases.sh ]; then
    . ~/bin/bash_aliases.sh
fi

export ACK_PAGER_COLOR="${PAGER:-less -R}"
export GOPATH=~/go

#remapping capslock to escape
xmodmap ~/bin/xmodmap