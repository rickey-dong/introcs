def findLetter(original,letter):
  position = 0
  while position < len(original):
        if letter == original[position]:
            return position
        position += 1
  return -1

def countLetter(string,letter):
  lettercount = 0
  position = 0
  while position < len(string):
    if letter == string[position]:
      lettercount = lettercount + 1
    position = position + 1
  return lettercount

def isVowel(s):
  if s == 'a' or s == 'e' or s == 'i' or s == 'o' or s == 'u' or s == 'A' or s == 'E' or s == 'O' or s == 'I' or s == 'U':
    return True
  else:
    return False

def isVowel(s):
  if s == 'a' or s == 'e' or s == 'i' or s == 'o' or s == 'u' or s == 'A' or s == 'E' or s == 'O' or s == 'I' or s == 'U':
    return True
  else:
    return False

def countVowels(s):
  position = 0
  vowelcount = 0
  while position < len(s):
    if isVowel(s[position]):
      vowelcount = vowelcount + 1
    position = position + 1
  return vowelcount

def isCaps(s):
  return s == "Z" or s == "Y" or s == "X" or s == "W" or s == "V" or s == "U" or s == "T" or s == "S" or s == "R" or s == "Q" or s == "P" or s == "O" or s == "N" or s == "M" or s == "L" or s == "K" or s == "J" or s == "I" or s == "H" or s == "G" or s == "F" or s == "E" or s == "D" or s == "C" or s == "B" or s == "A" 

def hasThreeCaps(s):
  position = 0
  while position < len(s) - 2:
    if isCaps(s[position]) and isCaps(s[position + 1]) and isCaps(s[position + 2]):
      return True
    position = position + 1
  return False

def isCaps(s):
  return s == "Z" or s == "Y" or s == "X" or s == "W" or s == "V" or s == "U" or s == "T" or s == "S" or s == "R" or s == "Q" or s == "P" or s == "O" or s == "N" or s == "M" or s == "L" or s == "K" or s == "J" or s == "I" or s == "H" or s == "G" or s == "F" or s == "E" or s == "D" or s == "C" or s == "B" or s == "A" 

def noConsecutiveCaps(s):
  position = 0
  while position < len(s) - 1:
    if isCaps(s[position]) and isCaps(s[position + 1]):
      return False
    position = position + 1
  return True

def wordinhere(word):
  positionofword = 0
  
#could not figure out the challenge problem

def findWord(original,word):
  positionoforiginal = 0
  while positionoforiginal < len(original):
    if wordinhere(word[positionoforiginal]) and wordinhere(word[positionoforiginal + len(word)]):
      return positionoforiginal
    positionoforiginal = positionoforiginal + 1
  return positionoforiginal
  
#could not figure out the challenge problem
      