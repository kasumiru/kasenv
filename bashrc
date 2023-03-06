[ -z "$PS1" ] && return # это нужно для rsync что бы он игнорировал все что ниже

PATH="$PATH:/usr/sbin"

HISTTIMEFORMAT="%F %T: "
HISTSIZE=30000
HISTFILESIZE=30000
shopt -s histappend
stty -ixon              # для отключения ctrl s - frozen console. отключает фризы bash shell по нажатию ctrl+s и ctrl+q т.е.: Исторически C-s и C-q использовались для передачи управляющих кодов XOFF и XON между двумя системами. В системе на базе терминала эти управляющие коды используются для приостановки процессов, передающих данные на терминал. ссылка к примеру тут https://translated.turbopages.org/proxy_u/en-ru.ru.37b29021-63ef70f6-a27d8d9f-74722d776562/https/www.baeldung.com/linux/change-incremental-searching-direction-shell
export SYSTEMD_PAGER='' ##Отключение прокрутки в systemctl status прокрутки
echo -ne "\e]0;root@$HOSTNAME.hg\a"


shopt -s  autocd  # Если имя вводимой команды является именем каталога, то осуществляется переход в этот каталог, как будто была введена команда cd имя_каталога.
shopt -s  cdspell # Незначительные ошибки в написании каталога команды cd будут исправляться: поменянные местами соседние символы, пропущенные, удвоенные символы. Если исправленный путь обнаружен - он будет выведен на экран, и будет выполнена команда cd. Работает только в интерактивном режиме.
shopt -s  cmdhist # Если опция выставлена, bash старается все строки многострочной команды рассматривать как одну для сохранения в истории. Это дает возможность просто редактировать многострочные команды. Смотрте также утилиту rlwrap.


alias 2ip="curl 2ip.ru"
function df() { /usr/bin/df "$@" | grep -v docker; }
alias dnsrestart='vim /etc/dnsmasq@eno1.conf && systemctl restart dnsmasq@eno1.service; systemctl status dnsmasq@eno1.service'
#function dnsrestart() { OLD=`cat /etc/bind/db.hg | grep Serial | awk '{print $1}'`; NEW=$(($OLD+1)); vim /etc/bind/db.hg ;sed -i "s|$OLD|$NEW|g" /etc/bind/db.hg; systemctl restart bind9; systemctl status bind9; }
#alias dns="vim /etc/bind/db.hg; systemctl restart bind9; systemctl status bind9"
#alias ll="ls -lhAF --color"
#alias ll='ls -lhAF --color=auto --time-style="+%Y.%m.%d.%H.%M" --color'
alias ll='ls -lhAF --color=auto --time-style="+%Y.%m.%d %H:%M" --color'
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
#function ppid() { ps wlwp $1; }
function ping() { /usr/bin/ping `echo "$@" | sed 's|http://||' | sed 's|https://||' | sed 's/\/\S*//'`; }


function ppid() {
    a=$1
    hat=`ps -eo pid,ppid,user,%cpu,pmem,vsz,rss,etimes,command | head -n1`
    function string() {
        s=$1
        strrr=`ps -eo pid,ppid,user,%cpu,pmem,vsz,rss,etimes,command | grep -v "\[" | grep  -E "(^|^ |^  |^   |^    )$s "`
        echo $strrr
    }
    function get_ppid() {
        str=`ps -eo pid,ppid,user,%cpu,pmem,vsz,rss,etimes,command | grep -v "\[" | grep  -E "(^|^ |^  |^   |^    )$1 "`
        gp_pid=`echo $str | awk '{print $2}'`
        if [[ `echo $gp_pid | grep  -o '[[:digit:]]*' | wc -l` -ne 1 ]]; then
            exit 0
        fi
        #echo "parrent pid of $1 = $gp_pid"
    }
    echo $hat
    string $a
    get_ppid $a
    string $gp_pid
    while [[ $gp_pid -gt "1" ]]; do
        get_ppid $gp_pid
        string $gp_pid
    done
}


function exec_by_line_filelist {
    if [[ -z $b ]] || [[ -z $a ]]; then 
        echo "usage: exec_by_line_filelist metas.txt local__stop_and_remove_snort.sh"
    else
        file_list=${1}
        exec_file=${2}
        count_all_lines=`cat ${file_list} | wc -l`
        i=1
        last_line=$((count_all_lines+1))
        while [[ $i -lt $last_line ]]; do 
            host=`head -n $i $file_list | tail -n1`
            ./${exec_file} ${host}
            i=$(($i+1))
        done < $file_list
    fi
}


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


