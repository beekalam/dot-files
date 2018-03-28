alias opengrok_update='/home/moh/opengrok-1.1-rc20/bin/OpenGrok update'
alias opengrok_index='/home/moh/opengrok-1.1-rc20/bin/OpenGrok index'
alias phplicenseserver='nohup /home/moh/dvt-jb_licsrv.linux.amd64 > /dev/null 2>&1 &'
alias sourcebashrc='source ~/.bashrc'
alias ..='cd ..'
alias cd..='cd ..'

#vim -u bypasses vimrc '/usr/share/vim/vimrc' initializations
alias vim='vim -u <(echo source /usr/share/vim/vimrc; cat ~/bin/vimrc)'
alias svim='vim -u <(echo source /usr/share/vim/vimrc; cat /home/moh/bin/vimrc)'

alias aliasedit='vim ~/bin/bash_aliases.sh'
alias aliasreload='source ~/bin/bash_aliases.sh'
alias gits='git status'
alias gitl='git log'
alias n.='gnome-open .'

<<<<<<< d4719eb02b8c8b750697a5719c09361d33729e6d
alias ssh20='ssh moh@192.168.1.20'
alias ogd='cd /home/moh/opengrok_dirs/SRC_ROOT'
=======
alias whatismytorip="torify whatismyip"

alias ssh20='ssh moh@192.168.1.20'
alias phplicenseserver2="/opt/phpstorm2017/Crack/license_server/linux/dvt-jb_licsrv.linux.amd64"
alias jadex="nohup /home/moh/Documents/android_apk/jadx-0.6.1/bin/jadx-gui 2>&1 &"
alias cdfana="cd /home/moh/src/fana"
alias cdsda2="cd /media/moh/sda2"
alias mac-random="sudo /home/moh/bin/changemac wlp3s0"
>>>>>>> change-mac and bash-aliases
