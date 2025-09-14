
function host-to-ip(){
    curl "https://ipapi.com/ip_api.php?ip=$1" \
         -H 'authority: ipapi.com' \
         -H 'accept: application/json, text/javascript, */*; q=0.01' \
         -H 'accept-language: en-US,en;q=0.9,fa;q=0.8,de;q=0.7' \
         -H 'referer: https://ipapi.com/' \
         -H 'sec-ch-ua: "Not_A Brand";v="8", "Chromium";v="120", "Google Chrome";v="120"' \
         -H 'sec-ch-ua-mobile: ?0' \
         -H 'sec-ch-ua-platform: "Linux"' \
         -H 'sec-fetch-dest: empty' \
         -H 'sec-fetch-mode: cors' \
         -H 'sec-fetch-site: same-origin' \
         -H 'user-agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36' \
         -H 'x-requested-with: XMLHttpRequest' \
         -s \
         --compressed | jq .ip
}

function is-banned() {
    r=`dig +short @8.8.8.8 $1`
    if [[ "$r" = "10.10.34.35" ]]
    then
        echo "yes"
    else
        echo "no"
    fi
}

function cache-host() {
    hostname=$1
    ib=`is-banned $hostname`
    if [[ "$ib" = "yes" ]]
    then
        ip=`host-to-ip $hostname | tr -d "\"" | tr -d "\n"`
        # echo "$ip $hostname"
        echo "$ip $hostname" | sudo tee --append /etc/hosts
    else
        ip=`dig +short @8.8.8.8 $1`
        # echo "$ip $hostname"
        echo "$ip $hostname" | sudo tee --append /etc/hosts
    fi
}

function print-host-line() {
    hostname=$1
    ib=`is-banned $hostname`
    if [[ "$ib" = "yes" ]]
    then
        ip=`host-to-ip $hostname | tr -d "\"" | tr -d "\n"`
        # echo "$ip $hostname"
        echo "$ip $hostname" | xsel -b
        echo "$ip $hostname"
    else
        ip=`dig +short @8.8.8.8 $1`
        # echo "$ip $hostname"
        echo "$ip $hostname" | xsel -b
        echo "$ip $hostname"
    fi
}

function sync_run_server() {
   mkdir -p /tmp/xx
   cd /tmp/xx
   rm -f ./run_server
   scp rayka@192.168.1.130:/home/rayka/pacs-api/dist/pacs-api-deploy/run_server .
	 ssh rayka@192.168.3.13  -o "ProxyCommand=nc -X 5 -x 192.168.1.170:1089 %h %p" -f "rm /usr/local/pacs-api/run_server"
	 rsync -a -v -r -I --progress --compress --compress-level=9  ./run_server rayka@192.168.3.13:/usr/local/pacs-api/run_server
}

# asks for confirmation  running the next command
# eg:
#   gd() {
#     confirm "Force delete $(curbranch) on both your local machine AND origin?" && git push origin --delete $1 && gb -D $1
#   }
confirm() {
    read -r -p "${1:-Are you sure? [y/N]} " response
    case "$response" in
        [yY][eE][sS]|[yY])
            true
            ;;
        *)
            false
            ;;
    esac
}

fe() {
    # IFS=$'\n' files=($(fzf-tmux --query="$1" --multi --select-1 --exit-0))
    # [[ -n "$files" ]] && ${EDITOR:-vim} "${files[@]}"

    IFS=$'\n' files=($(fzf-tmux --query="$1" --multi --select-1 --exit-0))
    [[ -n "$files" ]] && emacsclient -n "${files[@]}"
}

ej() {
    IFS=$'\n' file=( $(emacsclient -e "(mapconcat #'identity recentf-list \" \")" | sed 's/\s/\n/g'  | grep -e "^/"  -e "^~" | fzf ))
    [[ -n "$file" ]] && emacsclient -n "$file"
}

# using ripgrep combined with preview
# find-in-file - usage: fif <searchTerm>
fif() {
    if [ ! "$#" -gt 0 ]; then echo "Need a string to search for!"; return 1; fi
    rg --files-with-matches --no-messages "$1" | fzf --preview "highlight -O ansi -l {} 2> /dev/null | rg --colors 'match:bg:yellow' --ignore-case --pretty --context 10 '$1' || rg --ignore-case --pretty --context 10 '$1' {}"
}

unalias z
z() {
    if [[ -z "$*" ]]; then
        cd "$(_z -l 2>&1 | fzf +s --tac | sed 's/^[0-9,.]* *//')"
    else
        _last_z_args="$@"
        _z "$@"
    fi
}

zz() {
    cd "$(_z -l 2>&1 | sed 's/^[0-9,.]* *//' | fzf -q "$_last_z_args")"
}

# fh - repeat history
fh() {
    selected=$( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed -E 's/ *[0-9]*\*? *//' | sed -E 's/\\/\\\\/g')
    # echo "selected: $selected"
    history -s "$selected"
    eval "$selected"
}

# fkill - kill processes - list only the ones you can kill. Modified the earlier script.
fkill() {
    local pid
    if [ "$UID" != "0" ]; then
        pid=$(ps -f -u $UID | sed 1d | fzf -m | awk '{print $2}')
    else
        pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')
    fi

    if [ "x$pid" != "x" ]
    then
        echo $pid | xargs kill -${1:-9}
    fi
}

# using ripgrep combined with preview to search in notes
fin() {
    if [ ! "$#" -gt 0 ]; then echo "Need a string to search for!"; return 1; fi
    res=`rg --files-with-matches --no-messages "$1" "/mnt/dd/notes/zettle_notes" | fzf --preview "highlight -O ansi -l {} 2> /dev/null | rg --colors 'match:bg:yellow' --ignore-case --pretty --context 10 '$1' || rg --ignore-case --pretty --context 10 '$1' {}"`
    file_name=`echo "$res" | rev | cut -d"/" -f1 | rev`
    echo "$file_name"
    # echo /opt/obsidian/Obsidian-1.5.8.AppImage  'obsidian://open?vault=zettle_notes&file='"$file_name'"
    note_cmd=/opt/obsidian/Obsidian-1.5.8.AppImage  "'obsidian://open?vault=zettle_notes&file=""$file_name""'"
    note_cmd='"'"$note_cmd"'"'
    echo note_cmd
    su moh -c "$note_cmd"
}

# Same as above, but with previews and works correctly with man pages in different sections.
function fman() {
    man -k . | fzf -q "$1" --prompt='man> '  --preview $'echo {} | tr -d \'()\' | awk \'{printf "%s ", $2} {print $1}\' | xargs -r man' | tr -d '()' | awk '{printf "%s ", $2} {print $1}' | xargs -r man
}