# send video files to telegram throught docker
function sf(){
    f2s=${1}

    if [[ -e ${f2s} ]] ; then
        creds_dir="/srv/telegram/creds"
        base_shortname=$(basename "$f2s")
        shortname=`echo ${base_shortname} | sed 's/ /_/g'`
        shortname=$(echo $shortname | sed 's/ /_/g')
        sending_folder="/tmp/sendvideo"

        yes | rm "${sending_folder}/${f2s}" 2>/dev/null

        if [[ ! -d "${sending_folder}" ]]; then
            mkdir -p "${sending_folder}";
        fi

        if [[ ! -d "${creds_dir}" ]]; then
            mkdir -p "${creds_dir}"

            docker run -ti --rm \
            -v  ${creds_dir}:/root/.telegram-cli    \
            -v  ${sending_folder}:/mnt:rw           \
            kasumiru/vysheng-telegram-cli /bin/telegram-cli -W
        fi

        rsync -avP "${f2s}" "${sending_folder}/${shortname}";

        docker run -ti --rm -v \
            ${creds_dir}:/root/.telegram-cli -v \
            ${sending_folder}:/mnt:rw \
            --name telegram-cli-sf \
            kasumiru/vysheng-telegram-cli /bin/telegram-cli -W -e \
            "msg files ${base_shortname}:";

        docker run -ti --rm -v \
            ${creds_dir}:/root/.telegram-cli -v \
            ${sending_folder}:/mnt:rw \
            --name telegram-cli-sf \
            kasumiru/vysheng-telegram-cli /bin/telegram-cli -W -e \
            "send_video files /mnt/${shortname}";
        docker stop telegram-cli-sf 2>/dev/null
        docker rm telegram-cli-sf   2>/dev/null
        ls -l "${sending_folder}/${shortname}"
        yes | rm "${sending_folder}/${shortname}"
    else
        echo "file does not exist, exit now!"
    fi
    }


#PS4=' $(date +\%D.\%T.\%-3N)::`basename $0` [$LINENO]: '
PS4='$(date +\%Y.\%m.\%d.\%H\:%M.\%-3N): [$LINENO]: '
#function vim() { if [[ -z ${2} ]]; then $(which vim) $1; else echo "STOP VIM"; fi; }
function vim() { if [[ -z ${2} ]]; then $(which vim) "${1}"; else echo "STOP VIM"; fi; }                                                                               

if [[ -f ~/.bashrc.kas.linux.custom ]]; then source ~/.bashrc.kas.linux.custom; fi


locate_origin=`which locate`
function locate() {
  ${locate_origin} "$@" | 
    while read -r name; do
      ls -ld "$name"
    done
}
#function locate.short() {
#  ${locate_origin} "$@" | 
#    while read -r name; do
#      ls -ld "$name"
#    done
#}
#lloc() {
#  locate "$@" | 
#    while read -r name; do
#      ls -ld "$name"
#    done
#}
#lsloc pattern

# ls -l colors for enother format. example gz. 
export LS_COLORS="$LS_COLORS:ow=1;34:tw=1;34:*.tar=1;31:*.gz=1;31:*.tbz2=1;31"

### immediately bash history
shopt -s histappend
PROMPT_COMMAND="history -a;$PROMPT_COMMAND"
####

export SYSTEMD_PAGER=cat
export PAGER='cat'
git config --global core.pager cat

###
PS1="\[\033[35m\]\t\[\033[m\]-\[\033[36m\]\u\[\033[m\]@ \[\033[32m\]\h:\[\033[33;1m\] \w\[\033[m\] # "

function mkcd() { mkdir -p ${1}; cd ${1}; pwd; }
function btop() { /bin/btop_pre --utf-force; } # from wget https://github.com/aristocratos/btop/releases/download/v1.2.13/btop-x86_64-linux-musl.tbz
# mv btop to /bin/btop_pre 

