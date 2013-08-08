#! /bin/bash

echo -e '['$(date +"%m-%d-%Y")']'
for server in $(ls /servers/);
    do
    if [ ! -d /backups/$server ];
        then 
            mkdir /backups/$server;
    fi;

    if [ ! -d /backups/tmp ];
        then 
            mkdir /backups/tmp;
    fi;

    echo 'Starting backup for '$server

    datetest=$(find /backups/$server -mtime 6 | wc -l)
    curtime=$(date +"%Y-%m-%d")
    if [ $datetest -gt 0 ];
        then 
            echo -e '['$(date +"%r")'] Removing old backups';
            find /backups/ -mtime 6 -print -delete;
    fi;

    echo -e '['$(date +"%r")'] Storing MySQL Databases...'
    for db in $(mysql -e 'show databases;' -B | grep $server);
        do
            echo -e '['$(date +"%r")'] Dumping '$db;
            mysqldump $db > /backups/tmp/$db.sql
    done;

    echo -e '['$(date +"%r")'] Copying temporary files...'
    cp -r /servers/$server /backups/tmp;
    cd /backups/tmp;

    echo -e '['$(date +"%r")'] Creating archive...'
    tar cf /backups/$server/$server.$curtime.tar *;
    if [ ! -f /backups/$server/$server.$curtime.tar.gz ];
        then 
            gzip /backups/$server/$server.$curtime.tar
        else
            echo -e '['$(date +"%r")'] $server.'$curtime'.tar.gz already exists. Skipping.';
            touch /backups/$server/.skipped
            rm -f /backups/$server/$server.$curtime.tar;
    fi;
    echo -e '['$(date +"%r")'] Removing temporary files...';
    rm -rf /backups/tmp;

    if [ ! -f /backups/$server/$server.$curtime.tar.gz ] || [ -f /backups/$server/.skipped ];
        then
            echo -e '['$(date +"%r")'] Backup was unsuccessfully created';
            rm -f /backups/$server/.skipped
        else
            echo -e '['$(date +"%r")'] Backup for '$server' on '$(date +"%m-%d-%Y")' was successfully created';
    fi;

done;


