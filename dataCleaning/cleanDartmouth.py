import csv
import re
import numpy
def main():
    data = list(csv.reader(open('dartmouth_data.csv','r')))
    data = numpy.array(data)
    data = data[numpy.argsort(data[:, 0])]


    # first delete all entirely duplicate rows 
    count=0
    d1 = data[:,0]
    k = len(d1)
    for j in range(1,k):
        if d1[j]==d1[j-1] and data[j,1]==data[j-1,1] and data[j,2]==data[j-1,2]:
            numpy.delete(data,(j),axis=0)
            j-=1
            count+=1

    # extract track-albumNumber on condition: number is 0th index of either albumName or trackName, another number immediately follows this first number, or we have a dash and another number, or we have another number followed by dash and a number or two...
    # remove all .mp3 occurences first too

    count=0
    f = open("dmouthMain.csv", "a")
    g = open("dmouthAlbum.csv","a")
    for l in range(0,k):
        data[l,0]=str(data[l,0])
        data[l,1]=str(data[l,1])
        data[l,2]=str(data[l,2])
        data[l,1]=data[l,1].replace(".mp3","")
        data[l,2]=data[l,2].replace(".mp3","")

        additional=""
        x = re.search("(^\d+.\d+)|(^\d+\d+)|(^\d+)",(data[l,2]))
        if (x!=None):
            additional=x.group()
            data[l,2]=data[l,2].replace(additional,"")
            
        y = re.search("(^\d+.\d+)|(^\d+\d+)|(^\d+)",(data[l,1]))
        if (y!=None):
            if additional!="":               
                count+=1
            additional=y.group()
            data[l,1]=data[l,1].replace(additional,"")

        g.write("A"+str(l+1)+","+data[l,1])
        g.write("\n")
        f.write("D"+str(l+1)+","+(str(data[l,0])+","+str(data[l,1])+","+str(data[l,2])+","+str(additional)).rstrip(","))
        f.write("\n")

    print(count)
    
if __name__ == "__main__":
    main()
