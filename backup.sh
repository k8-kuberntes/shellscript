
#!/bin/bash

#Script -:Backup script it will upload the files to s3 bucket if more than 30days


date=`/bin/date "+%Y.%m.%d.%H.%M.%S"`
mkdir -p /opt/logs/backup-$date
mkdir /opt/logarchive
find /root/ -type f -iname *.logs -mtime +30 |awk '{print $1}' | while read f; do mv "$f" /opt/logs/backup-$date;done
cd /opt/logs/
zip -r backup-$date.zip  .
aws s3 cp backup-$date.zip  s3://mybucket/backup-$date.zip
rm -rf /opt/logs/*
echo "$(date) log Backuped Done ">>/opt/logs/logbackup-status-$date.log

