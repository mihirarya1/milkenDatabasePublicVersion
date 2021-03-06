import nltk
from nltk.corpus import stopwords
import csv
import re

def main():
    inputFile = input("Enter input artist name file:\n")
    outputFile = input("Enter output file to which results will be wrote:\n")
    
    data = csv.reader(open(inputFile,'r'))
    artists = []
    for row in data:
        artists.append(str(row))


    pronounLikeWords = [ 'chorus','choir','arr','comp','composer','dir', 'cong', 'cond', 'comp', 'company', 'ensemble', 'orch', 'orchestra', 'band', 'lyrics', 'conductor' , 'he' , 'his' , 'him', 'she', 'her', 'hers', 'their' ] 
    acceptedPosTags = ['GPE','PERSON'] # 'NNP' for Penn too

        # if length is too long, or contains a pronoun, or doesn't contain one of the acceptedPosTags, split into a new row. 
    for i in range(len(artists)):
        artists[i] = re.sub('\s+',' ',artists[i])
        artists[i] = artists[i].strip()
        splitRow = re.split(";|,|&|\sand\s",artists[i])
        if len(splitRow)==1:
            continue
        for p in range(1,len(splitRow)): # iterate splitRow
            if len(splitRow[p])<7:
                continue
            nRow = nltk.tokenize.word_tokenize(splitRow[p])
            nRow = (nltk.pos_tag(nRow))
            nRow = str(nltk.ne_chunk(nRow,binary=False))
                      
            if any(pronounLikeWord in splitRow[p].lower() for pronounLikeWord in pronounLikeWords):
                continue
            if any(acceptedPosTag in splitRow[p].lower() for acceptedPosTag in acceptedPosTags):  # create new row
                artists[i].append(splitRow[p].split())
                splitRow[p]=""
        q=0
        while q < len(splitRow):
            if splitRow[q]=='':
                splitRow.pop(q)
                q-=1
            q+=1
        if len(splitRow)==1:
            artists[i]=splitRow[0].strip()
        else:
            artists[i] = (' AND '.join(splitRow)).strip()

    artists = list(set(artists))
    outputFile.write("artistName")
    for a in artists:
        if artists[a][0]!='"':
            artists[a]='"'+artists[a]
        if artists[-1]!='"':
            artists[a]+='"'
        outputFile.write(artists[a]+"\n")
                      
if __name__ == "__main__":
    main()
