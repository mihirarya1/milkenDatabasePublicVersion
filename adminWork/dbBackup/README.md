PURPOSE: 

This folder contains code to automatically get a backup of a specified 
local database name, and push it to the myddbbackup folder of the shared 
Google Drive folder.


FILE DESCRIPTIONS:

addTableSchema.py prepends column names to the .csv files produced by the 
mysqldump utility in getdbbackup.sh. dbConnectionOptions.csv simply contains 
some of the likely local databases (in format hostname,username,db-name) we 
may want to get connect to get backup of.
To begin this process run 'sudo ./getdbbbackup.sh'. 


CURRENT DEPENDENCIES:

getdbbackup.sh: user inputted db name, mysqldump install location, 
                addTableSchema.py, rclone installation location,
                rclone config process, guaranteed sudo access.
                
dbConnectionOptions.csv : user given db parameter tuples

addTableSchema.py: user given database parameters, dbConnectionOptions.csv, 
                   user given db password, '~' path variable set, 
                   module ~/dh199/adminWork/dbConnectionFunctions.py

