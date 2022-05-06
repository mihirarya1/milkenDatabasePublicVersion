PURPOSE:

This folder pertains to fetching all the alternate names for a particular artist name appearing 
in the artists table in the database. The resulting output file, contains mappings in the format:
"altMapping1 | altMapping2 | ... altMappingN","originalName". You can specify a query to fetch 
all DB artist names, or just use the default query which is displayed when you run the script.

FILE DESCRIPTIONS: 

getAlternateNames.sh is a script which asks a user the filename to write viaf results to, and then 
runs  getViaf.py. To begin creating the alternate names output file, run './getAlternateNames.sh'. 
Keep in mind that the script can take a while to run, since an HTTP request is being made to VIAF for 
every single artist in the artists table! getViaf.py, asks the user for a query to get all the artist
names from, and then queries VIAF for each of those names, writing the results to a temp file called
altNames.csv. dbConnectionOptions.csv contains hostname,username,database tuples, to be presented to 
the user in getViaf.py.

DEPENDENCIES:

getAlternateNames.sh: existence of getViaf.py, getViaf.py writing output results to a temporary
file called 'altNames.csv', user specified outfile name

getViaf.py: module ~/dh199/adminWork/dbConnectionFunctions.py, user given database parameters, 
dbConnectionOptions.csv, specified user query to fetch artists, 

dbConnectionOptions.csv: user given db parameter tuples
