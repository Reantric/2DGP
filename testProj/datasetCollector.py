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
        readCSV = readCSV.iloc[(readCSV.index < 630000) | (readCSV.index % 120 == 0)]  # every 2 hours!
        # readCSV = readCSV.iloc[0::5] #change 0 to something..?
        csvfile.close()

    with open("bitcoinTester.txt", mode="w") as b:
        b.write(readCSV.to_csv(sep=' ',line_terminator="\n", index=False)[:-1])
        b.close()


learn()
