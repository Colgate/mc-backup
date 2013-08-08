mc-backup
=========

Generate complete minecraft backups ready for restore. By default this script will keep a revolving 7 day window of backups in the /backups/ directory. I created this script as a precautionary mesure after my first Minecraft server was placed on Nodus Griefing, and I faced a 6-day hell of trying to undo the damage that had been done.

###Requirements###
* Basic understanding of the Linux file system
* Shell access with ability to edit crontab (I run this through root crontab to make life easier)
* Minecraft server(s) in the directory path /servers/%YOURSERVERNAME%, or the ability to modify basic bash scripts
* MySQL databases in the format %servername%_%databasename% (I work as a Linux administrator in cPanel environments, this schema came naturally)

###Installation###
1. Copy or upload the contents of the file "backup" to an accessible location on your server. In the example of my own server, I have this as an executable command in /sbin/
2. Ensure the script is executable. ( chmod 755 /path/to/backup )
3. Ensure you have created a directory called /backups/
4. Edit your crontab to run the script at a non-peak time for your server ( My crontab looks like this: 45 3 * * * /sbin/backup >> /backups/backup.log )
5. Optionally, if you would like to log the output to ensure backups have run, you can direct the output to a log file, such as I have done above.

###Restoration###
If for any reason you need to restore from a backup, the following process is my recommended method:

1. mkdir /backups/tmp && cp/backups/backup-you-want-to-restore /backups/tmp
2. cd /backups/tmp
3. tar zxvf *tab* (or the name of the backup file)
4. check to make sure everything has untarred correctly.
5. mv /servers/%yourservername%{,.old}
6. mv /backups/tmp/%yourservername% /servers/
7. If you have databases: mysql -u %username% -p'%password%' %DBNAME% < /backups/tmp/dbname.sql
8. Start your server and ensure EVERYTHING is in order.
9. Once you have verified the backup has restored correctly you can rm -rv /servers/%servername$.old

###Additional Information###
This script creates a full backup of your minecraft directory and any databases you may have. Because of the temporary file copy and compress process, you may notice a small to moderate amount of lag, depending on the size of your server and worlds. This script is not for everyone. Additionally, while I personally do not believe the script can do any harm, this software is still use at your own risk. I am by no means responsible for any damages this may cause to your server.

###TO DO###
* Add configurable optons, such as path, logging, optional server alerts, etc.
* Create restoration script or one-line bash code for this readme
* ???
* Profit
