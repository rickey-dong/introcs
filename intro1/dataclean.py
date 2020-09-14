sampleSATdata = '''DBN,SCHOOL NAME,Num of SAT Test Takers,SAT Critical Reading Avg. Score,SAT Math Avg. Score,SAT Writing Avg. Score
01M292,HENRY STREET SCHOOL FOR INTERNATIONAL STUDIES,29,355,404,363
01M539,"NEW EXPLORATIONS INTO SCIENCE, TECHNOLOGY AND MATH HIGH SCHOOL",159,522,574,525
02M392,MANHATTAN BUSINESS ACADEMY,s,s,s,s'''

file = open('2012_SAT_Results.csv')
text = file.read()

def splitwithloop(s):
  templist = []
  character = 0
  prevcomma = 0
  prevquote = 0
  endquote = 0
  commawithinquotes = 0
  stringinquotesbeforecomma = ''
  spacestring = ' '
  stringinquoteaftercomma = ''
  quote = False
  while character < len(s):
    if s[character] == '"':
      quote = True
      prevquote = character
      while quote == True:
        character += 1
        if s[character] == ',':
            commawithinquotes = character
        if s[character] == '"':
          quote = False
          endquote = character + 1
          prevcomma = endquote + 1
          character += 1
      stringinquotesbeforecomma += s[prevquote:commawithinquotes]
      stringinquoteaftercomma += s[commawithinquotes + 1:character] 
      templist += [stringinquotesbeforecomma + spacestring + stringinquoteaftercomma]
      character += 1
    if s[character] != ',':
      character += 1
    else: 
      templist += [s[prevcomma:character]]
      prevcomma = character + 1
      character += 1
  templist += [s[prevcomma:]]
  return templist

def cleanSATdata(s):
    newdata = []
    s = s.split('\n')
    row = 0
    while row < len(s):
        newdata += [splitwithloop(s[row])]
        row += 1
    element = 0
    row = 0
    while row < len(newdata):
        element = 0
        while element < len(newdata[row]):
            if (newdata[row])[element].isdigit() == True:
                (newdata[row])[element] = int((newdata[row])[element])
                element += 1
            else:
                element += 1
        row += 1
    return newdata

print(cleanSATdata(sampleSATdata))
#print(cleanSATdata(text))

