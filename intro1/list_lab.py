# This is a python library that we will use to generate random numbers
import random


#==================================================
# Problem 0

# random.randrange( limit ) is a python function that returns a
# random integer in the range [0, limit)

# Write a function that will create and return a list of size n that
# is filled with random integers in the range [0, limit)

def rand_list(n, limit):
    g = []
    while len(g) < n:
        g += [random.randrange(limit)]
    return g

# When printed, a and b should have different values.
print( 'Random List Tests')
a = rand_list(10, 10)
b = rand_list(10, 10)
print(a)
print(b)
print('==========END OF PROBLEM 0===============')

# End Problem 0
#==================================================


#==================================================
# Problem 1
# Write a function that takes a list of non-negative integer
# values and returns a string of a bar graph representation of the list.
# The length of each bar should be the same as the value at that index.
# That means if g[0] = 9, then the first bar should have a length of 9.

def bar_graph(g):
    s = ''
    position = 0
    while position < len(g):
        equalsigncount = 0
        s += '\n'
        s += str(position) + ': '
        while equalsigncount < g[position]:
            s += '='
            equalsigncount += 1
        position += 1
    return s

# The code below should have this output:
# 0: =========
# 1: =====
# 2: =====
# 3: ===
# 4: =
# 5: =====
# 6: =========
# 7: =====
# 8: =======
# 9: ========
print('Bar Graph Tests')
test = [9, 5, 5, 3, 1, 5, 9, 5, 7, 8]
print(bar_graph(test))

# This should print out the bar graph for your random
# lists from Problem 0
print(bar_graph(a))
print(bar_graph(b))
print('=========END OF PROBLEM 1==============')

# End Problem 1
#==================================================


#==================================================
# Problem 2

# Write a function that returns the average of the
# values in a list. You may assume that the argument
# provided is a list that only contains number.

def list_avg( g ):
    avg = 0
    position = 0
    while position < len(g):
        avg += g[position]
        position += 1
    avg = avg / len(g)
    return avg

print('Average tests')
# This should print 5.7
print( list_avg(test) )

# This should print out the averages of your random
# lists from Problem 0
print( list_avg(a) )
print( list_avg(b) )
print('===========END OF PROBLEM 2================')

# End problem 2
#==================================================


#==================================================
# Problem 3

# Write a function that returns the number of times
# the value n appears in list g.

def count(n, g):
    c = 0
    position = 0
    while position < len(g):
        if g[position] == n:
            c += 1
        position += 1
    return c

print('Count Test')
# This should print 4
print( count(5, test) )
print('===============END OF PROBLEM 3=================')

# End Problem 3
#==================================================


#==================================================
# Problem 4

# Write a function that returns the mode (most frequently
# appearing value) of a given list.
# It should only return a single value, even if there are
# multiple modes, just return one of them.

def find_mode(g):
    guess = 0
    counter = 0
    while counter < len(g):
      a = count(g[counter], g) 
      if count(g[guess],g) < a:
        guess = counter
      counter += 1 
    return g[guess]  

print('Mode Tests')
# Should print 5
print( find_mode(test) )

print( find_mode(a) )
print( find_mode(b) )
print('==============END OF PROBLEM 4=====================')

#==================================================
# Problem 5

# Write a function that keeps track of the frequencies of values
# from a list containing only integers.
# For example, if the provided list only contained 0s and 1s,
# and there were 8 0s and 23 1s, then the fucntion should
# return this list: [8, 23]
# It is important to understand that each index in the new
# list represents a value from the parameter list. So the new
# list needs to be as large as the biggest value in the parameter.
def list_counts(g, max_value):
    #This will create a new list with a size of max_value filled with 0s
    counts = [0] * max_value
    position = 0
    while position < len(g):
      counts[g[position]] += 1
      position += 1
    return counts

print('List Count Tests')
# Should print
# [0, 1, 0, 1, 0, 4, 0, 1, 1, 2]
test_counts = list_counts( test, 10 )
print( test_counts )

print( list_counts(a, 10) )
print( list_counts(b, 10) )

# create a new list of 10 random values in the range [0, 5)
# print that list
# YOUR CODE HERE
list198 = rand_list(10, 5)
print("My List of 10 Random Values in the Range [0, 5):", list198)

