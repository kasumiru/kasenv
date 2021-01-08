### aliases linux
### ~/.bashrc vbox vbox.hg


HISTTIMEFORMAT="%F %T: "
HISTSIZE=30000
HISTFILESIZE=30000
shopt -s histappend


[ -z "$PS1" ] && return # это нужно для rsync что бы он игнорировал все что ниже


# для отключения ctrl s - frozen console
stty -ixon

function pss() { sort=$1; if [[ -z $1 ]]; then sort=pmem; fi; ps -eo user,pid,ppid,%cpu,pmem,vsz,rss,etimes,command --sort $sort | grep -v '\['; ps -eo user,pid,ppid,%cpu,pmem,vsz,rss,etime,command | head -n1; }
PATH="$PATH:/usr/sbin"
function ping() { /usr/bin/ping `echo "$1" | sed 's|http://||' | sed 's|https://||' | sed 's/\/\S*//'`; }
alias ll="ls -lhAF --color"
#function ppid() { ps wlw $1; }
export SYSTEMD_PAGER=''
###
##Отключение прокрутки в systemctl status прокрутки
export SYSTEMD_PAGER=''
###
alias dns="vim /etc/bind/db.hg; systemctl restart bind9; systemctl status bind9"
#####################
####################function dnsrestart() { OLD=`cat /etc/bind/db.hg | grep Serial | awk '{print $1}'`; NEW=$(($OLD+1)); vim /etc/bind/db.hg ;sed -i "s|$OLD|$NEW|g" /etc/bind/db.hg; systemctl restart bind9; systemctl status bind9; }
#####################
#####################
alias dnsrestart='vim /etc/dnsmasq@eno1.conf && systemctl restart dnsmasq@eno1.service; systemctl status dnsmasq@eno1.service'
###
echo -ne "\e]0;root@$HOSTNAME.hg\a"
function ssh() { /usr/bin/ssh $@; source ~/.bashrc; }
##
function daysfrom() { echo $(($((`date +%s -d $(date +%Y%m%d)`-`date +%s -d $1`))/86400)); }
##
alias df="df -h | grep -v docker"
##
#function ppid() { ps wlwp $1; }
## Если имя вводимой команды является именем каталога, то осуществляется переход в этот каталог, как будто была введена команда cd имя_каталога.
shopt -s  autocd
#Незначительные ошибки в написании каталога команды cd будут исправляться: поменянные местами соседние символы, пропущенные, удвоенные символы. Если исправленный путь обнаружен - он будет выведен на экран, и будет выполнена команда cd. Работает только в интерактивном режиме.
shopt -s  cdspell
#Если опция выставлена, bash старается все строки многострочной команды рассматривать как одну для сохранения в истории. Это дает возможность просто редактировать многострочные команды. Смотрте также утилиту rlwrap.
shopt -s  cmdhist
###
function daysfrom() { echo $(($((`date +%s -d $(date +%Y%m%d)`-`date +%s -d $1`))/86400)) || echo $(($((`date +%s -d $(date +%Y%m%d)`-`date +%s -d \"\"`))/86400)); }
function todate() { echo $( date +%Y%m%d -d "$1 days" ); echo $( date +%Y.%m.%d -d "$1 days" );  }
#
#
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
function jscheck() { a=`/usr/bin/env python3 -mjson.tool ${1}`; err=$?; if [[ $err -eq 0 ]]; then echo "Json valid"; else echo ""; fi; }
function jsoncheck() { a=`/usr/bin/env python3 -mjson.tool ${1}`; err=$?; if [[ $err -eq 0 ]]; then echo "Json valid"; else echo ""; fi; }
#cd /srv/tg/downloader

alias a='mysql -e "describe pydb.downloader"; mysql -e "select * from pydb.downloader;"'
alias b='mysql -e "describe pydb.logger"; mysql -e "select * from pydb.logger;"'
alias c='mysql -e "describe pydb.chat_history"; mysql -e "select * from pydb.chat_history;"'

alias kas.mon.repl='while :; do echo `date`;  mysql   -e "SHOW SLAVE STATUS \G;"  | grep Seconds_Behind_Master; sleep 1; clear; done'
alias kas.mon.short_ps='mysql -e "select ID,USER,COMMAND,TIME,STATE from INFORMATION_SCHEMA.PROCESSLIST ORDER BY TIME;"'
alias kas.mon.full_ps='mysql -e "select * from INFORMATION_SCHEMA.PROCESSLIST ORDER BY TIME;"'
alias d1='mysql -e "delete from pydb.downloader where id < 1000"'
alias d2='mysql -e "delete from pydb.logger where chat_id = 1125408668"'


alias prod='cp /srv/tg/audiobot_production/audiobot_production.py{,-backup"`date`"}; cp /srv/tg/ImproveKasAudio/ImproveKasAudio.py /srv/tg/audiobot_production/audiobot_production.py'
alias 2ip="curl 2ip.ru"
function cheeck() { curl https://$1 -v 2>&1 | grep 'expire date'; }
alias ipa='echo `hostname -i`'

function unban() { if [ -z $1 ]; then echo "unban ip_address"; else fail2ban-client set sshd unbanip $1; fi; }
















###
PS1="\[\033[35m\]\t\[\033[m\]-\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\] \w\[\033[m\] # "
