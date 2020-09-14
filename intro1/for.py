def count(key, collection):
    times = 0
    for x in collection:
        if key == x:
            times += 1
    return times

print(count(4, [1,2,3,4]))
print(count('a', 'abracadabra'))

def doublify(collection):
    lis = []
    for x in collection:
        lis += [int(x * 2)]
    return lis

print(doublify([6,3,-8,3.5]))

def add_ten(collection):
    counter = 0
    while counter < len(collection):
        collection[counter] = (collection[counter]) + 10
        counter += 1
g = [1,2,3,4]
add_ten(g)
print(g)