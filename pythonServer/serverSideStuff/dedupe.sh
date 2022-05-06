#!/bin/bash                                                                                                                                                                      
echo "Enter input file name (.csv file on which to perform dedupe):"
read fileName
echo "Enter your name without spaces (to distinguish output files):"
read username
echo "Enter threshold to use for clustering phase between 0 and 1, with 1 least inclusive (try .5 if unsure):"
read threshold

source env/bin/activate;
python main.py $fileName $username $threshold;
deactivate;


filename=${fileName%????}
rclone copy /home/ec2-user/env/outputDedupeFiles/outputResults/$username$filename"OutputFile.csv" gdrive:"outputFiles"

logout; > /dev/null
logout; > /dev/null
