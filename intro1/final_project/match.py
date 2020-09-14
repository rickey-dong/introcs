#!/usr/bin/python                           
print('Content-type: text/html\n')

import datetime
import cgi
import cgitb
cgitb.enable()
import numpy
import ast
data = cgi.FieldStorage()

f = open("perm_info.txt", encoding='utf-8')
perm_info = f.read()
f.close()

f = open("match_template.html", encoding='utf-8')
matchSkeleton = f.read()
f.close()

f = open("zip_cuisine_rating", encoding='utf-8')
zip_masterdict = f.read()
f.close()
zip_masterdict = ast.literal_eval(zip_masterdict)

f = open("boro_cuisine_rating", encoding='utf-8')
boro_masterdict = f.read()
f.close()
boro_masterdict = ast.literal_eval(boro_masterdict)

f = open("restaurant_rankings", encoding='utf-8')
restaurant_rankings = f.read()
f.close()
restaurant_rankings = ast.literal_eval(restaurant_rankings)
#=============================================
#boros
Bronx = ""
if "Bronx" in data:
  Bronx = data.getvalue('Bronx')
Queens = ""
if "Queens" in data:
  Queens = data.getvalue('Queens')
Brooklyn = ""
if "Brooklyn" in data:
  Brooklyn = data.getvalue('Brooklyn')
Manhattan = ""
if "Manhattan" in data:
  Manhattan = data.getvalue('Manhattan')
Staten_Island = ""
if "Staten" in data:
  Staten_Island = data.getvalue('Staten')

def boro_listmaker():
  ret = []
  if Bronx == "selected":
    ret.append("Bronx")
  if Queens == "selected":
    ret.append("Queens")
  if Brooklyn == "selected":
    ret.append("Brooklyn")
  if Manhattan == "selected":
    ret.append("Manhattan")
  if Staten_Island == "selected":
    ret.append("Staten Island")
  return ret
boro_list = boro_listmaker()
#=============================================

perm_info = ast.literal_eval(perm_info)

#zip code
zipcode = data.getvalue('ZipCode')
#=============================================
#cuisine 
Afghan = ""
if "Afghan" in data:
  Afghan = data.getvalue('Afghan')
African = ""
if "African" in data:
  African = data.getvalue('African')
American = ""
if "American" in data:
  American = data.getvalue('American')
Armenian = ""
if "Armenian" in data:
  Armenian = data.getvalue('Armenian')
Asian = ""
if "Asian" in data:
  Asian = data.getvalue('Asian')
Australian = ""
if "Australian" in data:
  Australian = data.getvalue('Australian')
Bagels_Pretzels = ""
if "Bagels" in data:
  Bagels_Pretzels = data.getvalue('Bagels')
Bakery = ""
if "Bakery" in data:
  Bakery = data.getvalue('Bakery')
Bangladeshi = ""
if "Bangladeshi" in data:
  Bangladeshi = data.getvalue('Bangladeshi')
Barbecue = ""
if "Barbecue" in data:
  Barbecue = data.getvalue('Barbecue')
Basque = ""
if "Basque" in data:
  Basque = data.getvalue('Basque')
Beverages = ""
if "Beverages" in data:
  Beverages = data.getvalue('Beverages')
Brazilian = ""
if "Brazilian" in data:
  Brazilian = data.getvalue('Brazilian')
Café = ""
if "Café" in data:
  Café = data.getvalue('Café')
Cajun = ""
if "Cajun" in data:
  Cajun = data.getvalue('Cajun')
Californian = ""
if "Californian" in data:
  Californian = data.getvalue('Californian')
Caribbean = ""
if "Caribbean" in data:
  Caribbean = data.getvalue('Caribbean')
Chicken = ""
if "Chicken" in data:
  Chicken = data.getvalue('Chicken')
Chilean = ""
if "Chilean" in data:
  Chilean = data.getvalue('Chilean')
Chinese = ""
if "Chinese" in data:
  Chinese = data.getvalue('Chinese')
ChineseCuban = ""
if "ChineseCuban" in data:
  ChineseCuban = data.getvalue('ChineseCuban')
ChineseJapanese = ""
if "ChineseJapanese" in data:
  ChineseJapanese = data.getvalue('ChineseJapanese')
Continental = ""
if "Continental" in data:
  Continental = data.getvalue('Continental')
Creole = ""
if "Creole" in data:
  Creole = data.getvalue('Creole')
CreoleCajun = ""
if "CreoleCajun" in data:
  CreoleCajun = data.getvalue('CreoleCajun')
Czech = ""
if "Czech" in data:
  Czech = data.getvalue('Czech')
Donuts = ""
if "Donuts" in data:
  Donuts = data.getvalue('Donuts')
