#!/bin/bash
#
#This script is used to count the number of cores for the following OS platforms: AIX, Linux, Solaris, Mac OS X
#
# Author: Andy Dishong
# Modified: Linux type, 04012021
#

## Set varibles
host=`uname -n`
os=`uname -s`

##Print usage information

##Validate root or root access


# Check to see if running root
PROG=`basename $0` ; export PROG

if [ "${LOGNAME}" = "root" ]
then    # Success
        :
else    # exit - Not root
        echo "${PROG}: You must be Root use "su" or "sudo" to use script!"
        exit 1
fi
##Location of logs
CORE_INSTALL_DIR=/var/tmp/cores          
if [ ! -d $CORE_INSTALL_DIR ] ; then
  mkdir -p $CORE_INSTALL_DIR/logs
fi

CORE_LOGDIR=$CORE_INSTALL_DIR/logs
export CORE_INSTALL_DIR CORE_LOGDIR



##Verify command(s)
#
#Linux
linux () {
	echo "Number of cores & threads for: OS=$os HOST=$host"
	echo -e "Number of cores: \c";cat /proc/cpuinfo | grep -i 'processor' | wc -l
	lscpu | grep -i thread
}

#Solaris
#machdep.cpu.core_countSolaris
solaris () {
	echo "Number of cores for: OS=$os HOST=$host"
	psrinfo -p #core count system wide
	psrinfo -v #verbose output
}

#Aix
aix () {
	echo "Number of cores for: OS=$os HOST=$host"
##	lsattr -El sys0 |grep ent_cap |awk {'print $2'} #breaks out by LPAR?
    echo -e "LPAR Cores & Physical CPUs"
    lparstat -i | egrep "Type|Mode|CPU"|egrep Maximum
    echo ""
    echo -e "Number of Threads in LPAR"
    smtctl |egrep Threads
}    

#Mac OS X (because you can)
osx () {
	core=`sysctl hw.ncpu | awk '{print $2}'`
# or
#	sysctl hw.ncpu
	echo "Number of cores for: OS=$os HOST=$host are: $core"
	echo "OS=$os HOST=$host | core count=$core" >>$CORE_LOGDIR/core_count-`date "+%y%m%d%H%M%S"`  2>&1
	
}

##Identify platform type
if [ $os = "Linux" ]; then
	linux
elif [ $os = "sunos" ]; then
	solaris
elif [ $os = "aix" ]; then
	aix
elif [ $os = "Darwin" ]; then
	osx
else
	echo "No compatible platform found for OS=$os HOST=$host"
	exit 1
fi

##Count socket

##Count cores

##Print information
