PURPOSE:

This folder pertains to pushing the local database with assumed name 'testing'
to the remote UCLA server database, with assumed name 'music'. 

FILE DESCRIPTIONS:

clearDB.py contains code to wipe all tables from the user given database and host.
clearServerDB.sql contains SQL code to remove all the tables from database name
'music'. This file is necessary for now, since we are still working on getting 
permissions to be able to run Python scripts on the UCLA database server.
dbConnectionOptions.csv contains hostname,username,database tuples, to be presented
to the user in clearDB.py. pushLocalDBToServer.sh is a bash script which uses mysqldump
utility to backup local database 'testing' into a dump file, and then run that dump
file on the UCLA database server. To begin to do this, run './pushLocalDBToServer.sh'.

DEPENDENCIES:

clearDB.py: user given database parameters, dbConnectionOptions.csv, user given db password, 
'~' path variable set, module ~/dh199/adminWork/dbConnectionFunctions.py

clearServerDB.sql: existence of db 'music' on MySQL instance file is being run on

dbConnectionOptions.csv: user given db parameter tuples

pushLocalDBToServer.sh: existence of mysqldump utility, password to remote UCLA database.