EasternEuropean = ""
if "Eastern" in data:
  EasternEuropean = data.getvalue('Eastern')
Egyptian = ""
if "Egyptian" in data:
  Egyptian = data.getvalue('Egyptian')
English = ""
if "English" in data:
  English = data.getvalue('English')
Ethiopian = ""
if "Ethiopian" in data:
  Ethiopian = data.getvalue('Ethiopian')
Filipino = ""
if "Filipino" in data:
  Filipino = data.getvalue('Filipino')
French = ""
if "French" in data:
  French = data.getvalue('French')
FruitsVegetables = ""
if "Fruits" in data:
  FruitsVegetables = data.getvalue('Fruits')
German = ""
if "German" in data:
  German = data.getvalue('German')
Greek = ""
if "Greek" in data:
  Greek = data.getvalue('Greek')
Hamburgers = ""
if "Hamburgers" in data:
  Hamburgers = data.getvalue('Hamburgers')
Hawaiian = ""
if "Hawaiian" in data:
  Hawaiian = data.getvalue('Hawaiian')
Hotdogs = ""
if "Hotdogs" in data:
  Hotdogs = data.getvalue('Hotdogs')
HotdogsPretzels = ""
if "HotdogsPretzels" in data:
  HotdogsPretzels = data.getvalue('HotdogsPretzels')
IceCream = ""
if "IceCream" in data:
  IceCream = data.getvalue('IceCream')
Indian = ""
if "Indian" in data:
    Indian = data.getvalue('Indian')
Indonesian = ""
if "Indonesian" in data:
    Indonesian = data.getvalue('Indonesian')
Iranian = ""
if "Iranian" in data:
    Iranian = data.getvalue('Iranian')
Irish = ""
if "Irish" in data: 
    Irish = data.getvalue('Irish')
Italian = ""
if "Italian" in data:  
    Italian = data.getvalue('Italian')
Japanese = ""
if "Japanese" in data:  
    Japanese = data.getvalue('Japanese')
JewishKosher = ""
if "Jewish" in data:  
    JewishKosher = data.getvalue('Jewish')
JuiceSmoothie = ""
if "Juice" in data:  
    JuiceSmoothie = data.getvalue('Juice+')
Korean = ""
if "Korean" in data:  
    Korean = data.getvalue('Korean')
Latin = ""
if "Latin" in data:  
  Latin = data.getvalue('Latin')
Mediterranean = ""
if "Mediterranean" in data:  
  Mediterranean = data.getvalue('Mediterranean')
Mexican = ""
if "Mexican" in data:  
  Mexican = data.getvalue('Mexican')
MiddleEastern = ""
if "MiddleEastern" in data:  
  MiddleEastern = data.getvalue('MiddleEastern')
Moroccan = ""
if "Moroccan" in data:  
  Moroccan = data.getvalue('Moroccan')
NA = ""
if "NA" in data:  
  NA = data.getvalue('NA')
Nuts = ""
if "Nuts" in data:  
  Nuts = data.getvalue('Nuts')
Other = ""
if "Other" in data:  
  Other = data.getvalue('Other')
Pakistani = ""
if "Pakistani" in data:  
  Pakistani = data.getvalue('Pakistani')
PancakesWaffle = ""
if "Pancakes" in data:  
  PancakesWaffle = data.getvalue('Pancakes')
Peruvian = ""
if "Peruvian" in data:  
  Peruvian = data.getvalue('Peruvian')
Pizza = ""
if "Pizza" in data:  
  Pizza = data.getvalue('Pizza')
PizzaItalian = ""
if "PizzaItalian" in data:  
  PizzaItalian = data.getvalue('PizzaItalian')
Polish = ""
if "Polish" in data:  
  Polish = data.getvalue('Polish')
Portuguese = ""
if "Portuguese" in data:
  Portuguese = data.getvalue('Portuguese')
Russian = ""
if "Russian" in data:  
  Russian = data.getvalue('Russian')
Salads = ""
if "Salads" in data:  
  Salads = data.getvalue('Salads')
MixBuffet = ""
if "MixBuffet" in data:  
  MixBuffet = data.getvalue('MixBuffet')
Scandinavian = ""
if "Scandinavian" in data:  
  Scandinavian = data.getvalue('Scandinavian')
SeaFood = ""
if "SeaFood" in data:  
  SeaFood = data.getvalue('Seafood')
SoulFood = ""
if "SoulFood" in data:  
  SoulFood = data.getvalue('SoulFood')
Soups = ""
if "Soups" in data:  
  Soups = data.getvalue('Soups')
SoupSand = ""
if "SoupSand" in data:  
  SoupSand = data.getvalue('SoupSand')
Southwestern = ""
if "Southwestern" in data:  
  Southwestern = data.getvalue('Southwestern')
