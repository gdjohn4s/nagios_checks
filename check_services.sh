#!/bin/sh
# Author: Giovanni D'Andrea
# Created: 31/01/2020

# Creare script bash che prende in input i parametri di nagios su commands.cfg,
# e fa la insert passando i valori delle notifiche di nagios definite nelle variabili d’ambiente.
# Quindi registra gli stati del check inserendo sul database se il check è OK o CRITICAL,
# con descrizione, host, nome servizio etc ... Lo script scatterà come se fosse un trigger grazie
# alle notifications di nagios che avvieranno lo script appena il suo stato passa da OK a CRITICAL e viceversa.

DBUSER="autotool"
DBPASS="autotool"
LOG="/usr/local/nagios/etc/logs/sqlplus.log"
export ORACLE_HOME=/u01/app/oracle/product/11.2.0/xe
export PATH=$ORACLE_HOME/bin:$PATH

HOSTNAME=$1
SERVICESTATE=$2
LASTSERVICECHECK=$3
SERVICEDURATION=$4
SERVICEATTEMPT=$5
SERVICEDISPLAYNAME=$6
SERVICEOUTPUT=$7
CONTACTEMAIL=$8

echo "******************** BEGIN ********************"
echo "***********************************************"

echo "************** SERVICE DURATION ***************"
echo $SERVICEDURATION
echo "************ LAST SERVICE STATE ***************"
echo $SERVICESTATE
echo "************* LAST SERVICE CHECK **************"
echo $LASTSERVICECHECK
echo "*************** SERVICE ATTEMPT ***************"
echo $SERVICEATTEMPT
echo "************ SERVICE DESCRIPTION **************"
echo $SERVICEDISPLAYNAME
echo "************** SERVICE OUTPUT *****************"
echo $SERVICEOUTPUT
echo "*************** CONTACT EMAIL *****************"
echo $CONTACTEMAIL
echo "***********************************************"

echo "sto entrando nella shell"
sqlplus -s $DBUSER/$DBPASS@192.168.242.5:1521/xe << EOF
set pages 0
set head off
insert into nagios_checks(ID_CHECK, HOSTNAME, STATUS, LAST_CHECK, DURATION_CHECK, ATTEMPT, STATS_INFO, SERVICE, NOTIFICA_INV, CONTACT)
values(SEQ_NAGIOS_CHECKS.nextval, '$HOSTNAME', '$SERVICESTATE', '$LASTSERVICECHECK', '$SERVICEDURATION', $SERVICEATTEMPT, '$SERVICEDISPLAYNAME', '$SERVICEOUTPUT', 'no', '$CONTACTEMAIL');
commit;
EOF

echo "sono uscito dalla shell"
echo ""
date
echo "******************* FINISH ********************"
echo "***********************************************"
echo ""
echo ""