# create a list that correctly counts all the values in
# the new list you just made.
# print that list
# YOUR CODE HERE
mylistcount = list_counts(list198, 5)
print(mylistcount)
print('=============END OF PROBLEM 5=====================')

# End Problem 5
#==================================================

#==================================================
# Problem 6
# If you use bar_graph on a list with sufficiently large
# values, you'll have a problem with the bars taking up
# more than one line.

# Write a new bar_graph function that will draw a scaled bar
# graph. It should take an argument for the scale factor,
# such that 1 piece of a bar represents 1 quantity equal
# to the scale factor.

def bar_graph_scaled(g, scale_factor):
    s = ''
    position = 0
    while position < len(g):
      equalsigncount = 0
      s += '\n'
      s += str(position) + ': '
      while equalsigncount < (g[position] // scale_factor):
        s += '='
        equalsigncount += 1
      position += 1
    return s

print('Scaled Bar Graph Test')
# Should print:
# 0: =====
# 1: ======
# 2: =
scale_test = [500, 670, 125]
print(bar_graph_scaled(scale_test, 100))

# now let's try it on a list with very large values
big_list = rand_list(10, 1000)
print( bar_graph_scaled(big_list, 25))
print('===========END OF PROBLEM 6======================')

# End Problem 6
#==================================================


#==================================================
# Problem 7

# random.randrange() distributes numbers evenly, meaning
# that every possible random value has an equal chance
# of being returned.

# How could you test how evenly random.randrange()
# distributes the results?
# YOUR ANSWER AS COMMENTS BELOW
# We can create a function where we create a list using random.randrange()
# with a parameter being the max amount the list contains which should be a big number,
# and the list contains values
# between only 0 and 10 inclusive.
# Then, we calculate the percentage of how many 1's occur in the
# list, and if random.randrange() truly evenly distributes the results as best as it can, it
# should be close to 10%
# Write code below that performs the test you described.
# YOUR ANSWER BELOW
def testingrandomness(maxamount):
  lis = []
  while len(lis) < maxamount:
    lis += [random.randrange(11)]
  return str(((count(1, lis)) / (len(lis))) * 100) + '%'
print(testingrandomness(10000))
print('===========END OF PROBLEM 7=================')

# End Problem 7
#==================================================


#==================================================
# Problem 8

# There is a different way of getting random numbers
# random.normalvariate(m, s) returns a random floating point
# value using what is called a "normal distribution".

# The function below will generate a list of n integers
# using a normal distribution that will have a mean
# value of m
def normal_rand_list(n, m):
    g = []
    i = 0
    while i < n:
        g.append( int(random.normalvariate(m, 1)) )
        i+= 1
    return g

# This is an example of using normal_rand_list
# Feel free to look at its values
normal_list = normal_rand_list(10, 5)
print(normal_list)

# Use a similar process as you did in problem 7
# to try and figure out what the differece is between
# the normal distribution and the distribution of random.randrange
# YOUR CODE HERE
def testingrandomnessofnormaldistribution(max_amount, mean):
    h = []
    integers = 0
    while integers < max_amount:
        h.append(int(random.normalvariate(mean, 1)))
        integers += 1
    return str(((count(1, h)) / (len(h))) * 100) + '%'
print(testingrandomnessofnormaldistribution(10000, 5))
# Describe the difference between the two distributions below.
# Cite the evidence from your tests
# YOUR ANSWER AS COMMENTS BELOW
# The difference between the two distributions is that
# random.randrange() gives values that are spread out evenly across all possible values of the list, almost like a flat line if we graph the frequencies of each value, but 
# random.normalvariate gives values that are closer to the mean, like a bell curve. For example, using random.randrange(), the number 1 can comprise of 10% of the whole list, such as 9.66%, which I got in one test run,
# but random.normalvariate rarely returns the number 1, because individually, the number 1 is nowhere near close enough to the mean number, which is 5, which is why in the same test run I got
# a 0.13% occurrence for the number 1. 

print('===========END OF PROBLEM 8=================')
# End Problem 8
#==================================================
print('===========END OF LISTS LAB=================')
# End Lists Lab
#==================================================