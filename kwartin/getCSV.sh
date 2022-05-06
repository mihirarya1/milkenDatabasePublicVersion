#!/bin/bash

cd /tmp
sudo rm tmp*
cd ~/dh199/kwartin/kwartinResults
sudo rm tmp*
cd ..
mysql testing < runQueries.sql

/usr/local/mysql/bin/mysqldump -T/tmp testing tmp1 --fields-terminated-by=~

mysql testing < delTempTables.sql

cd /tmp
sudo mv tmp* ~/dh199/kwartin/kwartinResults

cd ~/dh199/kwartin/kwartinResults
rm *.sql
