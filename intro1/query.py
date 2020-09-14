#!/usr/bin/python
print('Content-type: text/html\n')

import cgi
data = cgi.FieldStorage()

f = open("nyc_pop.csv")
s = f.read()
f.close()

def row_total(row):
    total = 0
    for d in row:
        total += int(d)
    return total

def get_data(s):
    lines = s.split('\n')
    lines.pop(0)
    Data = {}
    for line in lines:
        line = line.split(',')
        Data[line[0]] = line[1:]
        Data[line[0]].append(str(row_total(line[1:])))
    Data.pop('')
    return Data

DataDict = get_data(s)

v = data.getvalue('year')



def query_string():
    if 'year' in data:
        v = data.getvalue('year')
        if v not in DataDict:
            nocensusdata = """<!DOCTYPE html

<html>
    <head>
        <meta charset="utf-8">
        <title>Borough Populations</title>
        <style>
            table, th, td {
            border: 1px solid black;
            }
        </style>
    </head>
    
    <body><h1>No Census Data for """ + str(v) + """</h1></body>

</html>"""
            return nocensusdata
        if v in DataDict:
            datatable = """<!DOCTYPE html

<html>
    <head>
        <meta charset="utf-8">
        <title>Borough Populations</title>
        <style>
            table, th, td {
            border: 1px solid black;
            }
        </style>
    </head>
    
    <body><h1>NYC Population Data for """ + str(v) + """</h1>
<table><tr><th>Year</th><th>Manhattan</th><th>Brooklyn</th><th>Queens</th><th>Bronx</th><th>Staten Island</th><th>Total</th></tr><td>""" + str(v) + """</td><td>""" + str((DataDict[str(v)])[0]) + """</td><td>""" + str((DataDict[str(v)])[1]) + """</td><td>""" + str((DataDict[str(v)])[2]) + """</td><td>""" + str((DataDict[str(v)])[3]) + """</td><td>""" + str((DataDict[str(v)])[4]) + """</td><td>""" + str((DataDict[str(v)])[5]) + """</td></tr></table></body></html>""" 
            return datatable
    else:
        providestring = """<!DOCTYPE html>

<html>
    <head>
        <meta charset="utf-8">
        <title>Borough Populations</title>
        <style>
            table, th, td {
            border: 1px solid black;
            }
        </style>
    </head>
    
    <body><h1>Please provide a year in the query string</h1></body>
    
</html>"""
        return providestring

print(query_string())



