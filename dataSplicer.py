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



def espace(lst,n=20):
   # print(lst)
    dataPointX = np.linspace(xMin,xMax,n)
    dataPointY = np.zeros(0)
    for coords in range(len(lst)-1):
        y1,y2 = lst[coords][1],lst[coords+1][1]
       # print(y1,y2)
        #linspace [start,stop]
        firstWaveY = np.linspace(y1,y2,10)
        dataPointY = np.concatenate((dataPointY, firstWaveY))

    for m in range(len(lst)-1):
        if m == len(lst) - 2:
            dataPointY = np.delete(dataPointY,10*m)
        else:
            np.delete(dataPointY, 10 * m)

    # dataPointY = [np.delete(dataPointY,10*m) for m in range(len(lst)-1)][-1] horribly inefficient fix!

   # print(len(dataPointX)) #quick check: 20 if 3 entries!

    print(dataPointX)
    print(dataPointY)

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
        for i in range(len(key)):
            d[key[i]] += [(x,v[i])]

    xMax = list(d.values())[0][-1][0]
    xMin = list(d.values())[0][0][0]

for k in key:
    #print(d[k])
    espace(d[k])
   # print("finishito")

# {john: [(x1,y1),(x2,y2)], shishir: [(x1,y1),()]


