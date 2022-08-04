#!/bin/bash

USER="root"
PASSWORD="Пароль"
OUTPUT="/root/backup_mysql" #директория для хранения резервных копий
 
databases=`mysql -u $USER -e "SHOW DATABASES;" | tr -d "|" | grep -v Database`
 
for db in $databases; do
    if [[ "$db" != "information_schema" ]] && [[ "$db" != _* ]]; then
        echo "Dumping database: $db"
        mysqldump --force --opt -u $USER --databases $db > $OUTPUT/`date +%Y%m%d`.$db.sql 
        gzip $OUTPUT/`date +%Y%m%d`.$db.sql
    fi
done
