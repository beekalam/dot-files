
function open_old {
	  if [ $# -eq 0 ]
	  then
		    echo "no arguments supplied"
	  else
		    #nohup $1 >/dev/null 2>&1 &
		    nohup $1 >/dev/null 2>&1 &
		    disown
	  fi

}


function open {
	  if [ $# -eq 0 ]
	  then
		    echo "no arguments supplied"
	  else
		    # disown
        # nohup $1 > /dev/null 2>&1 
        prog=$1
        shift
        nohup ${prog} ${@} > /media/ramdisk/open_log.log 2>&1 &
        disown
	  fi

}

function geany {
    nohup geany ${@} > /media/ramdisk/geany_log.log 2>&1 &
}

function test_spacemacs {
	  HOME=/mnt/11D3A2BE6C7F0676/emacs_test/spacemacs-test emacs >/dev/null 2>&1 &
	  disown
}

function doom_emacs {
	  HOME=/mnt/11D3A2BE6C7F0676/emacs_test/emacs-dom emacs >/dev/null 2>&1 &
    disown
}

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

function cp_file_path() {
    # copy full path of file
    # file is the first argument to the function
    p="$PWD/$1"
    echo $p | xsel -b
    echo "$p"
}

function list_running_services() {
    service --status-all
    # todo show a menu to use systemctl or service command
}

function list_interfaces (){
    ip -br addr show
}

function list_interfaces_traffic(){
    ip -s -h link
}

function example_bash_scrip_read_pipe_input(){
    while IFS= read line; do
        echo "Line: ${line}"
    done
}

function example_read_into_variable(){
    echo -n "input sth:"
    read input
    echo $input
}

function example_make_a_tmp_directory(){
    tmpdir="$(mktemp -d)"
    echo $tmpdir
}
function example_case(){

case "$(uname -s).$(uname -m)" in
    Linux.x86_64)
        hash=1596ed46efae091388ed6db626c31f14fc1b703e5a552b00a9e68419edb8172d
        path=r9rs4y6kd8jckzs22j6iknnyh9xhkzi5/nix-2.17.0-x86_64-linux.tar.xz
        system=x86_64-linux
        ;;
    Linux.i?86)
        hash=fb4aa6005e7f3908d9305706406503058c304a85c8776661d2000bee80d2b1e1
        path=3r1ql1ynp21jslcrmc9xxhgfna220g1n/nix-2.17.0-i686-linux.tar.xz
        system=i686-linux
        ;;
    Linux.aarch64)
        hash=dc81b40214affa8972cc32db9e0d2617785ceca2b6125ab9e1ddc9afb5b39443
        path=6d1xrn39dp0nv0g72k81z1gc4mv3wfv1/nix-2.17.0-aarch64-linux.tar.xz
        system=aarch64-linux
        ;;
    Linux.armv6l)
        hash=b91d7a3bd869b54dd623b06396a44dc946dea5ffc92c1bc57cb046f01a81dd9f
        path=qlqhfiv51ags6z9npzaapga6ksy32q5s/nix-2.17.0-armv6l-linux.tar.xz
        system=armv6l-linux
        ;;
    Linux.armv7l)
        hash=3043b397e81ff81902a07c30d61b098d3526d3a62052f234d98d408fc61bf497
        path=hk552g3d0xaw0bxmnabrj1smv5733ivx/nix-2.17.0-armv7l-linux.tar.xz
        system=armv7l-linux
        ;;
    Darwin.x86_64)
        hash=5f50a9496ef342d8289d55ec5504fc7888facfbf1c4c2cacdbc9f7941770aad7
        path=iz3ssssv5ihfswws7c84v2nzj2hzp43w/nix-2.17.0-x86_64-darwin.tar.xz
        system=x86_64-darwin
        ;;
    Darwin.arm64|Darwin.aarch64)
        hash=6637ee5eecf0b8656101650279fbb44df8f176c38c9a630fad393e22dedd3ee0
        path=2sahndf36pbzs7zs7nr0q36wndxzfi56/nix-2.17.0-aarch64-darwin.tar.xz
        system=aarch64-darwin
        ;;
    *) echo "sorry, there is no binary distribution of Nix for your platform";;
esac
echo $system 
}

function example_command(){
    if command -v curl > /dev/null 2>&1; then
        fetch() { curl --fail -L "$1" -o "$2"; }
    elif command -v wget > /dev/null 2>&1; then
        fetch() { wget "$1" -O "$2"; }
    else
        echo "you don't have wget or curl installed, which I need to download the binary tarball"
    fi
}

is_valid_ip4() {
    IP="$1"
    LEN=${#IP}

    if [ $LEN -lt 7 ] || [ $LEN -gt 15 ] ;  then
        return 1 # excepting an IPv4 compatible length
    fi

    I=0
    while [ $I -lt 4 ]; do
        N="${IP%%.*}"
        I=$(( 1 + $I ))
        if [ -n "${N#[1-2][0-9][0-9]}" ] && [ -n "${N#[1-9][0-9]}" ] && [ -n "${N#[0-9]}" ]; then
            return 2 # excepting 1, 2 or 3 digits
        elif [ $N -lt 0 ] || [ $N -gt 255 ]; then
            return 3 # excepting a number between 0 and 255
        fi
        if [ $I -eq 4 ]; then
            [ "$IP" != "$N" ] && return 4
        else
            [ "$IP" = "${IP#*.}" ] && return 5
            IP="${IP#*.}" # updating the checked string
        fi
    done
    return 0 # input was valid
}

function host_to_ip() {
    # echo $1

    url="https://cloudflare-dns.com/dns-query?name=$1&type=A"
    # echo $url
    ip=`curl -s -x http://192.168.1.190:8080 --max-time 15 --connect-timeout 15 --retry 3 -H 'accept: application/dns-json' $url | jq .Answer[-1].data | tr -d "\""`

    if [[ -n "$ip" ]]
    then
        is_valid_ip4 $ip
        RES=$?
        if [ $RES -eq 0 ]
        then
            echo $ip $domain
            # sleep 0.6
        fi
    fi
}

