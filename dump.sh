#!/bin/bash

USER="Логин, который имеет доступ ко всем базам"
PASSWORD="Пароль"
OUTPUT="/root/backup_mysql" #директория для хранения резервных копий
 
databases=`mysql -u root -e "SHOW DATABASES;" | tr -d "|" | grep -v Database`
 
for db in $databases; do
    if [[ "$db" != "information_schema" ]] && [[ "$db" != _* ]] ; then
        echo "Dumping database: $db"
        mysqldump --force --opt -u --databases $db > $OUTPUT/`date +%Y%m%d`.$db.sql 
        gzip $OUTPUT/`date +%Y%m%d`.$db.sql
    fi
done
