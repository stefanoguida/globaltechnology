#!/bin/sh
rm /opt/mysql/backup/global_technology-*.sql >> /var/log/cron.log
mv /opt/mysql/backup/global_technology.sql /opt/mysql/backup/global_technology-$(date +"%Y%m%d%H%M%S").sql  >> /var/log/cron.log
mysqldump -hdatabase -uroot -p${MYSQL_ROOT_PASSWORD} --databases ${MYSQL_DATABASE} > /opt/mysql/backup/global_technology.sql
