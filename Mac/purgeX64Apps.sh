# Purge Apps not wanted any longer
# Run idX64Apps.sh first to gerate list, then adit it for what you want removed
#!/bin/bash

dir='/Applications/*/Contents/Macos'
file='/tmp/intelOnlyApps.o'
	echo ""
	echo -e "Searching for $dir and $file ... "
	echo ""	
	read -p "Make sure you have edited the file otherwise the entire list will be removed; Do you want to continue (y/n)?" REPLY
if [ "$REPLY" = "y" ]; then
for remove in `cat $file`
do	 
#sudo rm -rfv $remove >/tmp/PurgedApps.o
	ls -ld  $remove >>/tmp/PurgedApps.o
done	
	echo ""
	echo "Apps that were purged are in output log /tmp/PurgedApps.o"
  	echo "Quiting";
fi
