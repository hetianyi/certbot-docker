#!/bin/bash

echo "" > /etc/apt/sources.list
echo "deb http://mirrors.aliyun.com/ubuntu/ xenial main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb http://mirrors.aliyun.com/ubuntu/ xenial-security main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb http://mirrors.aliyun.com/ubuntu/ xenial-updates main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb http://mirrors.aliyun.com/ubuntu/ xenial-proposed main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb http://mirrors.aliyun.com/ubuntu/ xenial-backports main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb-src http://mirrors.aliyun.com/ubuntu/ xenial main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb-src http://mirrors.aliyun.com/ubuntu/ xenial-security main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb-src http://mirrors.aliyun.com/ubuntu/ xenial-updates main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb-src http://mirrors.aliyun.com/ubuntu/ xenial-proposed main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb-src http://mirrors.aliyun.com/ubuntu/ xenial-backports main restricted universe multiverse" >> /etc/apt/sources.list



temp=`getopt -o e:d:: -l email:,domain: \
     -n 'example.bash' -- "$@"`
if [ $? != 0 ] ; then echo "terminating..." >&2 ; exit 1 ; fi

email=""
output=""
domain=""


while true ; do
        case "$1" in
                -e|--email)
                    case "$2" in
                    ""|-o|-d) echo "err: email cannot be empty!"; exit 1 ;;
                    *)  echo "option email, argument '$2'" ; email=$2; shift 2 ;;
                    esac ;;
                -d|--domain) 
                    case "$2" in
                    ""|-o|-e) echo "err: domain cannot be empty!"; exit 1 ;;
                    *)  echo "option domain, argument '$2'" ; domain=$2; shift 2 ;;
                    esac ;;
                --|*) break ;;
        esac
done


if [ $email = "" ]; then
    echo "err: email cannot be empty!"
    exit 1
fi

if [ $domain = "" ]; then
    echo "err: domain cannot be empty!"
    exit 1
fi


apt update -y  && apt install wget -y && \
wget https://dl.eff.org/certbot-auto && \
chmod a+x certbot-auto && \
./certbot-auto -n --install-only && \
./certbot-auto --standalone -n certonly -d $domain --email=$email --agree-tos && \
cd /etc/letsencrypt/live && /bin/cp -rfL * /output && \
echo ""
echo "+------+"
echo "success"
echo "+------+"
