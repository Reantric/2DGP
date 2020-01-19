import numpy as np
from scipy.interpolate import make_interp_spline, BSpline
from time import sleep
from timeit import default_timer as timer



# john bandy shishir
# 1 1 4 7
# 2 3 9 21
# 3 5 16 63


# A B C ...
# x1 y1A y1B y1C ...
# x2 y2A y2B y2C ...
# x3 y3A y3B y3C ...
# .
# .
# .


# (400-200)/0.1


# len(lst) - 2 will give you the amount of duplicates!
def espace(data):
    xSpl = [a[0] for a in data[key[0]]]
    dataPointSum = sum(xSpl)
    coords = {x[a]: [] for a in range(numOfDataPoints)}  # gets X values!
    # n param needed for non-splined version!
    # fix edge case! #if n is 20 and we got 4 items, div to 6.666666

    # nMod = numOfDataPoints % (len(dataLst)-1)
    # dataPointY = np.zeros(0)
    # for coords in range(len(dataLst)-1):
    #     if coords == len(dataLst) - 1 - nMod:
    #        n += 1
    #         print(f"This should be printed approximately {nMod} times!")
    #     y1,y2 = dataLst[coords][1],dataLst[coords+1][1]
    # print(y1,y2)
    # linspace [start,stop]
    #   firstWaveY = np.linspace(y1,y2,n)
    #   dataPointY = np.concatenate((dataPointY, firstWaveY))

    # only separate if this is run more than once!, how to add 1 more to list??
    #  for m in range(len(dataLst)-1):
    #   if m == len(dataLst) - 2:
    #     dataPointY = np.delete(dataPointY,n*m)
    #     else:
    #       np.delete(dataPointY, n * m)

    # print(len(dataPointY))  # quick check: 20 if 3 entries!
    for o in data:
        ySpl = [b[1] for b in data[o]]
        negCount = ySpl.count(-1)
      #  sleep(5)
        m = 3
        spl = make_interp_spline(xSpl[negCount:], ySpl[negCount:], k=m)

        limitAmt = int((xSpl[negCount] - xSpl[0])/4)
        zeroList = [-1] * limitAmt
        dataPointY = np.concatenate([zeroList,spl(x[limitAmt:])])
        for u in range(numOfDataPoints):
            coords[x[u]] += [round(dataPointY[u],5)]

    # print(f"Spline object: {spl}: Splined list: {spl(x)}")
    return coords
    # dataPointY = [np.delete(dataPointY,10*m) for m in range(len(dataLst)-1)][-1] horribly inefficient fix!


####PROGRAM OUTPUTS FUNCTIONALLY!
with open("C:\\Users\\arnav\\Desktop\\whyArrayList\\testProj\\test.txt", mode='r+') as f:
    f.seek(0)
    key = f.readline()
    data = f.readlines()
    # print(key)
    # print(file[0])
    key = key.split()
    d = {key[a]: [] for a in range(len(key))}  # python i love you!
    # print(key)
    for v in data:
        v = v.split()
        x = int(v.pop(0))
        v = list(map(int, v))
        # print(v)
        for i in range(len(key)):  ###HUGE CHANGE, REMOVING TUPLE ELEMENT INSIDE LIST! finished
            d[key[i]] += [(x, v[i])]
    # print(d)
    xMax = list(d.values())[0][-1][0]
    xMin = list(d.values())[0][0][0]  # disgusting!

f.close()

numOfDataPoints = int((xMax - xMin) /4)  # make this (max-min)/n where n is spacing
# print(numOfDataPoints)
# numOfDataPoints += (len(d[key[0]])-2)
x = np.linspace(xMin, xMax, numOfDataPoints)  # it does work! (if not, subtract the len thing) nice! - 2020

n = int((numOfDataPoints + (len(d[key[0]]) - 2)) / (len(d[key[0]]) - 1))  # n defined here!

print(f"Val of n: {n}")
# print("AAAAAAAAAA")
print(f"Length of x: {len(x)}")
# {john: [(x1,y1),(x2,y2)], shishir: [(x1,y1),()]

with open("C:\\Users\\arnav\\Desktop\\whyArrayList\\testProj\\datas.txt", mode='w+') as f:
    f.write(' '.join(key) + "\n")
    #  for k in key:
    # print(d[k])
    #     y = espace(d[k])
    #      print(f"Length of y: {len(y)}")
    #      d[k].clear()
    #      d[k] += list(zip(x, y))
    # print(d)
    start = timer()
    print("Calculating")
    coords = espace(d)
    # print(y)
    print("Beginning!")
    # print(" ".join(map(str,coords[x[2]])))
    statement = ""

    for ind in range(numOfDataPoints - 1):
      #  if ind % 400 == 0: tester
       #     print(f"{100 * ind / (numOfDataPoints - 1)}% done!")
        # f.write(f"\n{str(round(x[ind], 3))} ")
        statement += f"{str(round(x[ind], 5))} " + " ".join(map(str, coords[x[ind]])) + "\n"
        # heres the genius! ^^
    f.write(statement)
    end = timer()

    print(f"Finished in {(end-start)} sec")
    #there is no way this will be faster! danggg

    #   for k in key:
    #       writeY = list(d[k])[ind][1]
    ##      statement += str(round(writeY, 3))
    #      if k == key[-1]:
    #          f.write(f"{str(round(writeY, 3))}")
    #       else:
    #         f.write(f"{str(round(writeY, 3))} ")
    # print(f"({x[e]},{3})")
    # print("finishito")

f.close()
print("Now complete!")

# program works! <100 lines !!!!!
