def pirate(s):
    piratelist = []
    s = s.split()
    for words in s:
        if words == 'you':
            piratelist.append('ye')
        elif words == 'your':
            piratelist.append('yer')
        elif words == 'the':
            piratelist.append("t'")
        elif words == 'i' or words == 'my' or words == 'mine':
            piratelist.append('me')
        elif words == 'am' or words == 'is' or words == 'are' or words == "'re":
            piratelist.append('be')
        elif words == 'myself':
            piratelist.append('meself')
        elif words == 'for':
            piratelist.append('fer')
        else:
            piratelist.append(words)
    piratelist = ' '.join(piratelist)
    return piratelist

strin = """
may i introduce myself i am quite pleased to make your aquaintence.
my aim is for us to have a mutually beneficial arrangement.
you are encouraged to be clear about your terms, as I will be about mine own.
"""
print(pirate(strin))
            
    