Spanish = ""
if "Spanish" in data:  
  Spanish = data.getvalue('Spanish')
Steak = ""
if "Steak" in data:  
  Steak = data.getvalue('Steak')
Tapas = ""
if "Tapas" in data:  
  Tapas = data.getvalue('Tapas')
TexMex = ""
if "TexMex" in data:  
  TexMex = data.getvalue('TexMex')
Thai = ""
if "Thai" in data:  
  Thai = data.getvalue('Thai')
Turkish = ""
if "Turkish" in data:  
  Turkish = data.getvalue('Turkish')
Vegetarian = ""
if "Vegetarian" in data:  
  Vegetarian = data.getvalue('Vegetarian')
Viet = ""
if "Viet" in data:  
  Viet = data.getvalue('Viet')

def cuisine_listmaker():
  ret = []
  if Afghan == "selected":
    ret.append("Afghan")
  if African == "selected":
    ret.append("African")
  if American == "selected":
    ret.append("American")
  if Armenian == "selected":
    ret.append("Armenian")
  if Asian == "selected":
    ret.append("Asian")
  if Australian == "selected":
    ret.append("Australian")
  if Bagels_Pretzels == "selected":
    ret.append("Bagels/Pretzels")
  if Bakery == "selected":
    ret.append("Bakery")
  if Bangladeshi == "selected":
    ret.append("Bangladeshi")
  if Barbecue == "selected":
    ret.append("Barbecue")
  if Basque == "selected":
    ret.append("Basque")
  if Beverages == "selected":
    ret.append('"Bottled beverages, including water, sodas, juices, etc."')
  if Brazilian == "selected":
    ret.append("Brazilian")
  if Café == "selected":
    ret.append("Café/Coffee/Tea")
  if Cajun == "selected":
    ret.append("Cajun")
  if Californian == "selected":
    ret.append("Californian")
  if Caribbean == "selected":
    ret.append("Caribbean")
  if Chicken == "selected":
    ret.append("Chicken")
  if Chilean == "selected":
    ret.append("Chilean")
  if Chinese == "selected":
    ret.append("Chinese")
  if ChineseCuban == "selected":
    ret.append("Chinese/Cuban")
  if ChineseJapanese == "selected":
    ret.append("Chinese/Japanese")
  if Continental == "selected":
    ret.append("Continental")
  if Creole == "selected":
    ret.append("Creole")
  if CreoleCajun == "selected":
    ret.append("Creole/Cajun")
  if Czech == "selected":
    ret.append("Czech")
  if Donuts == "selected":
    ret.append("Donuts")
  if EasternEuropean == "selected":
    ret.append("Eastern European")
  if Egyptian == "selected":
    ret.append("Egyptian")
  if English == "selected":
    ret.append("English")
  if Ethiopian == "selected":
    ret.append("Ethiopian")
  if Filipino == "selected":
    ret.append("Filipino")
  if French == "selected":
    ret.append("French")
  if FruitsVegetables == "selected":
    ret.append("Fruits/Vegetables")
  if German == "selected":
    ret.append("German")
  if Greek == "selected":
    ret.append("Greek")
  if Hamburgers == "selected":
    ret.append("Hamburgers")
  if Hawaiian == "selected":
    ret.append("Hawaiian")
  if Hotdogs == "selected":
    ret.append("Hotdogs")
  if HotdogsPretzels == "selected":
    ret.append("Hotdogs/Pretzels")
  if IceCream == "selected":
    ret.append("Ice Cream,  Gelato,  Yogurt,  Ices")
  if Indian == "selected":
    ret.append("Indian")
  if Indonesian == "selected":
    ret.append("Indonesian")
  if Iranian == "selected":
    ret.append("Iranian")
  if Irish == "selected":
    ret.append("Irish")
  if Italian == "selected":
    ret.append("Italian")
  if Japanese == "selected":
    ret.append("Japanese")
  if JewishKosher == "selected":
    ret.append("Jewish/Kosher")
  if JuiceSmoothie == "selected":
    ret.append("Juice, Smoothies, Fruit Salads")
  if Korean == "selected":
    ret.append("Korean")
  if Latin == "selected":
    ret.append("Latin")
  if Mediterranean == "selected":
    ret.append("Mediterranean")
  if Mexican == "selected":
    ret.append("Mexican")
  if MiddleEastern == "selected":
    ret.append("MiddleEastern")
  if Moroccan == "selected":
    ret.append("Moroccan")
  if NA == "selected":
    ret.append("NA")
  if Nuts == "selected":
    ret.append("Nuts")
  if Other == "selected":
    ret.append("Other")
  if Pakistani == "selected":
    ret.append("Pakistani")
  if PancakesWaffle == "selected":
    ret.append("Pancakes/Waffles")
  if Peruvian == "selected":
    ret.append("Peruvian")
  if Pizza == "selected":
    ret.append("Pizza")
  if Pizza+Italian == "selected":
    ret.append("Pizza/Italian")
  if Polish == "selected":
    ret.append("Polish")
  if Portuguese == "selected":
    ret.append("Portuguese")
  if Russian == "selected":
    ret.append("Russian")
  if Salads == "selected":
    ret.append("Salads")
  if MixBuffet == "selected":
    ret.append("Sandwiches/Salads/Mixed Buffet")
  if Scandinavian == "selected":
    ret.append("Scandinavian")
  if SeaFood == "selected":
    ret.append("Sea Food")
  if SoulFood == "selected":
    ret.append("Soul Food")
  if Soups == "selected":
    ret.append("Soups")
  if SoupSand == "selected":
    ret.append("Soups & Sandwiches")
  if Southwestern == "selected":
    ret.append("Southwestern")
  if Spanish == "selected":
    ret.append("Spanish")
  if Steak == "selected":
    ret.append("Steak")
  if Tapas == "selected":
    ret.append("Tapas")
  if TexMex == "selected":
    ret.append("TexMex")
  if Thai == "selected":
    ret.append("Thai")
  if Turkish == "selected":
    ret.append("Turkish")
  if Vegetarian == "selected":
    ret.append("Vegetarian")
  if Viet == "selected":
    ret.append("Vietnamese/Cambodian/Malaysia")
  return ret
