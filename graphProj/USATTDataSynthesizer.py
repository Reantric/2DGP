from math import log2
import time


def datePass(date1, date2):
    '''Returns True if date1 > date2'''
    month1 = int(date1[:2])
    day1 = int(date1[3:5])
    year1 = int(date1[6:])
    month2 = int(date2[:2])
    day2 = int(date2[3:5])
    year2 = int(date2[6:])

    if year1 > year2:
        return True
    elif year1 == year2:
        if month1 > month2:
            return True
        elif month1 == month2:
            if day1 > day2:
                return True
            else:
                return False
        else:
            return False
    else:
        return False


date = "05/31/2015"


#
def binSearch(item, lst):
    end = len(lst)
    mid = int(end / 2)
    for x in range(int(log2(end) + 3)):
        print(lst[mid])
        print(item)
        print(datePass(item, lst[mid]))
        # time.sleep(2)
        if datePass(item, lst[mid]):  # item > lst
            temp = mid
            mid = int((end + mid) / 2)
            end = temp
        elif datePass(lst[mid], item):  # lst > item
            end = mid
            mid = int(mid / 2)
        else:  # will default here!
            return mid


def search(item, lst):
    a = 0
    for x in lst:
        if not datePass(item, x):  # if item > x
            return a
        a += 1


secondaryFile = open("two.txt", "r")
mainFile = open("one.txt", "r")
originalKey = mainFile.readline()[:-1]
newKey = originalKey + " " + secondaryFile.readline()[:-1] + "\n"  # 1st line!

secondaryContent = secondaryFile.readlines()
mainContent = mainFile.readlines()

mainDates = [c.split()[0] for c in mainContent]
# mainValues = [c.split()[1] for c in mainContent]
secondaryDates = [d.split()[0] for d in secondaryContent]
secondaryValues = [d.split()[1] for d in secondaryContent]
# print(newKey)
print(mainDates)
print(secondaryDates)
empty = " -" * len(originalKey.split())
secondaryFile.close()
mainFile.close()

for date in secondaryDates:
    currentSecInd = secondaryDates.index(date)
    if date in mainDates:
        #   print("Appending!")
        i = mainDates.index(date)

        mainContent[i] = mainContent[i][:-1] + f" {secondaryValues[currentSecInd]}\n"
        # print(mainContent)
    else:  # date was not present, add in a " -" * amt of keys!
        ind = search(date, mainDates)
        #  print(f"Date: {date}, where to place it?: {ind}")
        mainDates.insert(ind, secondaryDates[currentSecInd])
        mainContent.insert(ind, f"{secondaryDates[currentSecInd]}{empty} {secondaryValues[currentSecInd]}\n")
    #   print(ind)
    # print(mainContent)
for a in range(len(mainContent)):
    #print(len(mainContent[a][10:].split()))

    if len(mainContent[a][10:].split()) < 1 + len(originalKey.split()):
        # 05/31/2015 562 --> #05/31/2015 562 -
        mainContent[a] = mainContent[a][:-1] + " -" * ((1 + len(originalKey.split())) - len(mainContent[a][10:].split())) + "\n"

print(mainContent)

with open("one.txt", mode="w+") as f:
    f.write(newKey)
    f.writelines(mainContent)
