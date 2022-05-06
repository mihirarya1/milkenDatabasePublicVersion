def main():
    lines = []
    with open('swoodArtists.csv') as f:
        lines = [line.rstrip() for line in f]

    # lines = sorted(lines, key=len)

    for j in range(len(lines)):
        lines[j] = lines[j].strip()

    #for x in lines:
     #   for y in lines:
     #       if y!=x and y.find(x)!=-1:
     #           lines.remove(x)
     #           break

    for i in range(len(lines)):
        lines[i] = lines[i] + "\n"

    f = open("swoodArtistsModified.csv", "a")
    f.writelines(lines)
    f.close()




if __name__ == "__main__":
    main()
