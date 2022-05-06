import csv
import re
from csv import reader
import os

def main():
    
    outputTrackRoleArtist = open("swoodtrackRoleArtist.csv","w")
    
    with open ("SpottswoodNew.csv") as sw:
        csv_reader = reader(sw)
        for line in csv_reader:
            arrangersComposersPerformers = re.split(",",line[15]) # extract all the artists from arrangers/composers/singers separately
            arrangersComposersPerformers = [i.strip() for i in arrangersComposersPerformers]
            
            mainArtists = re.split(",",line[3])
            mainArtists = [j.strip() for j in mainArtists]
            
            firstInstrumentRightLoc = line[13].find(",")
            if firstInstrumentRightLoc == -1:
                firstInstrument = line[13]
            else:
                firstInstrument = line[13][0:firstInstrumentRightLoc]

            for i in range(len(mainArtists)):
                mainArtists[i]+=(" ("+firstInstrument+")")

            for m in range(len(mainArtists)):
                for a in range(len(arrangersComposersPerformers)):
                    if mainArtists[m].lower() == arrangersComposersPerformers[a].lower():
                        arrangersComposersPerformers[a]="DELETE"
                    
            for l in range(len(mainArtists)):
                mainArtists[l]+="*"

            trackID=line[0].strip()
            mainArtists+=arrangersComposersPerformers
            for mainArtist in mainArtists:
                if mainArtist=="DELETE":
                    continue
                leftParen = mainArtist.find('(')
                rightParen = mainArtist.find(')')
                artist = mainArtist[0:leftParen]
                role = mainArtist[(leftParen+1):rightParen]
                isMainArtist="No"
                if role=="" and artist=="":
                    continue
                if mainArtist[-1:]=="*":
                    isMainArtist="Yes"
                if (len(artist)>0 and artist[-1]=="\""):
                    artist+="\""

                outputTrackRoleArtist.write( "\"" + trackID + "\",\"" + role.strip() + "\",\"" + artist.strip() + "\",\"" + isMainArtist + "\"\n")
                 
            # split about '&'
            # create dictionary mapping
            # print dictionary mapping out to some file

if __name__ == "__main__":
    main()
