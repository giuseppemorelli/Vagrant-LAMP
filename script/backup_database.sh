#!/bin/bash
##################################
##                              ##
## GMdotnet Vagrant LAMP Stack  ##
## Version 1.1.4                ##
##                              ##
## Script for database backup   ##
##################################

TIMESTAMP=$(date +"%F_%H-%M-%S")

# IMPORT DATABASE SCRIPT CONFIG
. /vagrant/script/backup_database.cfg

# Folder's name of backup
BACKUP_DIR="$BACKUP_ROOT/vagrant-$TIMESTAMP"
# MySQL username and password
MYSQL_USER="local"
MYSQL_PASSWORD="local"
# Mysql and mysqldump bin command file
MYSQL=/usr/bin/mysql
MYSQLDUMP=/usr/bin/mysqldump

# Counter of backup database done
counter=0

mkdir -p $BACKUP_DIR
databases=`$MYSQL --user=$MYSQL_USER -p$MYSQL_PASSWORD -e "SHOW DATABASES;" | grep -Ev "(Database|information_schema)"`

for db in $databases; do
 $MYSQLDUMP --force  --single-transaction --add-drop-table  --create-options --set-charset --quick --extended-insert --user=$MYSQL_USER -p$MYSQL_PASSWORD --databases $db | gzip > "$BACKUP_DIR/$db.gz"

 let counter=$counter+1
done

echo "---------------------------------------------"
echo "DB BACKUP DONE: $counter"
echo "---------------------------------------------"
