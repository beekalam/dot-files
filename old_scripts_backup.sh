
alias autossh-server-aes256='autossh  -o "Compression yes" -o "Ciphers aes256-ctr" -D 1080 -N vps@144.76.227.83 -g -p 8880 -v'
alias autossh-server-aes128='autossh  -o "Compression yes" -o "Ciphers aes128-ctr" -D 1080 -N vps@144.76.227.83 -g -p 8880 -v'
alias autossh-server-chacha='autossh  -o "Compression no" -o "Ciphers chacha20-poly1305@openssh.com" -D 1080 -N vps@144.76.227.83 -g -p 8880 -v'
alias autossh-server-aes256-interval='autossh -M 20000 -o "ServerAliveInterval 1" -o "ServerAliveCountMax 10"  -o "Compression yes" -o "Ciphers aes256-ctr" -D 1080 -N vps@144.76.227.83 -g -p 8880 -v'

alias sshoceanv='autossh  -o "Compression no"   -D 1080 -N sshocean-beekalam@de02.sshocean.net -g  -v'
alias sshocean='autossh  -o "Compression no"   -D 1080 -N sshocean-beekalam@de02.sshocean.net -v'
alias sshocean80='autossh  -o "Compression no" -p 80  -D 1080 -N sshocean-beekalam@de02.sshocean.net -g  -v'
alias sshocean2='autossh  -o "Compression no" -o "Ciphers chacha20-poly1305@openssh.com" -D 1080 -N sshocean-beekalam@de02.sshocean.net -v'
alias sshocean3='autossh  -o "Compression no" -o "Ciphers chacha20-poly1305@openssh.com" -D 192.168.1.105:1080 -N sshocean-beekalam@deu2.ssh0.net -v'
alias sshocean31='autossh  -o "Compression no" -o "Ciphers aes128-ctr" -D 192.168.1.105:1080 -N sshocean-beekalam@deu2.ssh0.net -v'
alias sshocean32='autossh  -o "Compression yes" -o "Ciphers aes128-ctr" -D :1080 -N sshocean-beekalam@deu2.ssh0.net '
alias sshocean33='autossh  -o "Compression no" -o "Ciphers aes128-ctr" -D :1080 -N sshocean-beekalam@deu2.ssh0.net '
alias sshocean34='autossh  -o "Compression no" -o "Ciphers aes128-ctr" -D 1080 -N sshocean-beekalam@deu2.ssh0.net '
alias sshocean35='autossh  -o "Compression no" -o "Ciphers chacha20-poly1305@openssh.com" -D :1080 -N sshocean-beebeekalam@deu2.ssh0.net '
alias sshmaxde='autossh  -o "Compression yes" -o "Ciphers aes256-ctr" -D :1080 -N sshmax-beekalam@de-ssh.sshmax.xyz '

alias sshocean4='sshpass -p "jjj" autossh -M 20000 -o "ServerAliveInterval 1" -o "ServerAliveCountMax 10" -o "Compression no" -o "Ciphers chacha20-poly1305@openssh.com" -D 1080 -N sshocean-moh110@89.163.157.4 -v'

alias greenssh33='autossh  -o "Compression no" -o "Ciphers aes256-ctr" -D 1080 -p 80 -N greenssh-beekalam@de01.greenssh.xyz '

alias sshjantit='autossh  -o "Compression no" -o "Ciphers aes256-ctr" -D 1080 -N beekalam-vpnjantit.com@87.106.198.110 -v'
alias sshjantit2='autossh  -o "Compression yes" -o "Ciphers chacha20-poly1305@openssh.com" -D 192.168.1.105:1080 -N beekalam-vpnjantit.com@87.106.198.110 -v'
alias sshjantit-gr4='autossh  -o "Compression yes" -o "Ciphers aes256-ctr" -D 1080 -N beekalam-vpnjantit.com@87.106.198.110'
alias sshjantit-gr7='autossh  -o "Compression yes" -o "Ciphers aes256-ctr" -D 1080 -N beekalam-vpnjantit.com@92.243.93.246'

