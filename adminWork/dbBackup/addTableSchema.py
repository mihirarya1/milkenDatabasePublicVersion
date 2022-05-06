import sys
import os
homeDir = os.path.expanduser('~')
sys.path.append(homeDir+"/dh199/adminWork/dbConnectionFunctions.py")
from dbConnectionFunctions import *
import getpass

# script to append column names to an already created mysqldump of .csv files of the database

# prepends given line to given file
def prependLine(file,line):
    with open(file, 'r') as original: # for each file in mydbbackup folder read it 
        data = original.read()
    with open(file, 'w') as modified: # and then append the read to the colHeader and write 
        modified.write(line+ "\n" + data)

# write column names to .csv files produced by mysqldump 
def appendColumnNames(cursor):
    mydbbackupPath = os.path.expanduser('~')+'/dh199/mydbbackup' # get the absolute path to mydbbackup folder 
    for file in os.listdir(mydbbackupPath): # for each of the files in the backup folder 
        query = "SELECT GROUP_CONCAT(CONCAT(\"'\", COLUMN_NAME, \"'\")) FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME='"\
                + file[:-4] + "' ORDER BY ORDINAL_POSITION;" 
        dbConnectionFunctions.runQuery(query,cursor) # query to get all of the column names in order, in a tuple format, from the table name corresponding 
                               # to the file name at hand
        result = cursor # copy cursor results into result
        for colNames in result: # for loop only runs once each time, since one tuple item in result. But can't index result since non-iterable?
            colHeader = str(colNames)[2:-3] # remove leading and trailing parenthesis
            colHeader = colHeader.replace('\'', '"') # change all singe quotes to double in column names 
            prependLine(mydbbackupPath+'/'+file,colHeader) # prepend line of column headers to file

def main():
    print('\nSelect a number corresponding to one of the options below, and hit Enter to continue.\nMust specify a local mysqldb')
    cxnOptions = dbConnectionFunctions.parseOptions() # presents database connection options

    while (1): # keep prompting user until valid option number received 
        optionNumberString = input()
        optionNumber = int(optionNumberString)
        if not (optionNumber >= 0 and optionNumber < len(cxnOptions) and optionNumberString.isnumeric()): 
            print('Please enter a valid option number. Try again.') # optionNumber is either not a number or not in range, try again
        else: 
            break # if valid number end infinite while loop

    cxnParams = cxnOptions[optionNumber] # fetch database connection params pertaining to inputted option number
    if optionNumber==0:
        cxnParams = dbConnectionFunctions.manuallyInputConnection() # manually get user params if option 0 selected

    dbPassword = getpass.getpass(prompt="Input DB password:\n") # gather db password information. Needs to be running in terminal and not 
                                                                # IDLE to ensure that typed characters aren't output on screen
        
    cursor, cnx = dbConnectionFunctions.tryConnection(cxnParams, dbPassword) # attempt opening of connection to the db specified by user 
    appendColumnNames(cursor) # write column names to each of the .csv files produced by mysqldump backup 
    dbConnectionFunctions.closeConnection(cursor, cnx) # close connection and cursor corresponding to it

    print("Completed adding column headers to files. Now about to")
    print("sync files to Google Drive. This may take a few minutes.")

if __name__ == '__main__':
    main()
