#!/bin/bash
# Giovanni D'Andrea
# Created at: 07/02/2020

PID=/root/scripts/pids/
FILENAME=checkStatMemory.pid

# Se il comando find trova il file PID, scatta il CRITICAL su nachos, altrimenti è OK
if [[ $(find $PID -name "$FILENAME" -mmin 60) ]];then
    echo "Trovato un PID running da almeno 1H"
    exit 2
else 
    echo "Service OK"
    exit 0
fi