import random
import datetime
import collections

f = open("nyc_food_inspect.txt", encoding='utf-8')
restaurantString = f.read()
f.close()
#======================================================================
# Cleans data, placing each indivudal inspection into a list
# RemoveCommaInQuotesProblem is able to handle commas in resturant
# names, violation descriptions, etc. Finally, unnecessary info like 
# community district numbers are removed.

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
#print(data)
#======================================================================
# Violation code matcher (dictonary)

def violation(data):
  dic = {}
  for list in data:
    if list[10] not in dic and list[11] != "":
      dic[list[10]] = list[11]
  return dic

violations = violation(data)
#print(violations)
#======================================================================
# Creates a separate dictionary that links each restaurants unique
# city-assigned number to their permanent info, like coordinates and address.

def perm_info(data):
  dic = {}
  for list in data:
    if list[0] not in dic:
      dic[list[0]] = list[1:8] + list[14:]
  return dic

perm_info = perm_info(data)
f = open("perm_info.txt", "w", encoding='utf-8')
f.write(str(perm_info))
f.close()
#print(perm_info)
#======================================================================
# Creates a separate dictionary that gives all the restaurants (in the form
# of city-assigned number) in each zip code

def zipsorter(d):
  dic = {}
  for key, value in d.items():
    if value[4] in dic:
      dic[value[4]].append(key)
    else:
      dic[value[4]] = [key]
  return dic

zipsort = zipsorter(perm_info)
#print(zipsort)
#======================================================================
# Creates a separate dictionary that gives the most recent rating (A, B, C)
# of each restaurant

def restaurant_letter(data):
  ret = {}
  dic = {}
  for list in data:
    if list[0] in dic:
      if dic.get(list[0])[1] < list[8] and (list[13] == "A" or list[13] == "B" or list[13] == "C"):
        dic[list[0]] = [list[13]] + [list[8]]
    elif list[13] == "A" or list[13] == "B" or list[13] == "C":
      dic[list[0]] = [list[13]] + [list[8]]
  for key, value in dic.items():
    ret[key] = value[0]
  return ret

restaurant_letter = restaurant_letter(data)
#print(restaurant_letter(data))
#=====================================================================

def restaurant_violations(data):
  ret = {}
  dic = {}
  for list in data:
    if list[0] in dic:
      if dic.get(list[0])[0] == list[8]:
        dic[list[0]] = dic.get(list[0]) + [list[10]]
      elif dic.get(list[0])[0] < list[8]:
        dic[list[0]] = [list[8]] + [list[10]]
    else:
      dic[list[0]] = [list[8]] + [list[10]]
  for key, value in dic.items():
    ret[key] = value[1:]
  return ret

restaurant_violations = restaurant_violations(data)
#print(restaurant_violations)

#=====================================================================

def violations_history(data):
  dic = {}
  for list in data:
    if list[0] in dic:
      if list[8] in dic.get(list[0]): 
        dic[list[0]][list[8]] = dic[list[0]][list[8]] + [list[10]]
      else:
        dic[list[0]][list[8]] = [list[10]]
    else:
      if list[8] != datetime.datetime(1900, 1, 1, 0, 0):
        dic[list[0]] = {list[8]:[list[10]]}
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

f = open("vio_history.txt", "w", encoding='utf-8')
f.write(str(vio_history))
f.close()

f = open("grade_history.txt", "w", encoding='utf-8')
f.write(str(grade_history))
f.close()

#=====================================================================

def boro_zip(data):
  dic = {}
  for list in data:
    if list[2] not in dic:
      dic[list[2]] = {list[5]:zipsort[list[5]]}
    elif list[5] not in dic[list[2]]:
      dic[list[2]][list[5]] = zipsort[list[5]]
  return dic
boro_zip = boro_zip(data)
#print(boro_zip)

def cuisinesorter(d):
  dic = {}
  for key, value in d.items():
    dic[key] = value[6]
  return dic

cuisinesort = cuisinesorter(perm_info)


