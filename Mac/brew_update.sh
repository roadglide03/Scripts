#!/bin/bash
#
BR="/usr/local/bin/brew" 
BRC=`/usr/local/bin/brew outdated|wc -l`

if [ $BRC -ge 1 ];then

	echo -e " \n"
	echo -e "brew needs updating \c $BRC "
	echo -e " \n"
	echo "Updating and Upgrading brew packages: $BR outdated"
	echo -e " \n"
	/usr/local/bin/brew update
	/usr/local/bin/brew upgrade
	$BRC
else
#	echo -e " \n"
	echo "Brew does not need updating"
fi
