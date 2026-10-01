
# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

function bashAliases() {
  # some more ls aliases
  alias ll='ls -alF'
  alias la='ls -A'
  alias l='ls -CF'
  alias llh='ls -lh'
  alias ..="cd .."
  alias ...="cd ../.."
  alias ....="cd ../../.."
  alias ch="cd ~/"
  alias grepi="grep -i"
  alias path="echo $PATH | tr ":" '\n'"
  alias xampp="sudo /opt/lampp/xampp"
  alias lsi="ls -lh | grep -i "
  #-- @pdfsam
  alias pdfsam='nohup java -jar /mnt/dd/opt/pdfsam-4.2.12-linux/pdfsam-basic-4.2.12.jar >/dev/null 2>&1 &'
  alias vmtouch_vscode='vmtouch -vt /usr/share/code && vmtouch -vt ~/.vscode/extensions'
  alias vmtouch_emacs='vmtouch -vt /usr/local/bin/emacs && vmtouch -vt ~/.emacs.d/layers/ vmtouch -vt ~/.emacs.d/eln-cache'
  # copy PWD to clipboard
  alias cpwd='echo "$PWD" | xsel --clipboard'
  alias cppath="pwd | xsel -b"
  alias coderenice='for pi in `pgrep "code"`; do sudo renice -n -20 $pi; done'
  # ---------- @emacs-------------
  alias emacsrenice='for pi in `pgrep "emacs"`; do sudo renice -n -20 $pi; done'
  alias notes="/home/moh/src/python/znotes/venv/bin/python /home/moh/src/python/znotes/Notes.py"
  alias cdd="cd /run/user/1000/gvfs/smb-share:server=192.168.1.110,share=d,user=moh"
  alias cde="cd /run/user/1000/gvfs/smb-share:server=192.168.1.110,share=e,user=moh"
  alias emacsnw="emacs -nw"
  # alias ec="emacsclient -n"
  # alias e="emacsclient -n . && wmctrl -a 'emacs'"
  alias mount_ramdisk="sudo mount -t tmpfs -o size=1G tmpfs /media/ramdisk/"
  alias umount_ramdisk="sudo umount /media/ramdisk"
  alias reload="source ~/.dot-files/.bash_aliases && source ~/.bash_aliases"
  alias bashrcedit="vim ~/.bashrc"
  alias hsg="history | grep "
  alias alg="alias | grep "
  alias psg="ps aux | grep -v grep | grep"
  # search processes by user
  alias psgu="ps aux | grep -v grep | grep -i -e USER -e"
  alias psmy="ps -fjH -u $USER"
  alias got="ps -aux | grep "
  alias chx="chmod +x"
  # hide/show gnome terminal tabs
  alias hidetabs="gsettings set org.gnome.Terminal.Legacy.Settings tab-policy 'never'"
  alias showtabs="gsettings set org.gnome.Terminal.Legacy.Settings tab-policy 'always'"
  #------------@apt------------------------
  alias api="sudo apt install "
  alias aps="sudo apt search "
  alias apr="sudo apt remove "
  #---------- @nmcli ------------------
  alias vpnup="nmcli connection up de-vpn"
  alias vpndown="nmcli connection down de-vpn"
  alias suai="sudo apt install -y"
  alias sus="sudo systemctl "
  alias susstart="sudo systemctl start"
  alias susstop="sudo systemctl stop"
  alias susstart="sudo systemctl start"
  alias susstatus="sudo systemctl status"
  alias whatismyip="dig +short myip.opendns.com @resolver1.opendns.com"
  alias whatismyip2="curl https://checkip.amazonaws.com/"
  alias ping8888="ping 8.8.8.8" # To check if I am online.
  alias taillog="tail -f /var/log/syslog"
  #-------------------
  alias r=". ranger"
  alias rmd="rm -rf ./* "
  alias subl="/opt/sublime_text/sublime_text"
  alias curlin="curl -k --insecure"
}



function npmAliases () {
    alias npmi="npm install "
    alias npmis="npm install --save "
    alias npmr="npm run  "
    alias npmrs="npm run start"
}

