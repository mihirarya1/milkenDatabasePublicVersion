
import csv
import re
from csv import reader
import os

def main():
    
    outputTrackRoleArtist = open("swoodtrackRoleArtist.csv","w")
    
    with open ("SpottswoodNew.csv") as sw:
        csv_reader = reader(sw)
        for line in csv_reader:
            cell=re.split(",|;",line[14]) # extract all the artists from arrangers/composers/singers separately
            for i in range(len(cell)): # first break up by , and ;
                andPos = cell[i].find('&')
                l=1
                if andPos==-1:
                    andPos = cell[i].find('and')
                    l=3
                if andPos==-1:
                    andPos = cell[i].find('And')
                    l=3
                if andPos!=-1:
                    leftParen = cell[i].find('(')
                    rightParen = cell[i].find(')')
                    cell.append( cell[i][(andPos+l):leftParen] + cell[i][leftParen:(rightParen+1)] ) # append guy to right of and, along with his instrument as a new row
                    cell[i] = ( cell[i][0:andPos] + cell[i][leftParen:(rightParen+1)] ) # relable current row to only have guy on left of and, along with his instrument

                    
                    
            mainPerformerListed = False
            for q in range(len(cell)):
                mainArtist="No"
                if cell[q].find(line[4])!=-1:
                    mainPerformerListed = True
                    mainArtist="Yes"
                
                leftParen = cell[q].find('(')
                rightParen = cell[q].find(')')
                artist = cell[q][0:leftParen]
                role = cell[q][(leftParen+1):rightParen]
                if role=="" and artist=="":
                    continue

                if (len(artist)>0 and artist[-1]=="\""):
                    artist+="\""

                
                outputTrackRoleArtist.write( "\"" + line[0].strip() + "\",\"" + role.strip() + "\",\"" + artist.strip() + "\"" + ",\"" + mainArtist + "\"")
                #outputTrackRoleArtist.write( line[0].strip() + "," + role.strip() + "," + artist.strip()  + "," + mainArtist ) 
                outputTrackRoleArtist.write("\n")
                
            if mainPerformerListed == False:
                firstInstrumentRightLoc = line[13].find(",")
                if firstInstrumentRightLoc == -1:
                    firstInstrument = line[13]
                else:
                    firstInstrument = line[13][0:firstInstrumentRightLoc]
                if firstInstrument.strip()=="" and line[4].strip()=="":
                    break

                if (len(line[4])>0 and line[4][-1]=="\""):
                    line[4]+="\""
                
                outputTrackRoleArtist.write( "\"" + line[0] + "\",\"" + firstInstrument.strip() + "\",\"" + line[4].strip()+ "\"" + ",\"" + "Yes" + "\"")
                #outputTrackRoleArtist.write( line[0] + "," + firstInstrument.strip() + "," + line[4].strip()+ "," + "Yes" )                                                
                outputTrackRoleArtist.write("\n")
                
            # split about '&'
            # create dictionary mapping
            # print dictionary mapping out to some file

if __name__ == "__main__":
    main()
B
