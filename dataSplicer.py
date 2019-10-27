with open("C:\\Users\\arnav\\Desktop\\graphProj\\test.txt", mode='r+') as f:
    f.seek(0)
    key = f.readline()
    s = []; x = []; y = []
    file = f.readlines()
    #print(key)
   # print(file[0])
    key = key.split()
    d = {key[a]:[] for a in range(len(key))} #python i love you!
   # print(key)
    for v in file:
        v = v.split()
        x = int(v.pop(0))
        print(x)
        v = list(map(int,v))
        print(v)
        for i in range(len(key)):
            d[key[i]] += [(x,v[i])]

    print(d)

# {john: [(x1,y1),(x2,y2)], shishir: [(x1,y1),()]