function dockerAliases () {
    #-- @docker aliases
    alias dk='docker'
    alias dklc='docker ps -l'  # List last Docker container
    alias dklcid='docker ps -l -q'  # List last Docker container ID
    alias dklcip='docker inspect -f "{{.NetworkSettings.IPAddress}}" $(docker ps -l -q)'  # Get IP of last Docker container
    alias dkps='docker ps'  # List running Docker containers
    alias dkpsa='docker ps -a'  # List all Docker containers
    alias dki='docker images'  # List Docker images
    alias dkir='docker image rm ' # Remove image
    alias dkrit='docker run -it '
    alias dkrmac='docker container rm -f $(docker container ls -aq)'  # Delete all Docker containers
    alias dkelc='docker exec -it $(dklcid) bash --login' # Enter last container (works with Docker 1.3 and above)
    alias dkrmflast='docker rm -f $(dklcid)'
    alias dkbash='dkelc'
    alias dkex='docker exec -it ' # Useful to run any commands into container without leaving host
    alias dkri='docker run --rm -i '
    alias dkric='docker run --rm -i -v $PWD:/cwd -w /cwd '
    alias dkrit='docker run --rm -it '
    alias dkr="docker container rm "
    alias dkrf="docker container rm -f "
    alias dkritc='docker run --rm -it -v $PWD:/cwd -w /cwd '
    alias dk_pg_playground='docker run --rm --name pg13 -e POSTGRES_PASSWORD=123 -d postgres:13.4 && docker exec -it pg13 bash --login'
    alias dk_mongo_playground='docker run -d --rm --name some-mongo -p 27017:27017 -e MONGO_INITDB_ROOT_USERNAME=root -e MONGO_INITDB_ROOT_PASSWORD=password mongo:latest'
    alias dk_mongo_shell='docker container exec -it some-mongo bash'
 #   alias dk_opengrok='docker run -d -v .:/opengrok/src -p 8080:8080 opengrok/docker:latest && browse "http://localhost:8080"'
    alias dk_opengrok='docker run -it --mount type=bind,src=./,dst=/opengrok/src -p 8080:8080 opengrok/docker:latest && browse "http://localhost:8080"'
    alias dk_keycloak='docker run -p 8080:8080 -e KEYCLOAK_ADMIN=admin -e KEYCLOAK_ADMIN_PASSWORD=admin quay.io/keycloak/keycloak:19.0.1 start-dev'
    #-- @docker-compose
    alias dc='docker compose'
    alias dcu='docker compose up '
    alias dcd='docker compose down '
    alias dcr='docker compose run '
    alias dcrr='docker compose run --rm   '
    alias dcl='docker compose logs '
}

function goAliases () {
    alias grm="go run main.go"
}

function gitAliases () {
    alias gitinit='git init && git add . && git commit -m "initial commit" && git log'
    alias git-safe="git config --global --add safe.directory \"$PWD\""
}


function pythonAliases () {
    #----------@python,virtualenv--------
    alias activate="source venv/bin/activate || source .venv/bin/activate"
}

#-----------------------------------
alias xampp.manager="sudo /opt/lampp/manager-linux-x64.run"
alias cleanservices="sudo service anydesk stop && \
                                  sudo service snapd stop && \
				  sudo service libvirtd stop"
alias secondmonitoronly="xrandr --output VGA-0  --auto --output LVDS-0 --off"
alias firstmonitoronly="xrandr --output LVDS-0  --auto --output VGA-0 --off"
# clean up evolution services that is not needed in i3wm
alias evoclean="systemctl --user stop evolution-addressbook-factory &&  systemctl --user stop evolution-calendar-factory &&  systemctl --user stop evolution-source-registry"

# keyboard shortcuts for i3wm
alias setkeyboardlayouts="setxkbmap -option 'grp:win_space_toggle' 'us,ir'"
alias killminerfs="sudo pkill miner"
alias import_chrome_bookmarks_to_qutebrowser="python3.8 /usr/share/qutebrowser/scripts/importer.py chromium ~/.config/google-chrome/Default >> ~/.config/qutebrowser/quickmarks"

