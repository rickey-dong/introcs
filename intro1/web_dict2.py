d = {
  'headers' : ['Year', 'Manhattan', 'Brooklyn','Queens','Bronx','Staten Island'],
  '1790' : [33131,4549,6159,1781,3827],
  '1800': [60515,5740,6642,1755,4563],
  '1810' : [96373,8303,7444,2267,5347],
  '1820' : [123706,11187,8246,2782,6135],
  '1830' : [202589,20535,9049,3023,7082],
  '1840' : [312710,47613,14480,5346,10965],
  '1850' : [515547,138882,18593,8032,15061],
  '1860' : [813669,279122,32903,23593,25492],
  '1870' : [942292,419921,45468,37393,33029],
  '1880' : [1164673,599495,56559,51980,38991],
  '1890' : [1441216,838547,87050,88908,51693],
  '1900' : [1850093,1166582,152999,200507,67021],
  '1910' : [2331542,1634351,284041,430980,85969],
  '1920' : [2284103,2018356,469042,732016,116531],
  '1930' : [1867312,2560401,1079129,1265258,158346],
  '1940' : [1889924,2698285,1297634,1394711,174441],
  '1950' : [1960101,2738175,1550849,1451277,191555],
  '1960' : [1698281,2627319,1809578,1424815,221991],
  '1970' : [1539233,2602012,1986473,1471701,295443],
  '1980' : [1428285,2230936,1891325,1168972,352121],
  '1990' : [1487536,2300664,1951598,1203789,378977],
  '2000' : [1537195,2465326,2229379,1332650,443728],
  '2010' : [1585873,2504700,2230722,1385108,468730]
  }

def makeatable(dictionary):
    HTMLCode = """
                <table>
                <tr><th>Year</th><th>Manhattan</th><th>Brooklyn</th><th>Queens</th><th>Bronx</th><th>Staten Island</th><tr>"""
    listoftheyears = list(dictionary.keys())
    listoftheyears.remove('headers')
    listofthevalues = list(dictionary.values())
    listofthevalues.remove(['Year', 'Manhattan', 'Brooklyn','Queens','Bronx','Staten Island'])
    valuecounter = 0
    yearcounter = 0
    for year in listoftheyears:
        valuecounter = 0
        HTMLCode += """
                <tr><th>""" + str(listoftheyears[yearcounter]) + """</th><td>"""
        while valuecounter < len(listofthevalues[yearcounter]):
            if valuecounter == 4:
                HTMLCode += str((listofthevalues[yearcounter])[valuecounter]) + """</td></tr>"""
                valuecounter += 1
                if yearcounter != 22:
                    yearcounter += 1
            else:
                HTMLCode += str((listofthevalues[yearcounter])[valuecounter]) + """</td><td>"""
                valuecounter += 1
    HTMLCode += """
                </table>"""
    return HTMLCode

print(makeatable(d))
        
                    
        
    
    