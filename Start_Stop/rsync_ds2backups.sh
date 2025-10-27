#
source="root@10.0.1.166:/volume2/Backups"
target="/Volumes/Drobo_TM/"
date=`date +%m%d%H%M`
echo $source
echo $target

if [ -d $target ];then
	rsync -av --rsync-path=/bin/rsync --delete-after --exclude-from '/Users/andy/Rsync/rsync_exclude.txt' $source $target
	sudo echo "$date:downloads:Backup to $target for Downloads was Successful" >> /var/log/rsync
exit 0

else
	sudo echo "$date:downloads:Either $source and/or $target Backup Volumes not Available" >> /var/log/rsync


exit 1
fi
