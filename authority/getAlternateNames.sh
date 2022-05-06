#!/bin/bash

# shell script to write to a specified file, all the viaf generated alternate names for artist names in DB

echo "Enter name for desired output file: "
read outFile # collect output file name in which to store alt name mappings

python3 getViaf.py # run python script to get viaf alt names
sed "s/.$/\"/; s/','/\",\"/; s/^./\"/" altNames.csv > $outFile
rm altNames.csv # delete temp file
