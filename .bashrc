BASEDIR="$(dirname $(readlink -f ${BASH_SOURCE[0]}))"

PATH=$PATH:~/.dot-files/bin/

. ~/.dot-files/z/z.sh

# lampp server shortcuts
PATH=$PATH:/opt/lampp/bin
# pip3 virtualenv
PATH=$PATH:~/.local/bin


# init go path if it is installed
if [[ -d '/usr/local/go' ]]
then
    PATH=$PATH:/usr/local/go/bin
    export GOPATH=$HOME/go
    export PATH=$PATH:$GOPATH/bin
fi

#zig
export PATH=$PATH:/opt/zig-linux-x86_64-0.9.1
export PATH=$PATH:/opt/zls

# Allow Composer to use almost as much RAM as Chrome.
# export COMPOSER_MEMORY_LIMIT=-1
source ${BASEDIR}/.bash_utils.sh
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources
# @variables
# define preferred tools
export EDITOR=vim
export PAGER=less

# man pages in color
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

# =================================================

if [ -f ~/.dot-files/.bash_aliases ]; then
    . ~/.dot-files/.bash_aliases
fi