# alias myi3init="secondmonitoronly && evoclean && setkeyboardlayouts && cleanservices && xmodmap ~/.xmodmaprc && killminerfs && xset r rate 190 40"
# copy current path to clipboard

alias mongostart="sudo systemctl start mongod.service"
alias mongodstop="sudo systemctl stop mongod.service"

alias wg-up='sudo wg-quick up wg0'
alias wg-down='sudo wg-quick down wg0'





bashAliases
npmAliases
goAliases
dockerAliases
gitAliases
pythonAliases
alias code_proxy="code --proxy-server=\"http=localhost:8118;https=localhost:8118\" --proxy-bypass-list=\"localhost;127.0.0.1;\""

alias bbi="rlwrap bb --init /home/moh/bbinit.clj"
alias pdate='curl "https://www.time.ir" -o - -s | htmlxpath "/html/body/div/form/section/div[1]/div/div[1]/div/div/div/div[2]/div/div[1]/div/div[2]/span/text()"'
# alias jd="java -jar /home/moh/.opt/jd-gui-1.6.6.jar"
alias jdt="java -jar /mnt/dd/src/java/libraries/jdt-2.8/jdt2.80.6446-release/lib/jdt-cli.jar "
alias mvn2='/home/moh/.opt/idea-IU-222.3739.54/plugins/maven/lib/maven3/bin/mvn'
alias toggle-shecan='sudo /home/moh/bin/bb /home/moh/.dot-files/bin/toggle-shecan'
alias obsidian-proxified='open obsidian --proxy-server=localhost:8118'
alias java-app='java -jar /mnt/dd/src/java/java-playground/target/demo-1.0-SNAPSHOT-shaded.jar'
alias noip="cd /home/moh/.opt/noip/ && ./noip2 -c /home/moh/.opt/noip/no-ip2.conf "
# alias extract_ssh_log_ips="cat /home/moh/ssh_logs.log | awk '{print $10; printf "\n"}'  | filter-domain  | sort | uniq > ssh_log_domains.log"
alias my-timer_10sbreak="my-timer -d 10m -l -w 11  -m '10s break'"
alias kmonad-start="sudo /opt/kmonad/kmonad /opt/kmonad/km.kbd"
alias kmonad-debug="sudo /opt/kmonad/kmonad /opt/kmonad/km.kbd -l debug"
alias jd-cli="/home/moh/.opt/jd-cli-1.2.0-dist/jd-cli"

alias kss="sudo ls && /home/moh/.dot-files/bin/kmonad-start.sh"
alias pyc="/opt/jetbrains/pycharm-2024.3.3/bin/pycharm.sh"

function run {
    if  test -f "./taskfile"
    then
        ./taskfile  $*
    elif  test -f "./Taskfile"
    then
         ./Taskfile $* 
    else
        echo "taskfile does not exist."
    fi
}




lja[0]="/home/moh/Downloads"
lja[1]="/mnt/dd"
lja[2]="/mnt/dd/notes/zettle_notes"

ps1() { ps -ef | grep "$1" |grep -v grep| awk '{print $2}' | xargs pwd; }

lj () {
    # for d in ${lja[@]}
    # do
    #     echo  "$d "
    # done
    ljs=( `cat /home/moh/.lj` )
    for line in "${ljs[@]}"
    do
        echo line: $line
    done
}

lj_ () {
    # Accept 1 argument that's a string key, and perform a different
    # "cd" operation for each key.
    case "$1" in
        downloads)
            cd $HOME/Downloads
            ;;
        mounts)
            cd /mnt/dd/
            ;;
        notes)
            cd /mnt/dd/notes/zettle_notes
            ;;
        code)
            cd $HOME/code
            ;;
        *)
            # The supplied argument was not one of the supported keys
            echo "lj: unknown key '$1'"
            return 1
            ;;
    esac
    # Helpfully print the current directory name to indicate where you are
    pwd
}

# Set up tab completion
complete -W "downloads mounts notes code" lj
