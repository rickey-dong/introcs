#==================================================
# Problem 0

# We can open and read text files in python like so:
#    f = open("file_name")
#    s = f.read()
# Notice that the file name should be a string.
# In order to make opening the file easy, make sure the file
# is in the same directory as your python program file.
#
# It is a good idea to close a file when you're done with
# it, which you can do like so:
#    f.close()
# 
# There is a file called 'nyc_pop.csv' that you can find in
# the same places as this lab file. Download it and put it
# in the same directory as this file.
#
# Write code that will open 'nyc_pop.csv' and the read its
# contents into a string called text.
#
# YOUR CODE HERE
f = open('nyc_pop.csv')
text = f.read()
print(text)

# You may notice an extra newline after the file, this can
# happen if there are any blank lines after the file. There
# is a python method called strip that will return a copy of
# with extra whitespace (space, newlines, tabs) removedfrom the
# beginning and end of a string. The code below uses strip to
# get rid of any extra whitespace on the ends of text.
text = text.strip()
print(text)


print('=========END OF PROBLEM 0============')
# End Problem 0
#==================================================

#==================================================
# Problem 1
#
# You should notice that the file contains population data for
# The boroughs of NYC from 1790 - 2010. It is formatted such that
# Each line represents one year, and contains a series of numbers
# separated by ','. This is a common way of representing data in
# plain text, since it is easily accessible in programming. The
# file type is called 'comma separated value' or 'csv'.
#
# Often, the first line of a .csv file will contain the headers
# that describe what each value represents.
#
# Write a function that will take a string representing the text
# of a file that looks similar to 'nyc_pop.csv' and returns a list
# that contains only the headers.

def get_headers(s):
    g = []
    s = s.split('\n')
    s = s[0]
    s = s.split(',')
    g += s
    return g

# Should print
# ['Year', 'Manhattan', 'Brooklyn', 'Queens', 'Bronx', 'Staten Island']
pop_headers = get_headers(text)
print(pop_headers)

print('=========END OF PROBLEM 1============')
# End Problem 1
#==================================================

#==================================================
# Problem 2
#
# Write a function that will take a string representing the text
# of file that looks similar to 'nyc_pop.csv' and returns a list of
# lists.
# Each sublist should represent a line from the file.
# Each element in a sublist should represent one value.
def get_data(s):
    lits = []
    s = s.split('\n')
    s.remove(s[0])
    for row in s:
        lits.append(row.split(','))
    return lits

# Should print:
# [['1790', '33131', '4549', '6159', '1781', '3827'], ['1800', '60515', '5740', '6642', '1755', '4563'],
# There will be more sublists after that.
pop_data = get_data(text)
print(pop_data)

print('============END OF PROBLEM 2============')
# End Problem 2
#==================================================

#==================================================
# Problem 3
#
# Write a function that will take a list of lists similar to pop_data,
# where every element is a string, and change each element in each
# sublist to a number.
#
# Note that this function modifies the parameter list, it does not
# return a new list.
#
# You can assume that the parameter only contains lists of number strings.
def number_convert(data):
    sublist_counter = 0
    while sublist_counter < len(data):
      stringyearcounter = 0
      while stringyearcounter < len(data[sublist_counter]):
        (data[sublist_counter])[stringyearcounter] = int((data[sublist_counter])[stringyearcounter]) * 1.0
        stringyearcounter += 1
      sublist_counter += 1 

# Should print
# [[1790.0, 33131.0, 4549.0, 6159.0, 1781.0, 3827.0 ], [1800.0, 60515.0, 5740.0, 6642.0, 1755.0, 4563.0],
# There will be more sublists after that.
number_convert(pop_data)
print(pop_data)

print('==========END OF PROBLEM 3==============')
# End Problem 3
#==================================================

#==================================================
# Problem 4
#
# Now that we have the data from our csv file in number form,
# We can actually do something with it!
#
# Write a function that takes a list similar to pop_data, and
# returns the total of the values in a given row. For pop_data,
# it would return the total population for a given year.
#
def row_total(row_key, data):
    total = 0
    yearchecker = 0
    rowtoaddup = 0
    while rowtoaddup < len(data):
      if (data[rowtoaddup])[yearchecker] == row_key:
        yearchecker += 1
        total += (data[rowtoaddup])[yearchecker]
        yearchecker += 1
        total += (data[rowtoaddup])[yearchecker]
        yearchecker += 1
        total += (data[rowtoaddup])[yearchecker]
        yearchecker += 1
        total += (data[rowtoaddup])[yearchecker]
        yearchecker += 1
        total += (data[rowtoaddup])[yearchecker]
      rowtoaddup += 1
    return total

