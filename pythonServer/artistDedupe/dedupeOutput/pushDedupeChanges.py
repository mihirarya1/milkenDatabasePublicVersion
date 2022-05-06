
def main():

    # for all the changes that need to be made create a dictionary from the dedupe file
    # which key contains value to change too, and value all the values to be changed to the key. Push these changes on output file

    dedupeResultFile = input("Enter file name for Dedupe result file:\n")
    dedupeResultFile = "dedupeResultFiles/"+dedupeResultFile

    fileToEdit = input("Enter file name for the raw data file to edit:\n")
    altNamesMappingFile = "altNameFiles/"+fileToEdit[:-4]+"DedupeAltNames.csv"
    outFile = "updatedFilesToEdit/"+fileToEdit[:-4]+"DedupeEdited.csv"
    fileToEdit = "filesToEdit/"+fileToEdit
    
    # creates a dict of key being value to change to, and a value of list of all the values which should change to key
    ascns = {}
    val = []
    prev=0
    curr=0
    keyIn=''
    lastColNum = 3
    dataColNum = 2
    
    with open(dedupeResultFile) as dr:
        for line in dr:
            line=line.split(",")
            curr = int(line[0]) # clusterID
            if curr!=prev: # if looking at a new cluster
                prev=curr
                if keyIn!='':
                    ascns[keyIn]=val
                val = []
                keyIn=''
            if line[lastColNum]=='x\n':
                keyIn = line[dataColNum]
            elif line[lastColNum]=='\n':
                val.append(line[dataColNum])
            elif line[lastColNum]=='d\n': # means change output, but in altNames file don't include
                val.append('~'+line[dataColNum])

    # include altNames mapping for all keys, discarding values which shouldn't be included as an altName (ie include the 'd')
    altOut = open(altNamesMappingFile,"w")
    for k in ascns.keys():
        altNames=""
        for i in range(len(ascns[k])):
            if ascns[k][i][0]!="~":
                altNames+=(ascns[k][i][1:]+" | ")
            else:
                ascns[k][i] = ascns[k][i][1:]
        if altNames!="":
            altNames=[:len(altNames)-3]
            altOut.write(k+","+altNames+"\n")


    # for each value find all instances of that value and replace with the key
    # do this for all keys
    out = open(outFile,"w")
    
    with open(fileToEdit) as editFile:
        for line in editFile:
            for key in ascns.keys():
                vals = sorted(ascns[key],key=len)
                vals.reverse()
                for v in vals:
                    line = line.replace(v,key)
            out.write(line)

        
if __name__ == "__main__":
    main()
