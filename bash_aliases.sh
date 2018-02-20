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

alias ssh20='ssh moh@192.168.1.20'