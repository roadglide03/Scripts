#
source="lehighx4@lehighvalleycamaro.org:~/"
target="/Users/andy/Documents/Sites/WordPress/LVCC/"
date=`date +%m%d%H%M`
echo $source
echo $target

if [ -d $target ];then
	rsync -av --delete-after  $source $target
	sudo echo "$date:downloads:lvcc to $target for Downloads was Successful" >> /var/log/rsync
exit 0

else
	sudo echo "$date:lvcc:Either $source and/or $target Backup Volumes not Available" >> /var/log/rsync


exit 1
fi