alias sshvps='autossh  -o "Compression yes" -o "Ciphers aes256-ctr" -D 1080 -N root@134.209.254.160 -v'
alias sshvps3='autossh  -o "Compression no" -o "Ciphers chacha20-poly1305@openssh.com" -D 1080 -N root@134.209.254.160 -v'
alias sshvps2='autossh  -o "Compression yes" -o "Ciphers aes256-ctr" -D 1080 -N root@server.beekalam.site -v'
alias sshpass-vpnjantit-luxamburg='sshpass -pjjj ssh -C -c aes128-ctr -N -D :1080 beekalam-vpnjantit.com@107.189.7.49 '
alias sshpass-vpnjantit-luxamburg2='sshpass -pjjj ssh -C -c aes128-ctr -N -D :1080 beekalam2-vpnjantit.com@107.189.7.49 '
alias sshpass-vpnjantit-gr6='sshpass -pjjj ssh  -C  -c aes128-ctr -N -D :1080 beekalam-vpnjantit.com@92.243.93.246 '
alias sshpass-vpnjantit-gr6-2='sshpass -pjjj ssh  -c aes256-ctr -N -D :1080 beekalam2-vpnjantit.com@92.243.93.246 '
alias sshpass-vpnjantit-gr5='sshpass -pjjj ssh -C -c aes256-ctr -N -D :1080 beekalam-vpnjantit.com@217.160.33.100 '
alias sshpass-vpnjantit-gr5-2='sshpass -pjjj ssh -C  -c aes256-ctr -N -D :1080 beekalam2-vpnjantit.com@217.160.33.100 '
alias sshpass-vpnjantit-gr5-3='sshpass -pjjj ssh -C  -c aes256-ctr -N -D :1080 beekalam3-vpnjantit.com@217.160.33.100 '
alias sshpass-vpnjantit-gr4='sshpass -pjjj ssh -C -c aes128-ctr -N -D :1080 beekalam-vpnjantit.com@87.106.198.110 '
alias sshpass-vpnjantit-gr3='sshpass -pjjj ssh -C -c aes256-ctr -N -D :1080 beekalam-vpnjantit.com@51.68.172.194 '
alias sshpass-vpnjantit-nl3='sshpass -pjjj ssh -C -c aes256-ctr -N -D :1080 beekalam-vpnjantit.com@195.123.217.74 '
alias sshpass-vpnjantit-bh1='sshpass -pjjj ssh -C -c aes256-ctr -N -D :1080 beekalam-vpnjantit.com@38.54.2.143 '
alias sshpass-vpnjantit-se2='sshpass -pjjj ssh -C -c aes256-ctr -N -D :1080 beekalam-vpnjantit.com@46.246.96.165 '
alias sshpass-vpnjantit-fin1='sshpass -pjjj ssh -C -c aes256-ctr -N -D :1080 beekalam-vpnjantit.com@77.91.103.148 '
alias sshpass-vpnjantit-ae4='sshpass -pjjj ssh -C -c aes128-ctr -N -D :1080 beekalam-vpnjantit.com@5.44.42.42 '
alias sshpass-sshocean-de2='sshpass  -pjjj ssh -c aes256-ctr -N -D :1080  sshocean-beekalam@deu2.ssh0.net '
alias sshpass-sshocean-de2-2='sshpass  -pjjj ssh -c aes256-ctr -N -D :1080  sshocean-beekalam2@deu2.ssh0.net '
alias sshpass-sshocean-de1='sshpass  -pjjj ssh -C -c aes256-ctr -N -D :1080  sshocean-beebeekalam@deu1.ssh0.net '
alias sshpass-sshmaxde='sshpass -pjjj ssh -c aes256-ctr -N -D :1080 sshmax-beekalam@de-ssh.sshmax.xyz  '
alias sshpass-sshmaxde2='sshpass -pjjj ssh -c aes256-ctr -N -D :1080 sshmax-beekalam@51.195.118.69 '
alias sshpass-sshmaxpl='sshpass -pjjj ssh -c aes256-ctr -N -D :1080 sshmax-beekalam@pl-ssh.sshmax.xyz '
alias sshpass-sshmaxfr='sshpass -pjjj ssh -c aes256-ctr -N -D :1080 sshmax-beekalam@fr-ssh.sshmax.xyz '
alias v2ray-gr6="/home/moh/.opt/v2ray-linux-64/v2ray -config=/home/moh/.opt/conf/v2ray-config-gr6.json"
alias v2ray-nl3="/home/moh/.opt/v2ray-linux-64/v2ray -config=/home/moh/.opt/conf/v2ray-config-nl3.json"


function kubernetesAliases() {
    alias kgp="kubectl get pods"
}


function laravelAliases() {
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
  alias pasanctum="composer require laravel/sanctum && php artisan vendor:publish --provider="Laravel\Sanctum\SanctumServiceProvider" && php artisan migrate"
}


function composerAliases () {
    alias cor="composer require "
    alias cola="composer create-project laravel/laravel"
    alias coda="composer dump-autoload"
    alias coinit='[[ ! -f composer.json ]] && echo "{
    \"name\": \"beekalam/php-demo\",
    \"authors\": [
        {
            \"name\": \"Mohammad Reza mansouri\",
            \"email\": \"beekalam@gmail.com\"
        }
    ],
    \"require\": {}
}" > composer.json && echo "created composer.json" '
}


function phpAliases () {

    alias punit="./vendor/bin/phpunit "
    alias setphp72="cd /opt && sudo rm /opt/lampp && sudo ln -s /opt/lampp-7.2 lampp"
    alias setphp74="cd /opt && sudo rm /opt/lampp && sudo ln -s /opt/lampp-7.4 lampp"
    alias setphp8="cd /opt && sudo rm /opt/lampp && sudo ln -s /opt/lampp-8 lampp"
    alias php_playground="php -S localhost:9090 -t /home/moh/code/php/php-console"
}