# Should print 49447.0
print( row_total(1790, pop_data) )

# How many people lived in NYC in 1880?
print(str(row_total(1880, pop_data)),('people lived in NYC in 1880.'))

print('=============END OF PROBLEM 4==============')
# End Problem 4
#==================================================

#==================================================
# Problem 5
#
# Write a function that takes a list similar to pop_data, and
# returns a list containing the values in a given column. For pop_data,
# it would return a list where each element is the population of
# a specific borough.
#
# The function should take the list of headers, as well as a string
# for the specific header being looked at.
#
def get_column(key, headers, data):
    lsit = []
    if key == 'Manhattan':
      indexM = 1
      counterM = 0
      while counterM < len(data):
        lsit += [(data[counterM])[indexM]]
        counterM += 1
    if key == 'Brooklyn':
      indexB = 2
      counterB = 0
      while counterB < len(data):
        lsit += [(data[counterB])[indexB]]
        counterB += 1
    if key == 'Queens':
      indexQ = 3
      counterQ = 0
      while counterQ < len(data):
        lsit += [(data[counterQ])[indexQ]]
        counterQ += 1
    if key == 'Bronx':
      indexBrx = 4
      counterBrx = 0
      while counterBrx < len(data):
        lsit += [(data[counterBrx])[indexBrx]]
        counterBrx += 1
    if key == 'Staten Island':
      indexSI = 5
      counterSI = 0
      while counterSI < len(data):
        lsit += [(data[counterSI])[indexSI]]
        counterSI += 1
    if key == 'Year':
      indexY = 0
      counterY = 0
      while counterY < len(data):
        lsit += [int((data[counterY])[indexY])]
        counterY += 1
    return lsit

# Should print
# [1781.0, 1755.0, 2267.0, 2782.0, 3023.0, 5346.0, 8032.0, 23593.0, 37393.0, 51980.0,
# With more data after that
bronx_pops = get_column('Bronx', pop_headers, pop_data)
print(bronx_pops)


# Write code that would get the list of years that we have population data for.
# print to check
# 
# YOUR CODE HERE
collection_of_years = get_column('Year', pop_headers, pop_data)
print(('The list of years that we have data for are:'),('\n'),(collection_of_years))
print('=============END OF PROBLEM 5=================')
# End Problem 5
#==================================================

#==================================================
# Problem 6
#
# Use code to answer the following questions. Your code
# should print out the answer.
#
#a) How many people lived in NYC in 2010?
print(str(row_total(2010, pop_data)),('people lived in NYC in 2010.'))

#b) How many people lived in Brooklyn in 1970?
brooklyn_column = get_column('Brooklyn', pop_headers, pop_data)
year_column = get_column('Year', pop_headers, pop_data)
year_index = year_column.index(1970)
print(brooklyn_column[year_index], "people lived in Brooklyn in 1970.")

#c) What was the change in total population from 1900 to 2000?
print(str((row_total(2000, pop_data)) - (row_total(1900,pop_data))), "was the change in total population from 1900 to 2000.")

#d) What percentage of the total NYC population did Queens account for in 2010?
queens_column = get_column('Queens',pop_headers,pop_data)
year_column = get_column('Year',pop_headers,pop_data)
year_index = year_column.index(2010)
print(str(((queens_column[year_index]) / ((row_total(2010, pop_data)))) * 100), '%')
#e) Come up with your own question that can be answered using the population data.
#   What is your question:
#   What percentage of the total NYC population did Manhattan account for in 1860?
#   What is the answer? (also the code to find your answer)
manhattan_column = get_column('Manhattan',pop_headers,pop_data)
year_column = get_column('Year',pop_headers,pop_data)
year_index = year_column.index(1860)
print(str(((manhattan_column[year_index]) / ((row_total(1860, pop_data)))) * 100), '%')
print('===========END OF PROBLEM 6==============')
# End Problem 6
#==================================================
print('=========END OF CSV LAB============')
# END CSV LAB 
#==================================================