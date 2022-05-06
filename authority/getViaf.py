import requests
import json
import mysql.connector as sqlConn
import os
import getpass

def writeName(altNames,obj):
        # parse and write viaf given results for person to outfile specified by altNames
        
        altNameList = ""
        for entry in obj['result']: # for each returned name by viaf
            altNameList= altNameList + entry['term'] + " | " # add said name to alternate name list for person at hand
            
        altNameList=altNameList[:len(altNameList)-3] # remove the " | " trailing last person's name
        altNames.write( "\'" + altNameList.replace("'","''") + "\',\'" + (name[1]).replace("'","''") + "\'\n" ) 
        
        # after mapping each single quote to two single quotes for output purposes, append the altNames list  and the name to which
        # they correspond in a single line, and write that line to the output file selected earlier
    

def queryViaf(artistNames):
    # query viaf for each name found earlier, and call a function to print the viaf results for said person if results are valid
    
    altNames = open("altNames.csv", "w") # output file
    print("Running the viaf queries now! This can take a long time depending on the number of artists for which we're running a query on viaf's API.")
    
    for name in artistNames: # iterate through all of the artists
        adr = 'http://www.viaf.org/viaf/AutoSuggest?query=' + name[0] # addr url to query
        try:
            r=requests.get(adr,timeout=45) # if no response received from viaf after 45s, give up on this name
        except:
            altNames.write( "\'Timeout\',\'" + (name[1]).replace("'","''") + "\'\n" ) # error message if timeout
            continue
        obj = r.json() # viaf results naturally in json format, obj converts them to python dictionary format for ease of use
        if obj['result']==None: # if no names returned based on viaf query, go to next name
            continue    
        writeName(altNames,obj) # write results in obj to altNames

def main():

    # Code to write to in a output file, a mapping from each artist name in the artists table, to that artists alternate names as given by viaf.org.

    # query the database for all of the artists stored in it
    # send http request for every single artist name in artist table                                                                                                               
    # read http json response into a python dictionary 
    # from this dictionary concatenate all alternate names for each result-entry into a string, with | used to separate alternate names

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

    cursor,cnx = dbConnectionFunctions.tryConnection(cxnParams,dbPassword) # open connection
    
    # Get user input query to get all artists.
    fetchArtistQuery = input("Input a query to fetch artist names from the appropriate table\nIf you want to use the default query 'SELECT artistName FROM artists' hit Enter\n")
    if fetchArtistQuery=="":
        fetchArtistQuery = ("SELECT artistName FROM artists")
   
    dbConnectionFunctions.runQuery(fetchArtistQuery,cursor)
    artistNames = []
    for name in cursor:
        artistNames.append( [ (name[0].strip()).replace(' ','+') , name[0] ] ) # for each name create a mapping of that name to that name with spaces separated by '+'
                                                                               # this is since the HTTP requests we'll make next don't accept spaces
    dbConnectionFunctions.closeConnection(cursor,cnx) # close connection

    queryViaf(artistNames)
   
   

if __name__ == "__main__":
    main()
