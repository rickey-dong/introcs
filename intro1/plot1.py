import matplotlib.pyplot as plt
import random
pops_2010 = [1585873,2504700,2230722,1385108,468730]
labels = ['Manhattan', 'Brooklyn', 'Queens', 'Bronx', 'Staten Island']

plt.bar(labels, pops_2010)
plt.show()

def createalist(n, limit):
    g = []
    while len(g) < n:
        g += [(random.randrange(limit))]
    return g

randrangelist = createalist(100000,100)

plt.hist(randrangelist, 10)
plt.show()

plt.hist(randrangelist, 50)
plt.show()

def createanotherlist(n, mean):
    g = []
    while len(g) < n:
        g += [random.normalvariate(mean, 1)]
    return g

randomvariatelist = createanotherlist(100000,50)

plt.hist(randomvariatelist, 25)
plt.show()

plt.hist(randomvariatelist, 100)
plt.show()

