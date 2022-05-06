import sys
import os
homeDir = os.path.expanduser('~')
sys.path.append(homeDir+"/dh199/adminWork/dbConnectionFunctions.py")
from dbConnectionFunctions import *
import getpass

# file to clear all the tables from the specified db at the specified hostname.

# function to remove all the tables in the specified database.
def removeTables(cxnParams,cursor):
        dbConnectionFunctions.runQuery("SHOW TABLES;",cursor)
        tables = cursor # get all the tables in cursor db 
        for table in tables: # remove each table fetched
            dbConnectionFunctions.runQuery("DROP TABLE " + table[0] + ";", cursor)

def main():
    # code to remove all the tables of the specified database, from the specified server
    print('\nSelect a number corresponding to one of the options below, and hit Enter to continue.')
    cxnOptions = dbConnectionFunctions.parseOptions()

    while (1): # keep prompting the user for valid option number until one is given
        optionNumber = int(input())
        if not (optionNumber >= 0 and optionNumber < len(cxnOptions)):
            print('Please enter a valid option number. Try again.')
        else:
            break

    cxnParams = cxnOptions[optionNumber]
    if optionNumber==0:
        cxnParams = dbConnectionFunctions.manuallyInputConnection() # manually fetch connection

    dbPassword = getpass.getpass(prompt="Input DB password:\n")

    print("About to wipe all tables from database",cxnParams['database name'], "from host", cxnParams['hostname'], ".")
    confirm = input("Enter 'c' followed by Enter to confirm, else hit any key followed by Enter\n")
    if confirm!='c':
        exit(0)

    cursor,cnx = dbConnectionFunctions.tryConnection(cxnParams,dbPassword) # open connection
    removeTables(cxnParams,cursor) # remove tables 
    dbConnectionFunctions.closeConnection(cursor,cnx) # close connection

if __name__ == '__main__':
    main()
