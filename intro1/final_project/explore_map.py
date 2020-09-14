#!/usr/bin/python
print('Content-type: text/html\n')

f = open("explore_map.html", encoding='utf-8')
mapSkeleton = f.read()
f.close()

def updatedmap(string):
  if string.find("<script>") != -1:
    pos = string.find("<script>")
    titleandicon = """<title>New York City Eats</title>
    <link rel="shortcut icon" href="restaurantTable.ico">"""
    newstring = string[:pos] + titleandicon + string[pos:]
  return newstring

print(updatedmap(mapSkeleton))
