from time import sleep
import csv
import pandas as pd

f = 0


def learn():
    global f
    with open("bitcoindata.csv") as csvfile:
        readCSV = pd.read_csv(csvfile, delimiter=",")  # 635719
       # print(pd.DataFrame(readCSV))
        c = 0
        readCSV = readCSV.filter(["Timestamp", "Weighted_Price"]).dropna()
        # eadCSV.dropna(thresh=1)
        print(readCSV)



learn()

# j = 0
# with open("bitcoinTester.txt",mode="w") as bitcoinFile:
#  next(learn())
# for x in learn():
#  j+=1
# numberOfBC += float(x[5])
# print(list(map(int,x[2:4])))
#      bitcoinFile.write(f"{x[0]} {float(x[7])}\n")

# sleep(0.5) #2 and 3 avg!
#  print(f"{j} items in filtered dataset (Prev DS: > {f} items")
# print(f)
#   bitcoinFile.close()
# pd.read_csv("bitcoindata.csv",index_col="Type",squeeze=True)
