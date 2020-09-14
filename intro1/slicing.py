def splitName(s):
    spacebar = s.find(' ')
    return s[:spacebar] + '\n' + s[(spacebar + 1):]

print(splitName("John Shaft"))
print(splitName("Rickey Dong"))

def bondify(s):
    spacebar = s.find(' ')
    return '"' + s[(spacebar + 1):] + '... ' + s + '"'

print(bondify("Mr DW"))
print(bondify("Rickey Dong"))

def findLast(s, c):
    if s.find(c) != -1:
        return (len(s) - 1) - (s[len(s):0:-1] + s[0]).find(c)
    else:
        return -1

print(findLast("hello", "l"))
print(findLast("hello", "h"))
print(findLast("hello", "z"))
print(findLast("lambambambambambambamabambda", "m"))

def replace(original, takeout, replacement):
    if original.find(takeout) == -1:
        return original
    else:
        takeitout = original.find(takeout)
        return original[:takeitout] + replacement + original[(takeitout + len(takeout)):]

print(replace("I hate cs!", "hate", "love"))
print(replace("Tommy used to work on the docks", "Tommy", "Timmy"))
print(replace("I choose you!", "hey", "you"))
print(replace("notebook and pen", "pen", "pencil"))
print(replace("abcdef", "d", "D"))