#!/bin/bash

cd /tmp
sudo rm tmp*
cd ~/dh199/kolNidrei/kolNidreResults
sudo rm tmp*
cd ..
mysql testing < runQueries.sql

/usr/local/mysql/bin/mysqldump -T/tmp testing tmp1 --fields-terminated-by=~
/usr/local/mysql/bin/mysqldump -T/tmp testing tmp2 --fields-terminated-by=~
/usr/local/mysql/bin/mysqldump -T/tmp testing tmp3 --fields-terminated-by=~
/usr/local/mysql/bin/mysqldump -T/tmp testing tmp4 --fields-terminated-by=~
/usr/local/mysql/bin/mysqldump -T/tmp testing tmp5 --fields-terminated-by=~
/usr/local/mysql/bin/mysqldump -T/tmp testing tmp6 --fields-terminated-by=~
/usr/local/mysql/bin/mysqldump -T/tmp testing tmp7 --fields-terminated-by=~
/usr/local/mysql/bin/mysqldump -T/tmp testing tmp8 --fields-terminated-by=~
/usr/local/mysql/bin/mysqldump -T/tmp testing tmp9 --fields-terminated-by=~

mysql testing < delTempTables.sql

cd /tmp
sudo mv tmp* ~/dh199/kolNidrei/kolNidreResults/

cd ~/dh199/kolNidrei/kolNidreResults
rm *.sql
