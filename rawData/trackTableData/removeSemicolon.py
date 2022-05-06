input_file = (open("trackTableMilken.csv", "r")).readlines()
output_file = open("a.csv", "w")

for line in input_file:
    line = list(line)
    for i in reversed(range(len(line))):
        if (line[i]=="," or line[i]==";" or line[i]==" "):
            line.pop(i)
        elif (line[i]=="\"" or line[i]=="\n"):
            continue
        else:
            #print(str(line))
            output_file.write(''.join(line))
            break