cuisine_list = cuisine_listmaker()
#=============================================
#Inspection Rating

A = ""
if "A" in data:
  A = data.getvalue('A')
B = ""
if "B" in data:
  B = data.getvalue('B')
C = ""
if "C" in data:
  C = data.getvalue('C')

def rating_listmaker():
  ret = []
  if A == "selected":
    ret.append('A')
  if B == "selected":
    ret.append('B')
  if C == "selected":
    ret.append('C')
  return ret

rating_list = rating_listmaker()
#=============================================
#MATCHING

#route_0: boro, zip all have nothing, missing info
#route_1: no boro, usage of zip code
#route_2: no zip code, usage of boro

def matcher(combo_list, dict):
  list = []
  ret = []
  for list in combo_list:   #[['Staten Island', 'Asian', 'A'], ['Staten Island', 'Asian', 'B'], ['Staten Island', 'Asian', 'C']]
    if (list[0] in dict):
      if list[1] in dict.get(list[0]):
        if list[2] in dict.get(list[0]).get(list[1]):
          ret += dict.get(list[0]).get(list[1]).get(list[2])
  if ret == []:
    return "oops"
  else:
    for restaurant in restaurant_rankings:
      if restaurant in ret:
        list.append(restaurant)
    return list 

def pathway():
  if (zipcode == None and boro_list == []) or rating_list == [] or cuisine_list == []:
    return "oops"
  elif zipcode != None:
    l = [[zipcode], cuisine_list, rating_list] 
    combo_list = [list(x) for x in numpy.array(numpy.meshgrid(*l)).T.reshape(-1,len(l))] #this was googled, in order to making all combos
    return matcher(combo_list, zip_masterdict)[3:]
  else:
    l = [boro_list, cuisine_list, rating_list]
    combo_list = [list(x) for x in numpy.array(numpy.meshgrid(*l)).T.reshape(-1,len(l))]
    return matcher(combo_list, boro_masterdict)[3:]

finalcamises = pathway()

def CAMISdisplayer(CAMIS):
  information = []
  information = perm_info.get(CAMIS)
  return information

def htmlgenerator(lsitofCAMISmatches):
  if lsitofCAMISmatches != "oops" and lsitofCAMISmatches != "s":
    html = "<p>"
    for ID in lsitofCAMISmatches:
      hyperlink = ""
      lsit = CAMISdisplayer(ID)
      phone = (lsit[5])[:3] + '-' + (lsit[5])[3:6] + '-' + (lsit[5])[6:]
      hyperlink = '<a href="restaurant_info.py?CAMIS=' + str(ID) + ">Click for Violation History</a>"
      lsit = lsit[:2] + [" ".join(lsit[2:5])] + [phone] + [lsit[6]] + [hyperlink]
      for part in lsit:
        if part.find('"') != -1:
          part = part.replace('"','')
        html += part + "<br>"
      html += "</p><hr>"
      html += "<p>"
    html = html[::-1]
    html = html.replace('>p<','',1)
    html = html[::-1]
  else:
    html = "Sorry, nothing matched with your search. Please try again, and make sure all necessary sections are filled!"
  return html

print(matchSkeleton + htmlgenerator(finalcamises) + """<p style="font-family:verdana; font-size:15px; text-align:center;">
      <a href="match.html">Reselect</a>
    </p>          </body>

</html>""")
