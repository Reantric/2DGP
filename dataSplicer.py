import numpy as np

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

numOfDataPoints = 20

def espace(lst):
   # print(lst)
    diff = 0
    n = int(numOfDataPoints/(len(lst)-1)) #fix edge case! #if n is 20 and we got 4 items, div to 6.666666
    #print(f"New n is {n}")
    dataPointY = np.zeros(0)
    for coords in range(len(lst)-1):
        diff += n/(len(lst)-1)
        if diff > (n - len(lst) - 1):
          #  print("alright. I have arrived !")
          pass
        y1,y2 = lst[coords][1],lst[coords+1][1]
       # print(y1,y2)
        #linspace [start,stop]
        firstWaveY = np.linspace(y1,y2,n)
        dataPointY = np.concatenate((dataPointY, firstWaveY))

    for m in range(len(lst)-1):
        if m == len(lst) - 2:
            dataPointY = np.delete(dataPointY,n*m)
        else:
            np.delete(dataPointY, n * m)


    print(len(dataPointY))  # quick check: 20 if 3 entries!
    return dataPointY
    # dataPointY = [np.delete(dataPointY,10*m) for m in range(len(lst)-1)][-1] horribly inefficient fix!




   ####PROGRAM OUTPUTS FUNCTIONALLY!
with open("C:\\Users\\arnav\\Desktop\\graphProj\\test.txt", mode='r+') as f:
    f.seek(0)
    key = f.readline()
    s = []; x = []; y = []
    data = f.readlines()
    #print(key)
   # print(file[0])
    key = key.split()
    d = {key[a]:[] for a in range(len(key))} #python i love you!
   # print(key)
    for v in data:
        v = v.split()
        x = int(v.pop(0))
       # print(x)
        v = list(map(int,v))
       # print(v)
        for i in range(len(key)): ###HUGE CHANGE, REMOVING TUPLE ELEMENT INSIDE LIST! finished
            d[key[i]] += [(x,v[i])]
    print(d)
    xMax = list(d.values())[0][-1][0]
    xMin = list(d.values())[0][0][0]
f.close()

#print(numOfDataPoints)
x = np.linspace(xMin,xMax,numOfDataPoints - (len(d[key[0]])-2))
#print("AAAAAAAAAA")
#print(len(x))
# {john: [(x1,y1),(x2,y2)], shishir: [(x1,y1),()]

with open("C:\\Users\\arnav\\Desktop\\graphProj\\datas.txt", mode='w+') as f:
    f.write(' '.join(key))
    for k in key:
        # print(d[k])
        y = espace(d[k])
        d[k].clear()
        d[k] += list(zip(x,y))
    #print(d)
    for ind in range(numOfDataPoints - 1):
        f.write(f"\n{str(round(x[ind],3))} ")
        for k in key:
            writeY = list(d[k])[ind][1]
            f.write(f"{str(round(writeY,3))} ")
        #print(f"({x[e]},{3})")
    # print("finishito")


f.close()

#program works! <100 lines !!!!!