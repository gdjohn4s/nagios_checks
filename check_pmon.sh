#!/bin/sh
# Written by Giovanni D'Andrea

# --- Check for PMON istance (Oracle) on nagios.
BASENAME="CHECK_PMON"

# ---------------------------------------------------
# --- Check if pid file exist
# if [[ $(ls /root/pids/ |grep pmon |sed -n 1p) ]]; then
#     echo "PIPPO" > /dev/null
#     else
#     echo `"WARN - PID file not created! " date `>> /root/logs/nagios_scripts.log  # --- BUG: anche con il file esistente, l'output è WARN
#     exit 1
# fi

# --- Functions
check_istance() {
    if [[ $(ps -ef |grep pmon |sed -n 1p |awk '{print $1}') == "oracle" ]]; then
        echo "OK - ORACE Istance running"
        exit 0
    else 
        echo "CRITICAL - ORACLE not running"
        exit 2
    fi
}

# --------
# Per il check sul PID controllare se il file pid è esistente ed eventualmente, sotto richiesta dell'utente farlo stampare a schermo
# --------
check_pid() {
    if [[ $(ls /root/pids/ |grep pmon) == "pmon.pid" ]]; then
    echo "PID Found" >> /root/pids/nagios_scripts.log
    else
    echo "PID not found" >> /root/pids/nagios_scripts.log
    fi
}

# TODO:
# Per risolvere il BUG del check sull'istanza bisogna scrivere un'altra funziona che si occuperà solamente di leggere il pid dal comando ps -ef e scriverlo sul file PID

# --- Main
check_istance()
check_pid()
