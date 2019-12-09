function mkcd {
    mkdir $1
    cd $1
}


function notify_from_cron {
    XDG_RUNTIME_DIR=/run/user/$(id -u) notify-send  "$1"
}

function alert_on_low_battery {
    state=`upower -i $(upower -e | grep 'BAT') | grep state | cut -d':' -f2 | sed 's/\ //g'`
    percent=`upower -i $(upower -e | grep 'BAT') | grep percentage | cut -d':' -f2 | sed 's/\ //g' | sed 's/%//g'`
    if [ $state = 'discharging' ]
    then
	      if [ $percent -lt 20 ]
	      then
	          notify_from_cron "low battery"
	      fi
    fi
}

function update_vs_code {
    wget https://vscode-update.azurewebsites.net/latest/linux-deb-x64/stable -O /tmp/code_latest_amd64.deb
    sudo dpkg -i /tmp/code_latest_amd64.deb
}

function pgrep_renice {
    process=$1
    niceness=$2
    
    while IFS= read -r pid
    do
        echo $pid
        sudo renice -n $niceness -p $pid
    done < <(pgrep $process)
}


# toggles xdebug on or off

xdebug(){
    iniFileLocation="/opt/lampp/etc/php.ini"
    currentLine=`cat $iniFileLocation | grep xdebug.so`
    if [[ $currentLine =~ ^#zend_extension ]]
    then
        sudo sed -i -e 's/^#zend_extension/zend_extension/g' $iniFileLocation
        echo "xdebug is now active"
    else
        sudo sed -i -e 's/^zend_extension/#zend_extension/g' $iniFileLocation
        echo "xdebug is now inactive"
    fi
}


