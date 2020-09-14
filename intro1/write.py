def dict_to_str(d):
    dictstr = ''
    listofkeys = list(d.keys())
    listofvalues = list(d.values())
    amtofkeys = 0
    amtofvalues = 0
    amtofsubval = 0
    while amtofkeys < len(listofkeys):
        dictstr += listofkeys[amtofkeys]
        dictstr += ','
        amtofkeys += 1
        amtofsubval = 0
        while amtofsubval < len(listofvalues[amtofvalues]):
            if (listofvalues[amtofvalues])[amtofsubval] != (listofvalues[amtofvalues])[(len(listofvalues[amtofvalues])) - 1]:
                dictstr += str((listofvalues[amtofvalues])[amtofsubval])
                dictstr += ','
                amtofsubval += 1
            else:
                dictstr += str((listofvalues[amtofvalues])[amtofsubval])
                dictstr += '\n'
                amtofsubval += 1
                amtofvalues += 1
                if amtofvalues == len(listofvalues):
                    amtofvalues -= 1
    return dictstr

dICT = {'a': [1, 2, 3],'b': [4, 5, 6],'c': [7, 8, 9]}

csvValues = dict_to_str(dICT)

f = open('writecsvfile.csv', 'w')
f.write(csvValues)
f.close()