mc-backup
=========

Generate complete minecraft backups ready for restore. By default this script will keep a revolving 7 day window of backups in the /backups/ directory. I created this script as a precautionary mesure after my first Minecraft server was placed on Nodus Griefing, and I faced a 6-day hell of trying to undo the damage that had been done.

###Requirements###
* Basic understanding of the Linux file system
* Shell access with ability to edit crontab (I run this through root crontab to make life easier)

###Installation###
1. Copy or upload the contents of the file "backup" to an accessible location on your server. In the example of my own server, I have this as an executable command in /sbin/
2. Ensure the script is executable. ( chmod 755 /path/to/backup )
3. Configure the 3 main options in the script. (serverdir, backupdir, and retain)
4. Edit your crontab to run the script at a non-peak time for your server ( My crontab looks like this: 45 3 * * * /root/bin/backup >> /backups/backup.log )

###Configuration###
Right now, there are 3 options to configure in this script:

* serverdir: The location of your server(s). Default is /servers.
* backupdir: The location you would like to keep backups. Default is /backups.
* retain: How many days you would like to keep backups for. Default is 7 days.

###Additional Information###
This script creates a full backup of your minecraft directory and any databases you may have. Because of the temporary file copy and compress process, you may notice a small to moderate amount of lag, depending on the size of your server and worlds. This script is not for everyone. Additionally, while I personally do not believe the script can do any harm, this software is still use at your own risk. I am by no means responsible for any damages this may cause to your server.
