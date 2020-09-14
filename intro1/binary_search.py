import random

def rand_list(n, limit):
    g = []
    while (n > 0):
        g.append(random.randrange(limit))
        n-= 1
    return g

def bin_search(g, key, low, high):
    g = sorted(g)
    if g[(low + high) // 2] == key:
        return (low + high) // 2
    elif low > high:
        return -1
    elif key < g[(low + high) // 2]:
        return bin_search(g, key, low, ((low + high) // 2) - 1)
    else:
        return bin_search(g, key, ((low + high) // 2) + 1, high)
            
print(bin_search(rand_list(500000, 500001), 234, 0, 499999))