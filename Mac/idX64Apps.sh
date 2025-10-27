# Check for incompatible applications

dir='/Applications/*/Contents/Macos'

#!/bin/bash
	echo ""
	echo -e "Searching for $dir and $file ... "
	echo ""	
##find /Applications/*/Contents/Macos -type f -perm +0111 -exec /usr/bin/file {} \; | grep executable|grep x86_64|grep -v arm64 |awk '{print $1}'|sed s/://|awk -F/ '{print $3}'|uniq >/tmp/intelOnlyApps.o
  	find /Applications/*/Contents/Macos -type f -perm +0111 -exec /usr/bin/file {} \; | grep executable|grep x86_64|grep -v arm64 |awk -F/ '{print "/"$2"/"$3}'|uniq >/tmp/intelOnlyApps.o
	echo ""
	echo "Output of results are in /tmp/intelOnlyApps.o"
##else
  	echo "Quiting";
##fi

