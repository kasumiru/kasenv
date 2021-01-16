[ -z "$PS1" ] && return # это нужно для rsync что бы он игнорировал все что ниже

PATH="$PATH:/usr/sbin"

HISTTIMEFORMAT="%F %T: "
HISTSIZE=30000
HISTFILESIZE=30000
shopt -s histappend
stty -ixon              # для отключения ctrl s - frozen console
export SYSTEMD_PAGER='' ##Отключение прокрутки в systemctl status прокрутки
echo -ne "\e]0;root@$HOSTNAME.hg\a"


shopt -s  autocd  # Если имя вводимой команды является именем каталога, то осуществляется переход в этот каталог, как будто была введена команда cd имя_каталога.
shopt -s  cdspell # Незначительные ошибки в написании каталога команды cd будут исправляться: поменянные местами соседние символы, пропущенные, удвоенные символы. Если исправленный путь обнаружен - он будет выведен на экран, и будет выполнена команда cd. Работает только в интерактивном режиме.
shopt -s  cmdhist # Если опция выставлена, bash старается все строки многострочной команды рассматривать как одну для сохранения в истории. Это дает возможность просто редактировать многострочные команды. Смотрте также утилиту rlwrap.


alias 2ip="curl 2ip.ru"
alias df="df -h | grep -v docker"
alias dnsrestart='vim /etc/dnsmasq@eno1.conf && systemctl restart dnsmasq@eno1.service; systemctl status dnsmasq@eno1.service'
#function dnsrestart() { OLD=`cat /etc/bind/db.hg | grep Serial | awk '{print $1}'`; NEW=$(($OLD+1)); vim /etc/bind/db.hg ;sed -i "s|$OLD|$NEW|g" /etc/bind/db.hg; systemctl restart bind9; systemctl status bind9; }
alias dns="vim /etc/bind/db.hg; systemctl restart bind9; systemctl status bind9"
alias ll="ls -lhAF --color"
alias l="ls -lnF --color"
alias docker_rmold='docker rm $(docker ps -q -f status=exited)'


youtube() {
    set -x
    #echo $1 | grep '\-' | wc -l
    if [[ `echo $1 | grep '\-' | wc -l` -lt 1 ]]; then
        /usr/local/bin/youtube-dl   -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/bestvideo+bestaudio' --merge-output-format mp4 "$1"
    else
        /usr/local/bin/youtube-dl "$@"
    fi
    set +x
}

function pss() { sort=$1; if [[ -z $1 ]]; then sort=pmem; fi; ps -eo user,pid,ppid,%cpu,pmem,vsz,rss,etimes,command --sort $sort | grep -v '\['; ps -eo user,pid,ppid,%cpu,pmem,vsz,rss,etime,command | head -n1; }
function jscheck() { a=`/usr/bin/env python3 -mjson.tool ${1}`; err=$?; if [[ $err -eq 0 ]]; then echo "Json valid"; else echo ""; fi; }
function jsoncheck() { a=`/usr/bin/env python3 -mjson.tool ${1}`; err=$?; if [[ $err -eq 0 ]]; then echo "Json valid"; else echo ""; fi; }
function variable() { tr '\0' '\n' < /proc/$1/environ; }
function cheeck() { curl https://$1 -v 2>&1 | grep 'expire date'; }
function unban() { if [ -z $1 ]; then echo "unban ip_address"; else fail2ban-client set sshd unbanip $1; fi; }
function duh() { du -hs ${1}* | sort -h 2>/dev/null; }
function daysfrom() { echo $(($((`date +%s -d $(date +%Y%m%d)`-`date +%s -d $1`))/86400)) || echo $(($((`date +%s -d $(date +%Y%m%d)`-`date +%s -d \"\"`))/86400)); }
function todate() { echo $( date +%Y%m%d -d "$1 days" ); echo $( date +%Y.%m.%d -d "$1 days" );  }
function ssh() { /usr/bin/ssh $@; source ~/.bashrc; }
function daysfrom() { echo $(($((`date +%s -d $(date +%Y%m%d)`-`date +%s -d $1`))/86400)); }
function ppid() { ps wlwp $1; }
function ping() { /usr/bin/ping `echo "$1" | sed 's|http://||' | sed 's|https://||' | sed 's/\/\S*//'`; }

# download throught youtube-dl
function d() {
    set -x
    #if [[ -z $2 ]]; then
    #    di=`pwd`;
    #    cd /external/youtube;
    #fi;
    di=`pwd`;
    #cd $2
    setsid youtube-dl --merge-output-format mp4 -f "bestvideo+bestaudio[ext=m4a]/best" --embed-thumbnail --add-metadata $1
    # 2>&1 > /dev/null;
    #if [[ -z $2 ]]; then
    #    cd $di;
    #fi;
    cd $di
    set +x
}

# send to telegram throught docker
function sf() {
    # phone MegaFon sonyericsson
    mkdir -p "/tmp/sendvideo";
    s=`echo $1 | sed 's/ /_/g'`;
    rsync -avP "$1" /tmp/sendvideo/"$s";
    docker run -ti --rm -v \
        /srv/telegram/0154:/home/telegramd/.telegram-cli/ -v \
        /tmp/sendvideo:/mnt:rw \
        ubidots/telegram-cli /bin/telegram-cli -W -e \
        "send_video Kasumiru /mnt/$s";
    rm /tmp/sendvideo/"$s";
}

PS4=' $(date +\%D.\%T.\%-3N)::`basename $0` [$LINENO]: '

if [[ -f ~/.bashrc.kas.linux.custom ]]; then source ~/.bashrc.kas.linux.custom; fi

###
PS1="\[\033[35m\]\t\[\033[m\]-\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\] \w\[\033[m\] # "

