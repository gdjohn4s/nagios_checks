#!/bin/sh
# Author: Giovanni D'Andrea
# Created: 05/02/2020

# Simile allo script check_service solo che inserisce i dati su Mysql invece che su Oracle

DBUSER="statserver"
DBPASS="statserver"
LOG="/usr/local/nagios/etc/logs/sqlplus.log"

HOSTNAME=$1
SERVICESTATE=$2
LASTSERVICECHECK=$3
SERVICEDURATION=$4
SERVICEATTEMPT=$5
SERVICEDISPLAYNAME=$6
SERVICEOUTPUT=$7
CONTACTEMAIL=$8
HOSTADDRESS=$9
SERVICEPROBLEMID=$10

##### CONVERTING UNIX DATETIME #####
LASTSERVICECHECK=`date -d @$3`

echo "******************** BEGIN ********************"
echo ""
echo ""
echo "***********************************************"
echo ""
echo ""
echo "***************** IP ADDRESS ******************"
echo $HOSTADDRESS
echo ""
echo ""
echo "************** SERVICE DURATION ***************"
echo $SERVICEDURATION
echo ""
echo ""
echo "************ LAST SERVICE STATE ***************"
echo $SERVICESTATE
echo ""
echo ""
echo "************* LAST SERVICE CHECK **************"
echo $LASTSERVICECHECK
echo ""
echo ""
echo "*************** SERVICE ATTEMPT ***************"
echo $SERVICEATTEMPT
echo ""
echo ""
echo "************ SERVICE DESCRIPTION **************"
echo $SERVICEDISPLAYNAME
echo ""
echo ""
echo "************** SERVICE OUTPUT *****************"
echo $SERVICEOUTPUT
echo ""
echo ""
echo "*************** CONTACT EMAIL *****************"
echo $CONTACTEMAIL
echo ""
echo ""
echo "***********************************************"

echo "sto entrando nella shell"
mysql -u "$DBUSER" -p"$DBPASS" << EOF
insert into nagios_checks(ID_CHECK, HOSTNAME, STATUS, LAST_CHECK, DURATION_CHECK, ATTEMPT, STATS_INFO, SERVICE, NOTIFICA_INV, CONTACT, HOST_IP, PROBLEM_ID)
values(ID_CHECK, "$HOSTNAME", "$SERVICESTATE", "$LASTSERVICECHECK", "$SERVICEDURATION", "$SERVICEATTEMPT", "$SERVICEDISPLAYNAME", "$SERVICEOUTPUT", "no", "$CONTACTEMAIL", "$HOSTADDRESS", "$SERVICEPROBLEMID");
commit;
EOF

echo "sono uscito dalla shell"
echo ""
date
echo "******************* FINISH ********************"
echo "***********************************************"
echo ""
echo ""
