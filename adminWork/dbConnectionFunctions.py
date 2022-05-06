from csv import reader
import mysql.connector as sqlConn
import getpass

# this file contains helper functions pertaining to connecting to the database, specifying which database to connect to, 
# running queries, etc. Such helper functions are used both in folders 'dbBackup' and 'pushToServer'.


def parseOptions(): 

    options = {0: "Manually input database connection parameters"} # options will contain option number to said option number's 
                                                                   # database connection input parameters
    print('0 :',options[0]) # display default option

    with open('dbConnectionOptions.csv', 'r') as file:
        csv_reader = reader(file) # read file as csv
        i=1 # maintains the options number
        for row in csv_reader: # row represents a line in csv file in list form
            if len(row)!=3: # must contain only three elements per line
                print('Improperly formatted file dbConnectionOptions.csv\n')
                exit(0)
            else:
                options[i] = {'hostname': row[0], 'username': row[1] ,'database name': row[2]} # maintain mapping of optionNumber -> (hostname,username,db-name)
                print(str(i),":",str(options[i])[1:-1]) # print the option number followed by the number's 
                                                        # dictionary value itself (without the end '{' or '}')
                i+=1
    return options

# attempt to open a database connection to the specified db in params, with specified password pWord
def tryConnection(params,pWord): 
    cursor,cnx = '',''
    try:  # first establish connection to the db
        cnx = sqlConn.connect(user=params['username'], password=pWord,
                              host=params['hostname'], database=params['database name']) # open connection using sqlConn
        cursor = cnx.cursor(buffered=True)  # then set a cursor
    except sqlConn.Error as e:  # if connection doesn't work at any time then will throw error and exit
        print("Connection error as follows:")
        print(e)
        exit(1)
    return cursor, cnx

def closeConnection(cursor,cnx):
    cursor.close()
    cnx.close()

# function to manually collect and return a dictionary of user inputted database connection params
def manuallyInputConnection(): 
    params = {'hostname':'','username':'','database name':''}
    params['hostname'] = input("Enter host containing target DB:\n")
    params['username'] = input("Input DB username:\n")
    params['database name'] = input("Enter target DB name on this host:\n")
    return params # return dictionary to main method

# run the given query, for given cursor
def runQuery(query,cursor):
    try:
        cursor.execute(query)
    except sqlConn.Error as e:  # if query error, throw error and abort 
        print("Connection error as follows:")
        print(e)
        exit(1)
    return cursor
