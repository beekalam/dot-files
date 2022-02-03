
# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias notes="/home/moh/src/python/znotes/venv/bin/python /home/moh/src/python/znotes/Notes.py"
alias cdd="cd /run/user/1000/gvfs/smb-share:server=192.168.1.110,share=d,user=moh"
alias cde="cd /run/user/1000/gvfs/smb-share:server=192.168.1.110,share=e,user=moh"
alias cpwd='echo "$PWD" | xsel --clipboard'
alias emacsnw="emacs -nw"
alias api="sudo apt install"
# ------------ @git  --------------
alias gitinit='git init && git add . && git commit -m "initial commit" && git log'
# ------------ @protovpn --------------
alias proc="sudo protonvpn connect"
alias prod="sudo protonvpn disconnect"
alias pros="sudo protonvpn status"
alias proc.de="sudo protonvpn connect --cc DE -p udp"
alias proc.nl="sudo protonvpn connect --cc NL -p udp"
alias proc.uae="sudo protonvpn connect --cc AE -p udp"
alias pro.reset="prod && proc.nl && whatismyip"
#---------- @nmcli ------------------
alias vpnup="nmcli connection up de-vpn"
alias vpndown="nmcli connection down de-vpn"
#-----------------------------------
#----------@python,virtualenv--------
alias activate="source venv/bin/activate"
#------------@bash--------------------
alias mount_ramdisk="sudo mount -t tmpfs -o size=1G tmpfs /media/ramdisk/"
alias bashrcreload="source ~/.bashrc"
alias aliasreload="source ~/.bash_aliases"
alias bashrcedit="vim ~/.bashrc"
alias hs="history"
alias hsg="history | grep "
alias als="alias | grep "
alias hidetabs="gsettings set org.gnome.Terminal.Legacy.Settings tab-policy 'never'"
alias showtabs="gsettings set org.gnome.Terminal.Legacy.Settings tab-policy 'always'"
alias cppath="pwd | xsel -b"
alias xampp="sudo /opt/lampp/xampp"
alias xampp.manager="sudo /opt/lampp/manager-linux-x64.run"
alias cleanservices="sudo service anydesk stop && \
                                  sudo service snapd stop && \
				  sudo service libvirtd stop"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias cdsrc="cd /media/moh/11D3A2BE6C7F0676/src"
alias got="ps -aux | grep "

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
alias cpwd='echo "$PWD" | xsel --clipboard'
alias coderenice='for pi in `pgrep "code"`; do sudo renice -n -20 $pi; done'

# ---------- @php ---------------
alias punit="./vendor/bin/phpunit "
alias setphp72="cd /opt && sudo rm /opt/lampp && sudo ln -s /opt/lampp-7.2 lampp"
alias setphp74="cd /opt && sudo rm /opt/lampp && sudo ln -s /opt/lampp-7.4 lampp"
alias setphp8="cd /opt && sudo rm /opt/lampp && sudo ln -s /opt/lampp-8 lampp"
# -------- @laravel ----------------
alias pac="php artisan cache:clear && php artisan config:clear && php artisan route:clear && php artisan view:clear &&  php artisan config:cache"
alias par="php artisan "
alias pars="php artisan serve"
alias parm="php artisan migrate"
alias parmm="php artisan make:model "
alias parmmi="php artisan make:migration "
alias parmf="php artisan make:factory    "
alias parmfs="php artisan migrate:fresh --seed"
alias parmt="php artisan make:test "
alias parmc="php artisan make:controller"
alias pat="php artisan tinker"
alias labreeze="composer require laravel/breeze --dev && php artisan breeze:install && npm install && npm run dev && php artisan migrate"
alias pasanctum="composer require laravel/sanctum && php artisan vendor:publish --provider="Laravel\Sanctum\SanctumServiceProvider" && php artisan migrate"
# ----------- @composer ----------
alias cor="composer require "
alias cola="composer create-project laravel/laravel "
alias coda="composer dump-autoload"
#------------- @go ------------------
alias grm="go run main.go"
#-------------@npm-------------------
alias npmi="npm install "
alias npmr="npm run  "

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
alias dkritc='docker run --rm -it -v $PWD:/cwd -w /cwd '
#-- @docker-compose
alias dc='docker-compose'
alias dcu='docker-compose up '
alias dcr='docker-compose run '
alias dcrr='docker-compose run --rm   '



alias vmtouch_vscode='vmtouch -vt /usr/share/code'
alias vmtouch_emacs='vmtouch -vt ~/.emacs.d'
