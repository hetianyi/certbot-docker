#!/bin/bash

process() {
    echo ""
    echo "+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+"
    echo "ERR: $1"
    echo "+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+"
    echo ""
}

checkStatus() {
    exit_code=$1
    if [ $exit_code != 0 ]
    then
        echo "ERROR: $exit_code"
        exit $exit_code
    fi
}

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
    process "email cannot be empty!"
    exit 1
fi

if [ $domain = "" ]; then
    process "domain cannot be empty!"
    exit 1
fi



./certbot-auto --standalone -n certonly -d $domain --email=$email --agree-tos
checkStatus $?

cd /etc/letsencrypt/live && /bin/cp -rfL * /output && \
echo ""
echo "+------+"
echo "success"
echo "+------+"
