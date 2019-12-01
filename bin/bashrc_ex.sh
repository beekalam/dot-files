if [ -f ~/bin/bash_aliases.sh ]; then
    . ~/bin/bash_aliases.sh
fi

export ACK_PAGER_COLOR="${PAGER:-less -R}"
export GOPATH=~/go

#remapping capslock to escape
# if [ -e /tmp/bashrc_capslock_remapped ]; then
# 	touch /tmp/bashrc_capslock_remapped
# else
# 	xmodmap ~/bin/xmodmap
# 	touch /tmp/bashrc_capslock_remapped
# fi
xmodmap ~/bin/xmodmap
#xmodmap -e "keycode 46 = Shift_Lock"

#todo backup sublime settings

# initialize git info
init_git () {
	git config --global user.email "beekalam@gmail.com"
	git config --global user.name "beekalam"
}
