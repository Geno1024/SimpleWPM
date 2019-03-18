#!/bin/bash

CONFIGS='/srv/http/SWLib/AutoUpdate/configs'
cwd="`pwd`"
cd $CONFIGS
cd ..

if [[ $1 = "" || $1 = "all" ]]; then
    echo -e "\e[31mChecking All...\e[m"
    for file in `ls $CONFIGS`; do
        echo -e "    \e[34mChecking \e[1m$file...\e[m"
        url=$(sh $CONFIGS/$file)
        if [ ! -e ${url##*/} ]; then
            echo -e "    \e[35mUpdating \e[1;33m$file...\e[m"
            axel -q -n 256 "$url"
            while [ $? != 0 ]; do
            	echo -e "    \e[41;33mRetrying \e[1m$file...\e[m"
                axel -q -n 256 "$url"
            done
            echo -e "             \e[1;32m$file\e[m\e[32m updated.\e[m"
        else
            echo -e "             \e[1;32m$file\e[m\e[32m already up-to-date.\e[m"
        fi
    done
    echo -e "\e[1;32mAll up-to-date.\e[m"
else
    echo -e "\e[34mChecking \e[1;34m$1...\e[m"
    url=$(sh $CONFIGS/$1)
    if [ ! -e ${url##*/} ]; then
        echo -e "\e[35mUpdating \e[1;33m$1...\e[m"
        axel -q -n 256 "$url"
        while [ $? != 0 ]; do
            echo -e "\e[41;33mRetrying \e[1m$file...\e[m"
            axel -q -n 256 "$url"
        done
        echo -e "         \e[1;32m$1\e[m\e[32m updated.\e[m"
    else
        echo -e "         \e[1;32m$1\e[m\e[32m already up-to-date.\e[m"
    fi
fi
cd "$cwd"
