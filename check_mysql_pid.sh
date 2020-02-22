#!/bin/sh
# Written by Giovanni D'Andrea

ERROR="mysqld is stopped"
status=`service mysqld status`
warn=`rpm -qa |grep mysql |sed -n 2p`
LOG=/root/scripts/scriptslogs/scripts.log

# --- Main
# --- Check if mysql daemon is running
if [[ $status == $ERROR ]]; then
    echo "CRITICAL - mysqld daemon not running"
    # --- Check if mysql packages (rpm in this case, for RedHat/CentOS) are installed
    if [[ $(rpm -qa |grep mysql |sed -n 2p) ]]; then
        echo "Mysql packages found" >> $LOG
    else
        echo "MySql packages not found" >> $LOG
        echo "WARN - MySQL packages not found!"
        exit 1
    fi
    exit 2
elif [[ $status != $ERROR ]]; then
    echo "OK - $status"
    exit 0
fi

echo $status >> /root/scripts/freem.log