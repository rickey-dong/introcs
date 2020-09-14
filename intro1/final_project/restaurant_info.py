#!/usr/bin/python                           
print('Content-type: text/html\n')

import datetime
import ast
import cgi
import cgitb
cgitb.enable()
data = cgi.FieldStorage()
CAMIS = data.getvalue('CAMIS')
import random

f = open("nyc_food_inspect.txt", encoding='utf-8')
restaurantString = f.read()
f.close()

f = open("perm_info.txt", encoding='utf-8')
perm_info = f.read()
f.close()

f = open("restaurant_info_template.html")
tableSkeleton = f.read()
f.close()
#=====================================================================
perm_info = ast.literal_eval(perm_info)

def date(s):
  l = s.split('/')
  return datetime.datetime(int(l[2]), int(l[0]), int(l[1]))

def RemoveCommaInQuotesProblem(list): 
  ret = []
  index_quote_in_front = []
  index_quote_in_end = []
  for part in list:
    if part != '' and part != "N/A":
      if part[0] == "\"":
        index_quote_in_front.append(list.index(part))
      if part[len(part)-1] == "\"":
        index_quote_in_end.append(list.index(part))
  index = 0
  while index < 26:
    if index not in index_quote_in_front:
      ret.append(list[index])
    else:
      string = ''
      current = index_quote_in_front.pop(0)
      target = index_quote_in_end.pop(0)
      while current <= target:
        string += list[current]
        if current != target:
          string += ", "
        current += 1
      ret.append(string)
      index = target
    index += 1
  if len(list) > 26:
    ret += list[26:]
  return ret

def cleanFOODdata(s):
  semiclean = []
  ret = []
  data = s.split('\n')[1:]
  del data[len(data)-1]
  for string in data:
    indiv_inspection = string.split(',')
    semiclean.append(RemoveCommaInQuotesProblem(indiv_inspection))
  for list in semiclean:
    fixedlist = []
    index = 0
    while index < 20:
      if index == 8:
        fixedlist.append(date(list[index]))
      elif index != 12 and index != 15 and index != 16 and index != 17:
        fixedlist.append(list[index])
      index += 1
    ret.append(fixedlist)
  return ret

def data_final_clean(data):
  ret = []
  for list in data:
    if list[5] != "" and list[5] != None:
      ret.append(list)
  return ret

data = data_final_clean(cleanFOODdata(restaurantString))

def violations_history(data):
  dic = {}
  for list in data:
    if list[0] in dic:
      if list[8] in dic.get(list[0]): 
        dic[list[0]][list[8]] = dic[list[0]][list[8]] + [list[11]]
      else:
        dic[list[0]][list[8]] = [list[11]]
    else:
      if list[8] != datetime.datetime(1900, 1, 1, 0, 0):
        dic[list[0]] = {list[8]:[list[11]]}
  return dic

def grade_history(data):
  dic = {}
  for list in data:
    if list[13] == "A" or list[13] == "B" or list[13] == "C":
      if list[0] in dic:
        dic[list[0]][list[8]] = list[13]
      else:
        if list[8] != datetime.datetime(1900, 1, 1, 0, 0):
          dic[list[0]] = {list[8]:list[13]}
  return dic

vio_history = violations_history(data)
grade_history = grade_history(data)

def htmlmaker(CAMIS):
  violations = {}
  violations2 = {}
  grades = {}
  info = perm_info.get(CAMIS)
  #==== sorting dictionaries in order
  ret = ""
  ret += info[0] + "<br><br>"
  if CAMIS in vio_history:
    for key in sorted(vio_history.get(CAMIS), reverse=True):
      violations[key] = vio_history.get(CAMIS).get(key)
    ret += "VIOLATIONS HISTORY <table>"
    for key, value_0 in violations.items():
      value_1 = ""
      for vio in value_0:
        if value_1 != "":
          value_1 += "<br>"
        value_1 += vio
      ret += "<tr>" + "<th>" + key.strftime("%m") + "/" + key.strftime("%d") + "/" + key.strftime("%Y") + "</th>" + "<th>" + value_1 + "</th>" + "</tr>" 
    ret += "</table>"
  ret += "<br>GRADE HISTORY"
  ret += "<table>"
  if CAMIS in grade_history:
    for key in sorted(grade_history.get(CAMIS), reverse=True):
      ret += "<tr>" + "<th>" + key.strftime("%m") + "/" + key.strftime("%d") + "/" + key.strftime("%Y") + "</th>" + "<th>" + str(grade_history[CAMIS][key]) + "</th>" + "</tr>" 
    ret += "</table>"
  return ret

print(tableSkeleton + htmlmaker(CAMIS) + """</body>

</html>""")
