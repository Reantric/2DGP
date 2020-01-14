from time import sleep
import csv
import pandas as pd

f = 0


def learn():
    global f
    with open("bitcoindata.csv") as csvfile:
        readCSV = csv.reader(csvfile, delimiter=",")  # 635719
        c = 0
        for x in readCSV:
            f += 1
            c += 1
            if (f > 635719 or c % 60 != 0) and c % 360 != 0 or 'NaN' in x:
                continue

            c = 0
            yield x


j = 0
numberOfBC = 0
with open("bitcoinTester.txt",mode="w") as bitcoinFile:

    for x in learn():
        if j == 0:
            j += 1
            continue
        j += 1
        # numberOfBC += float(x[5])
        # print(list(map(int,x[2:4])))
        bitcoinFile.write(f"{x[0]} {float(x[7])}\n")

        # sleep(0.5) #2 and 3 avg!
    print(f"{j} items in filtered dataset (Prev DS: >{j * 86400} items)")
    #print(f)
    bitcoinFile.close()
    # pd.read_csv("bitcoindata.csv",index_col="Type",squeeze=True)
