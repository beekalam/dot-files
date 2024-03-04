#!/bin/bash

be() {
    if [ -r ~/.bookmarks ]
    then
	      strip-echo ~/.bookmarks
    fi
}

bp() {
    pwd >> ~/.bookmarks
}

unalias bj 2> /dev/null

bj() {
    local dest_dir=$(be | fzf )
    if [[ $dest_dir != '' ]]; then
        cd "$dest_dir"
    fi
}

export -f bj > /dev/null
