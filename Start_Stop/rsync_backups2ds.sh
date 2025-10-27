#
source="/Volumes/Drobo_TM/"
target="root@10.0.1.166:/volume2/Backups"
date=`date +%m%d%H%M`
echo $source
echo $target

if [ -d $source ];then
	echo "Found Downloads"
	echo "Starting sync on Downloads"
	rsync -av --rsync-path=/bin/rsync /Users/andy/Downloads/ $target/Incoming
	rm -rf /Users/andy/Downloads/*

	rsync -av --rsync-path=/bin/rsync --delete-after --exclude-from '/Users/andy/Rsync/rsync_exclude.txt' $source $target
	sudo echo "$date:downloads:Backup to $target for Downloads was Successful" >> /var/log/rsync
exit 0

else
	sudo echo "$date:downloads:Either $source and/or $target Backup Volumes not Available" >> /var/log/rsync


exit 1
fi