## function cd() {
##     if [[ ! -n "${1}" ]]; then
##         lastdir=`tail -n1 ~/.bash_history | tr -s " " | cut -d " " -f 2`
##         if [[ -d "${lastdir}" ]]; then
##             echo "cd ${lastdir}"
##             cd ${lastdir}
##         else
##             echo "dir is not exist"
##         fi
##     else
##         builtin cd "$@"
##     fi
## }
function cd() {
    # если мы пытаемся перейти на файл.. cd /srv/config.conf ... 
    if [[ -f "$1" ]]; then
        echo "cd $(dirname $1)"
        builtin cd $(dirname "$1")
        return
    fi
    
    # если было просто написано cd без аргументов:
    if [[ ! -n "${1}" ]]; then
        # ищем в истории аргумент ПРОШЛОЙ команды, не текущй:
        lastdir=`tail -n1 ~/.bash_history | tr -s " " | cut -d " " -f 2`

        # если последнй аргумент ПРОШЛОЙ команды был файлом то:
        # переходим в папку, в которой лежит этот файл:
        if [[ -f "${lastdir}" ]]; then
            echo "cd $(dirname $lastdir)"
            cd $(dirname "$lastdir")

        # если последнй аргумент ПРОШЛОЙ команды был папкой то:
        else
            # переходим на папку, которая была указана аргументом к прошлой команде:
            # (к примеру: сделали сначала ls -l xxx. а потом cd и он перешёл на xxx)
            if [[ -d "${lastdir}" ]]; then
                echo "cd ${lastdir}"
                cd ${lastdir}
            else
                echo "dir is not exist"
            fi
        fi
        
    # если cd было написано с аргументами и аргумент папка (выяснили выше) переходи туда:
    else
        builtin cd "$@"
    fi
}

function w2ip() { whois `curl -s 2ip.ru` | grep 'role\|descr\|remarks\|address\|netname'; }

# tcp get free tcp port
function adm.get_free_tcp_port() {
    if [[ -z ${1} ]]; then
        ports="6000-7000"
    else
        ports=${1}
    fi

    printf """
ports = \"${ports}\"
def get_free_tcp_port(ports):
    try:
        import random

        def get_used_ports():
            loop_cnt:int = 0
            def get_listen_ports():
                listens = []
                lines = open('/proc/net/tcp').readlines()
                for l in lines:
                    ls = l.split()
                    if ls[3] == '0A':
                        lp =  ls[1].split(':')
                        o4 = int(lp[1], 16)
                        listens.append(o4)
                lines = open('/proc/net/tcp6').readlines()
                for l in lines:
                    ls = l.split()
                    if ls[3] == '0A':
                        lp =  ls[1].split(':')
                        o4 = int(lp[1], 16)
                        if o4 not in listens:
                            listens.append(o4)
                return listens
            return get_listen_ports()

        frprt = int(ports.split('-')[0])
        try:
            tprt = int(ports.split('-')[1])
        except Exception as e:
            tprt = frprt + 10
        if frprt >= tprt:
            tmp = frprt
            frprt = tprt
            tprt = tmp

        loop_cnt = 0
        port =  random.randint(frprt,tprt)

        while port in set(get_used_ports()):
            if port == tprt:
                return None
            if loop_cnt == 10:
                return None
            port = port + 1
            loop_cnt += 1

        return port
    except Exception as e:
        return e
print(get_free_tcp_port(ports))
""" | python3
}

function venv() { python3 -m venv ${1}; source ${1}/bin/activate; }

# adm.get_free_tcp_port "21-23"

function adm.genpasswd() {
    if [[ -z $1 ]]; then count=14; else count=$1; fi
    printf """
import string
import random
characters = list(string.ascii_letters + string.digits)
random.shuffle(characters)
password = []
length = \"${count}\"
def gen():
    for i in range(int(length)):
        password.append(random.choice(characters))
gen()
while True:
    if any(map(lambda xxx: xxx.isdigit(), password)):
        break
    else:
        password = []
        gen()
random.shuffle(password)
print(''.join(password))
""" | python3
}


# реализация oathtool под cygwin на Python
oathtool ()
{
    inp=${@}
    printf """
params = \"${inp}\"
import sys
if params == '':
    print('Не указан ключ для дешифровки')
    exit()
params = params.replace('--base32','')
params = params.replace('--totp','')
params = params.replace(' ','')
try:
    import pyotp
except Exception as e:
    import pip
    pip.main(['install', 'pyotp'])
    import pyotp
totp = pyotp.TOTP(params).now()
print(totp)
""" | python3
}
# что бы работало и так и так всё будет работать правильно. Ковычки не нужны! (ключи фейковые тут)
# oathtool 7hW3v4Wk26V43ZQUPJf5TY2SX62VNEYT
# oathtool --base32 --totp 7hW3v4Wk26V43ZQUPJf5TY2SX62VNEYT
# oathtool 7hW3 v4Wk 26V4 3ZQU PJf5 TY2S X62V NEYT
# oathtool --base32 --totp 7hW3 v4Wk 26V4 3ZQU PJf5 TY2S X62V NEYT

