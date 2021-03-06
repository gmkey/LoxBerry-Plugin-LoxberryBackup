#!/bin/bash
# Will be executed as user "root".

echo "<INFO> Installing raspiBackup"

# Install raspiBackup
chmod +x REPLACELBPDATADIR/raspiBackupInstall.sh
bash REPLACELBPDATADIR/raspiBackupInstall.sh -c

chmod +x $5/data/plugins/$3/raspiBackup*.sh
mv -u -f $5/data/plugins/$3/raspiBackup_*.sh /usr/local/bin/


# We have to default raspiBackup to not zip, as we cannot override this for rsync backups (will fail)
#	sed -i.bak 's/^\(DEFAULT_ZIP_BACKUP=\).*/\1"0"/' $lbbackupconfig 

# Create backup directory if missing
if [ ! -d "/backup" ]; then
	echo "<INFO> Creating default /backup directory"
	mkdir -p /backup
	chown loxberry:loxberry /backup 
fi

if [ -e "$LBHOMEDIR/system/cron/cron.d/$2" ]; then
	chown root:root $LBHOMEDIR/system/cron/cron.d/$2
fi

exit 0
