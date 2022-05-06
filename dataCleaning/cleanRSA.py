import csv
import numpy
def main():
    data = list(csv.reader(open('rsaClean.csv','r')))
    data = numpy.array(data)
    data = data[numpy.argsort(data[:, 1])]


    # first delete all entirely duplicate rows 
    count=0
    d1 = data[:,1]
    k = len(d1)
    for j in range(1,k):
        if d1[j]==d1[j-1] and data[j,3]==data[j-1,3] and data[j,2]==data[j-1,2] and data[j,4]==data[j-1,4] and data[j,5]==data[j-1,5] and data[j,6]==data[j-1,6]:
            numpy.delete(data,(j),axis=0)
            j-=1

    
    count=0
    for l in range(1,k):
        if data[j,1]==data[j-1,1] and data[j,3]==data[j-1,3]:
            count+=1
    print(count)

    
    
if __name__ == "__main__":
    main()
