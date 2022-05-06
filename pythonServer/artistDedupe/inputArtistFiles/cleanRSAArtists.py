import csv
import numpy
import itertools
import re

def main():
    data = csv.reader(open('rsaArtists.csv','r'))
    artists=[]
    for row in data:
        artists+=row

    for i in range(len(artists)):
        artists[i]= re.split(";|,|&",artists[i])
    artists = list(itertools.chain(*artists))

    out = open("cleanRSAArtists.csv", "w")
    compiled = re.compile(re.escape("cantor"), re.IGNORECASE)
    for a in range(len(artists)):
        artists[a]=compiled.sub('',str(artists[a])) 
        artists[a]=artists[a].strip()
        #out.write("\""+artists[a]+"\"\n")
    artists=set(artists)

    for artist in artists:
        out.write("\""+artist+"\"\n") 


if __name__ == "__main__":
    main()
