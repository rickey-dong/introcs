#!/usr/bin/python
print('Content-type: text/html\n')

import random
import cgitb
cgitb.enable()
import datetime
import ast
import folium

f = open("perm_info.txt", encoding='utf-8')
perm_info = f.read()
f.close()

f = open("explore_template.html")
exploreSkeleton = f.read()
f.close()

#=====================================================================
perm_info = ast.literal_eval(perm_info)

def htmlmaker(list):
  hyperlink = ""
  phone = (list[5])[:3] + '-' + (list[5])[3:6] + '-' + (list[5])[6:]
  hyperlink = '<a href="restaurant_info.py?CAMIS=' + str(list[9]) + ">Click for Violation History</a>"
  list = list[:2] + [" ".join(list[2:5])] + [phone] + [list[6]] + [hyperlink]
  Str = "<p>"
  for part in list:
    if part.find('"') != -1:
      part = part.replace('"','')
    Str += part + "<br>"
  return Str + "</p><hr>"

def insertatfront(perm_info):
  for key,value in perm_info.items():
    perm_info[key] = value + [key]
  return perm_info

valuesofperminfo = list(insertatfront(perm_info).values())  

def generaterandomnumbers(perminfo):
  data = perm_info
  used = []
  times = 0
  while times < 10:
    index = random.randrange(len(data))
    if index not in used:
      times += 1
      used.append(index)
  return used          

listofrandomnumbersthatwecanuse = generaterandomnumbers(perm_info)

def random_selector(perm_info):
  data = perm_info
  str = ""
  times = 0
  while times < 10:
      str += htmlmaker(valuesofperminfo[listofrandomnumbersthatwecanuse[times]])
      times += 1
  return str
  
print(exploreSkeleton + random_selector(perm_info) + """<p style="font-family:verdana; font-size:15px; text-align:center;">
      <a href="explore.py">Refresh</a>
    </p>          </body>

</html>""")

lat = 0
longi = 1

def getcoordsandlabelname():
  listofcoordsandlabelnames = []
  name = []
  lat = []
  longi = []
  for rng in listofrandomnumbersthatwecanuse:
    name = [valuesofperminfo[rng][0]]
    lat = [valuesofperminfo[rng][7]]
    longi = [valuesofperminfo[rng][8]]
    listofcoordsandlabelnames += [name + lat + longi]
  return listofcoordsandlabelnames

makethemapwiththislist = getcoordsandlabelname()

m = folium.Map(location=[40.7128, -74.0060])

folium.Marker(
    location=[float(makethemapwiththislist[0][1]), float(makethemapwiththislist[0][2])],
    popup=makethemapwiththislist[0][0],
    icon=folium.Icon(icon='cutlery')
).add_to(m)

folium.Marker(
    location=[float(makethemapwiththislist[1][1]), float(makethemapwiththislist[1][2])],
    popup=makethemapwiththislist[1][0],
    icon=folium.Icon(icon='cutlery')
).add_to(m)

folium.Marker(
    location=[float(makethemapwiththislist[2][1]), float(makethemapwiththislist[2][2])],
    popup=makethemapwiththislist[2][0],
    icon=folium.Icon(icon='cutlery')
).add_to(m)

folium.Marker(
    location=[float(makethemapwiththislist[3][1]), float(makethemapwiththislist[3][2])],
    popup=makethemapwiththislist[3][0],
    icon=folium.Icon(icon='cutlery')
).add_to(m)

folium.Marker(
    location=[float(makethemapwiththislist[4][1]), float(makethemapwiththislist[4][2])],
    popup=makethemapwiththislist[4][0],
    icon=folium.Icon(icon='cutlery')
).add_to(m)

folium.Marker(
    location=[float(makethemapwiththislist[5][1]), float(makethemapwiththislist[5][2])],
    popup=makethemapwiththislist[5][0],
    icon=folium.Icon(icon='cutlery')
).add_to(m)

folium.Marker(
    location=[float(makethemapwiththislist[6][1]), float(makethemapwiththislist[6][2])],
    popup=makethemapwiththislist[6][0],
    icon=folium.Icon(icon='cutlery')
).add_to(m)

folium.Marker(
    location=[float(makethemapwiththislist[7][1]), float(makethemapwiththislist[7][2])],
    popup=makethemapwiththislist[7][0],
    icon=folium.Icon(icon='cutlery')
).add_to(m)

folium.Marker(
    location=[float(makethemapwiththislist[8][1]), float(makethemapwiththislist[8][2])],
    popup=makethemapwiththislist[8][0],
    icon=folium.Icon(icon='cutlery')
).add_to(m)

folium.Marker(
    location=[float(makethemapwiththislist[9][1]), float(makethemapwiththislist[9][2])],
    popup=makethemapwiththislist[9][0],
    icon=folium.Icon(icon='cutlery')
).add_to(m)

m.save('explore_map.html')
