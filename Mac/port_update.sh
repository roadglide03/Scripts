#!/bin/bash
#
PR="/opt/local/bin/port" 
PRC=`/opt/local/bin/port outdated|wc -l`

if [ $PRC -ge 1  ];then

	echo -e " \n"
	echo -e "MacPorts needs updating \c $PRC "
	echo -e " \n"
	echo "Updating and Upgrading brew packages: $PR outdated"
	echo -e " \n"
	sudo /opt/local/bin/port selfupdate
	$PRC
else
	echo -e " \n"
	echo "MacPorts does not need updating"
fi
