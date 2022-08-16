#!/bin/bash 
USER="root" 
PASSWORD="Пароль" 
OUTPUT="/var/www/backup_mysql" #директория для хранения резервных копий 
databases=`mysql -u $USER -e "SHOW DATABASES;" | tr -d "|" | grep -v Database` 
for db in $databases; do 
        echo "Dumping database: $db" 
        mysqldump --single-transaction  --force --opt -u $USER --databases $db > $OUTPUT/`date +%Y%m%d`.$db.sql 
        #gzip $OUTPUT/`date +%Y%m%d`.$db.sql 
done

mysqldump -u root --all-databases > $OUTPUT/ALLDATABASES.sql
