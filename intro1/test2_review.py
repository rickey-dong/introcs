def taxifare(miles, customers):
    if customers < 5:
        return miles * 1.50
    if customers > 5:
        return miles * 2.50
    
print(taxifare(8, 3))
print(taxifare(8, 6))

def onLine(slope, yint, xcor, ycor):
    if ycor == (slope * xcor) + yint:
        return True
    else:
        return False
    
print(onLine(1, 0, 3, 3))
print(onLine(3, 10, 100, 100))

def isLeapYear(year):
    if (year % 400) == 0:
        return True
    elif (year % 4) == 0 and (year % 100) != 0: 
        return True
    else:
        return False
    
print(isLeapYear(2012))
print(isLeapYear(1900))
print(isLeapYear(2000))
print(isLeapYear(1983))

def numOfDigits(n):
    digitscount = 1
    while n / (10 ** digitscount) >= 1:
        digitscount = digitscount + 1
    return digitscount

print(numOfDigits(0))
print(numOfDigits(5))
print(numOfDigits(612))

def sumOfDigits(n):
    totalsum = 0
    divisor = 1
    while n / divisor >= 1:
        totalsum = totalsum + ((n // divisor) % 10)
        divisor = divisor * 10
    return totalsum

print(sumOfDigits(0))
print(sumOfDigits(5))
print(sumOfDigits(612))