import csv
import re

def main():

    # from the csv file, map any multi-line space to a single space, and for each column remove whitespace at beginning or end of cell in column
    
    editFile = input("Enter file name for file to clean spaces on:\n")
    editFile = "filesToEdit/"+editFile

    lines=[]
    with open(editFile) as f:
        reader = csv.reader(f)
        for line in reader:
            for i in range(len(line)):
                line[i]=line[i].strip()
            line = ",".join(line)
            line = re.sub('\s+',' ',line)
            lines.append(line+"\n")

    f.close()
    f = open(editFile,"w")
    for line in lines:
        f.write(line)

if __name__ == "__main__":
    main()
