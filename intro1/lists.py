def makeListOneToN(n):
  l = []
  counter = 1
  while n >= counter:
    l.append(counter)
    counter = counter + 1
  return l

def makeEvenListToN(n):
  l = []
  counter = 0
  while n >= counter:
    if counter % 2 == 0: 
      l.append(counter)
    counter = counter + 1
  return l

def makeSentence(L):
  index = 0
  l = ''
  while index < len(L):
    if len(L) <= 1:
      l = l + L[index]
      index = index + 1
    else:
      l = l + L[index]
      if index != (len(L) - 1): 
        l = l + ' '
      index = index + 1
  return l

def makeFibList(n):
   l = []
   position = 0
   if n == 0:
     l.append(0)
     return l
   if n == 1:
     l.append(0)
     l.append(1)
     return l
   while position <= n:
     if position == 0:
       l.append(0)
       position = position + 1
     if position == 1:
       l.append(1)
       position = position + 1
     l.append((l[position - 2] + l[position - 1]))
     position = position + 1
   return l

def testRemoveNegatives(L,x,y):
  l = []
  position = 0
  while position < len(L):
    if L[position] <= x or L[position] >= y:
      l += [L[position]]
    position += 1
  return l

def testMoveNegatives(L):
  position = 0
  n = 0
  while position < len(L):
    if L[n] < 0:
      L.append(L[n])
      L.remove(L[n])
    else:
      n += 1
    position += 1
  return L

def testReverseWithCaps(L):
  listposition = 0
  stringposition = 0
  l = []
  while listposition < len(L):
    if (L[listposition])[stringposition] == "Z" or (L[listposition])[stringposition] == "Y" or (L[listposition])[stringposition] == "X" or (L[listposition])[stringposition] == "W" or (L[listposition])[stringposition] == "V" or (L[listposition])[stringposition] == "U" or (L[listposition])[stringposition] == "T" or (L[listposition])[stringposition] == "S" or (L[listposition])[stringposition] == "R" or (L[listposition])[stringposition] == "Q" or (L[listposition])[stringposition] == "P" or (L[listposition])[stringposition] == "O" or (L[listposition])[stringposition] == "N" or (L[listposition])[stringposition] == "M" or (L[listposition])[stringposition] == "L" or (L[listposition])[stringposition] == "K" or (L[listposition])[stringposition] == "J" or (L[listposition])[stringposition] == "I" or (L[listposition])[stringposition] == "H" or (L[listposition])[stringposition] == "G" or (L[listposition])[stringposition] == "F" or (L[listposition])[stringposition] == "E" or (L[listposition])[stringposition] == "D" or (L[listposition])[stringposition] == "C" or (L[listposition])[stringposition] == "B" or (L[listposition])[stringposition] == "A":
      l += (L[listposition])[::-1]
    else:
      l += (L[listposition])[stringposition]
    listposition += 1
    stringposition += 1
  return l
#could not solve this problem

