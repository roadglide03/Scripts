#!/bin/ksh
#
# Copyright 2004 Sun Microsystems, Inc.  All rights reserved.
# Use is subject to license terms.
#
#ident	"%Z%%M%	%I%	%E% SMI"

if [[ -z "$1" || -z "$2" || -z "$3" ]]; then
	   echo "usage: $0 <#-of-zones> <zonename-prefix> <basedir> <sparse or whole>"
	   exit 2
fi

if [[ ! -d $3 ]]; then
  	echo "$3 is not a directory"
	   exit 1
fi

nprocs=`psrinfo | wc -l`
nzones=$1
prefix=$2
dir=$3
type=$4

if [ $type="whole" ]; then
		zt="-b"
	else
		zt=""
fi

ip_addrs_per_if=`ndd /dev/ip ip_addrs_per_if`
if [ $ip_addrs_per_if -lt $nzones ]; then
	   echo "ndd parameter ip_addrs_per_if is too low ($ip_addrs_per_if)"
  	echo "set it higher with 'ndd -set /dev/ip ip_addrs_per_if <num>"
 	exit 1
fi

i=1
#Create whole root zones using create -b
while [ $i -le $nzones ]; do
	zoneadm -z $prefix$i list > /dev/null 2>&1
	if [ $? != 0 ]; then
		echo configuring $prefix$i
		F=$dir/$prefix$i.config
		rm -f $F
		echo "create $zt" > $F
		echo "set zonepath=$dir/$prefix$i" >> $F
		zonecfg -z $prefix$i -f $dir/$prefix$i.config 2>&1 | \
		    sed 's/^/    /g' 
	else
		echo "skipping $prefix$i, already configured"
	fi
	i=`expr $i + 1`
done

i=1
while [ $i -le $nzones ]; do
	j=1
	while [ $j -le $nprocs ]; do
		if [ $i -le $nzones ]; then
			if [ `zoneadm -z $prefix$i list -p | \
			    cut -d':' -f 3` != "configured" ]; then
				echo "skipping $prefix$i, already installed"
			else
				echo installing $prefix$i
				mkdir -pm 0700 $dir/$prefix$i
				chmod 700 $dir/$prefix$i
				zoneadm -z $prefix$i install > /dev/null 2>&1 &
				sleep 1	# spread things out just a tad
			fi
		fi
		i=`expr $i + 1`
		j=`expr $j + 1`
	done
	wait
done

i=1
while [ $i -le $nzones ]; do
	echo setting up sysid for $prefix$i
	cfg=$dir/$prefix$i/root/etc/sysidcfg
	rm -f $cfg
	echo "network_interface=NONE {hostname=$prefix$i}" > $cfg
	echo "system_locale=C" >> $cfg
	echo "terminal=xterms" >> $cfg
	echo "security_policy=NONE" >> $cfg
	echo "name_service=NONE" >> $cfg
	echo "timezone=US/Pacific" >> $cfg
	echo "root_password=Rund9uAPD5dkg" >> $cfg  # 'sun123'
	i=`expr $i + 1`
done

i=1
para=`expr $nprocs \* 2`
while [ $i -le $nzones ]; do
	date
	j=1
	while [ $j -le $para ]; do
		if [ $i -le $nzones ]; then
			echo booting $prefix$i
			zoneadm -z $prefix$i boot &
		fi
		j=`expr $j + 1`
		i=`expr $i + 1`
	done
	wait
done
