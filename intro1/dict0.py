def lists2dict(keys, values):
    d = {}
    keycounter = 0
    valuecounter = 0
    while keycounter < len(keys) and valuecounter < len(values):
        d[(keys[keycounter])] = values[valuecounter]
        keycounter += 1
        valuecounter += 1
    return d

print(lists2dict(['v', 'viii', 'iv'], ['empire strikes back', 'force awakens', 'new hope']))

def combine_dict(dict0, dict1):
    dict2 = {}
    for character in list(dict0.keys()):
        dict2[character] = []
    for character in list(dict1.keys()):
        dict2[character] = []
    for value in list(dict0.values()):
        dict2[(value[0])] = [value]
    for value in list(dict1.values()):
        dict2[(value[0])] += [value]
    return dict2

print(combine_dict( {'a' : 'apple', 'z' : 'zed', 'q' : 'quixotic'}, {'b' : 'boba', 'a' : 'akbar', 'z' : 'zoo', 'w' : 'wombat' }))
