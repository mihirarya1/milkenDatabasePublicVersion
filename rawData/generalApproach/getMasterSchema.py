
def main():
    lines = []
    with open('tableNames.csv') as f:
        tables = [line.rstrip() for line in f]

    with open('columnList.csv') as g:
        attributes = [line.rstrip() for line in g]

#    print(attributes)
    i=1
    print(tables[0])
    for j in attributes:
        if j=="COLUMN_NAME":
            print("\n")
            print((tables[i]).upper())
            i=i+1
        else:
            print(j)
            
if __name__ == "__main__":
    main()

    
