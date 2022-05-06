#!/bin/bash

# shell script to obtain all of the tables of the database in .txt format.

read -rep $'Enter local mysql database name you wish to get backup of:\n' dbName # get user input of the local db to backup

mkdir -p ~/dh199/mydbbackup #create backup folder if one does not exist
rm ~/dh199/mydbbackup/* #clear existing backup folder
cd ~/dh199/mydbbackup/ #change to backup folder
sudo chmod 777 ~/dh199/mydbbackup/ #ensure proper permissions on backup folder

#below mysqldump produces .txt files for each table in specified db, in the backup folder.
sudo /usr/local/mysql/bin/mysqldump --complete-insert -t -T/~/dh199/mydbbackup $dbName --fields-terminated-by=',' --fields-enclosed-by='"' --fields-escaped-by='"'
for f in *.txt; do 
    mv -- "$f" "${f%.txt}.csv" #rename each .txt file to end with .csv
done
sudo chmod 777 *.csv #set rwx permissions for current user for all produced csv files
sudo rm *.sql #remove all sql files produced by mysqldump

cd ~/dh199/adminWork/dbBackup #switch to python file directory
python3 addTableSchema.py #run python file to prepend the column names for each table
cd ~/dh199/mydbbackup/

#perform the rclone copy to move all the files in mydbbbackup to 'Mihir Arya - Visualizing Recorded Jewish Music'/'CSV Database'/'dbbackup'.
for FILE in *.csv; do rclone copy $FILE gdrive:""; done 