#boro_zip: {'Queens': {'11385': ['50074525', '50052170'}}
def boro_zip_cuisine(boro_zip):
  for boro,zip_dic in boro_zip.items():
    for zip,list in zip_dic.items():
      dic = {}
      for CAMIS in list:
        if cuisinesort.get(CAMIS) not in dic:
          dic[cuisinesort.get(CAMIS)] = [CAMIS]
        else:
          dic[cuisinesort.get(CAMIS)] = dic[cuisinesort.get(CAMIS)] + [CAMIS]
      boro_zip[boro][zip] = dic
  return boro_zip
#print(boro_zip_cuisine(boro_zip))
boro_zip_cuisine = boro_zip_cuisine(boro_zip)

def boro_zip_cuisine_rating(boro_zip_cuisine):
  for boro,zip_dic in boro_zip_cuisine.items():
    for zip, cuisine_dic in zip_dic.items():
      for cuisine, list in cuisine_dic.items():
        dic = {}
        for CAMIS in list:
          if restaurant_letter.get(CAMIS) not in dic:
            dic[restaurant_letter.get(CAMIS)] = [CAMIS]
          else:
            dic[restaurant_letter.get(CAMIS)] = dic[restaurant_letter.get(CAMIS)] + [CAMIS]
        boro_zip_cuisine[boro][zip][cuisine] = dic
  return boro_zip_cuisine
boro_zip_cuisine_rating = boro_zip_cuisine_rating(boro_zip_cuisine)
#print(boro_zip_cuisine_rating)

def zip_cuisine_rating(boro_zip_cuisine_rating):   #{'Queens': {'11385': {'"Ice Cream,  Gelato,  Yogurt,  Ices"': {'A': ['50074525', '41694705', '50047527', '50052466', '41654548', '41237575', '41539722', '50037446']}, 'Japanese': {'A': ['50052170', '50060720', '50005854', '50015494', '50075523', '50084875']}, 
  ret = {}
  for key, value in boro_zip_cuisine_rating.items():
    for key1, value1 in value.items():
      ret[key1] = value1
  return ret
zip_cuisine_rating = zip_cuisine_rating(boro_zip_cuisine_rating)
#print(zip_cuisine_rating)

def boro_cuisine_rating(boro_zip_cuisine_rating):
  #{'Queens': {'11385': {'"Ice Cream,  Gelato,  Yogurt,  Ices"': {'A': ['50074525', '41694705', '50047527', '50052466', '41654548', '41237575', '41539722', '50037446']}, 'Japanese': {'A': ['50052170', '50060720', '50005854', '50015494', '50075523', '50084875']}, 
  #{queens: {'"Ice Cream,  Gelato,  Yogurt,  Ices"': {'A': ['50074525', '41694705', '50047527', '50052466', '41654548', '41237575', '41539722', '50037446', camis, camis, camis, camis]}
  ret = {}
  for k_boro, v_boro in boro_zip_cuisine_rating.items():
    new_boro_dict = {}
    for k_zip, v_zip in v_boro.items():
      for k_type, dict_type in v_zip.items():
        if k_type not in new_boro_dict:
          new_boro_dict[k_type] = dict_type
        else:
          for grade, list_camis in dict_type.items():
            if grade in new_boro_dict[k_type]:
              new_boro_dict[k_type][grade] += list_camis
            else:
              new_boro_dict[k_type][grade] = list_camis
    ret[k_boro] = new_boro_dict
  return ret

boro_cuisine_rating = boro_cuisine_rating(boro_zip_cuisine_rating)

f = open("zip_cuisine_rating", "w", encoding='utf-8')
f.write(str(zip_cuisine_rating))
f.close()

f = open("boro_cuisine_rating", "w", encoding='utf-8')
f.write(str(boro_cuisine_rating))
f.close()

def restaurant_rankings(data):
  ret = []
  semi_done = {}
  dic = {}
  for list in data:
    if list[0] in dic:
      if dic.get(list[0])[1] < list[8] and (list[12] != ''):
        dic[list[0]] = [list[12]] + [list[8]]
    elif list[12] != '':
      dic[list[0]] = [list[12]] + [list[8]]
  for key, value in dic.items():
    semi_done[key] = value[0]
  for tuple in sorted(semi_done.items(), key=lambda x: x[1]):
    ret.append(tuple[0])
  return ret

restaurant_rankings = restaurant_rankings(data)
#print(len(restaurant_rankings))
