def multiplesof3and5(n):
    i = 0
    while n >= 0:
        n = n - 1
        if n % 3 == 0 or n % 5 == 0:
            i = i + n
    return i
    
print(multiplesof3and5(1000))

def sumsquarediff(n):
    i = 0
    j = 0
    while n <= 100:
        i = i + (n** 2)
        j = j + n
        n = n + 1
    return (abs(i- (j ** 2)))

print(sumsquarediff(1))

def smallestmultiple(n):
    i = 0
    while n <= 20:
#COULD NOT SOLVE PROBLEM #5 TOO HARD D;