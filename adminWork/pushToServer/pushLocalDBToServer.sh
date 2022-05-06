# driver code to copy over local database 'testing' to the UCLA server's 'music' databse

/usr/local/mysql/bin/mysqldump testing > musicDB.sql; # uses mysqldump to output a file which can be used to reconstruct db and its data
echo "Will only work if connected to Campus VPN!!!" 
mysql --host dba-mysql-odb-d01.it.ucla.edu music --user music -p < clearServerDB.sql; # first clear existing database on the server
mysql --host dba-mysql-odb-d01.it.ucla.edu music --user music -p < musicDB.sql; # recontruct db on the server, using the dump file generated
rm musicDB.sql; # delete db reconstruction file
