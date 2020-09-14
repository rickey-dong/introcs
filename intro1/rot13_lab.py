#==================================================
# Problem 0

# Write a function, encode_table(), that should print out
# each letter from a-z, along with its UTF-8 value, use one line per character.
# Each line should look like this:
#     a: 97
# The function does not need to return anything.

def encode_table():
    counter = 97
    while counter <= 122:
        print(chr(counter),":",counter)
        counter += 1


encode_table()
# End Problem 0
#==================================================

#==================================================
# Problem 1

# There is a cipher (https://en.wikipedia.org/wiki/Cipher) called rot13
# The following shows how to "encrypt" something in rot13:

# a b c d e f g h i j k l m n o p q r s t u v w x y z
# n o p q r s t u v w x y z a b c d e f g h i j k l m

# hello in rot13 becomes uryyb

# Look at the Unicode values from encode_table()
# what can you tell about a letter and its rot13 equivalent?
# Write your answer below as a comment.

# The absolute value
# difference between them
# is 13.

# End Problem 1
#==================================================

#==================================================
# Problem 2

# Write a function that takes a single character string
# as a parameter and returns its rot13 equivalent.
# If the character is not a lower case letter,
# return the original character.
# for example rot13char("b") would return "o"

def rot13char(c):
    if ord(c) >= 97 and ord(c) <= 109:
        converterRight = ord(c)
        converterRight += 13
        return chr(converterRight)
    elif ord(c) >= 110 and ord(c) <= 122:
        converterLeft = ord(c)
        converterLeft -= 13
        return chr(converterLeft)
    else:
        return c

print( rot13char('b') )
print( rot13char('q') )
print( rot13char('?') )

# End Problem 2
#==================================================


#==================================================
# Problem 3

# Write a function that prints out all the characters
# from 'a' to 'z' along with their rot13 equivalents.
# Like problem 0, each letter should be on its own line.
# A line of this string might look like:
#       h -> u

def rot13_table():
    counter = 97
    while counter <= 122:
        if counter < 110:
            print(chr(counter), '->', (chr(counter + 13)))
            counter += 1
        else:
            print(chr(counter), '->', (chr(counter - 13)))
            counter += 1

rot13_table()

# End Problem 3
#==================================================

#==================================================
# Problem 4
# Write a function that will take a string consisting of
# lowercase letters only and will return its rot13 equivalent.

# For example, rot13("skywalker") would return "fxljnyxre"

def rot13(s):
    position = 0
    x = ""
    while position < len(s):
        if ord(s[position]) >= 97 and ord(s[position]) <= 109:
            converterRight = ord(s[position])
            converterRight += 13
            x += chr(converterRight)
            position += 1
        if ord(s[position]) >= 110 and ord(s[position]) <= 122:
            converterLeft = ord(s[position])
            converterLeft -= 13
            x += chr(converterLeft)
            position += 1
    return x

print( rot13('skywalker') )
#print( rot13('fxljnyxre') )
# What happens when you call rot13 on a string that was created by rot13?
#It generates an error that says "IndexError: string index out of range."
# End Problem 4
#==================================================

#==================================================
# Problem 5

# Go back to problem 2, modify the function such
# that it now works with both upper and lower case letters.
# Test it below

def rot13UpperAndLower(c):
    if ord(c) >= 97 and ord(c) <= 109:
        converterRight = ord(c)
        converterRight += 13
        return chr(converterRight)
    elif ord(c) >= 110 and ord(c) <= 122:
        converterLeft = ord(c)
        converterLeft -= 13
        return chr(converterLeft)
    elif ord(c) >= 65 and ord(c) <= 77:
        converterSuperRight = ord(c)
        converterSuperRight += 13
        return chr(converterSuperRight)
    elif ord(c) >= 78 and ord(c) <= 90:
        converterSuperLeft = ord(c)
        converterSuperLeft -= 13
        return chr(converterSuperLeft)
    else:
        return c

print( rot13UpperAndLower('B') )
print( rot13UpperAndLower('q') )
print( rot13UpperAndLower('?') )

# End Problem 5
#==================================================

#==================================================
# Problem 6

# Go back to problem 2, modify the function such
# that it can take a string with any characters in it,
# but will only modify letters, leaving spaces, numbers
# and punctuation unchanged.
# Test it below

def SuperRot(S):
    position = 0
    x = ""
    while position < len(S):
        if ord(S[position]) >= 97 and ord(S[position]) <= 109:
            converterRight = ord(S[position])
            converterRight += 13
            x += chr(converterRight)
            position += 1
        elif ord(S[position]) >= 110 and ord(S[position]) <= 122:
            converterLeft = ord(S[position])
            converterLeft -= 13
            x += chr(converterLeft)
            position += 1
        elif ord(S[position]) >= 65 and ord(S[position]) <= 77:
            converterSuperRight = ord(S[position])
            converterSuperRight += 13
            x += chr(converterSuperRight)
            position += 1
        elif ord(S[position]) >= 78 and ord(S[position]) <= 90:
            converterSuperLeft = ord(S[position])
            converterSuperLeft -= 13
            x += chr(converterSuperLeft)
            position += 1
        else:
            converterUnchanged = ord(S[position])
            x += chr(converterUnchanged)
            position += 1
    return x

print(SuperRot("This string has many characters, but it only modifies letters - both uppercase and lowercase - leaving spaces, numbers, and punctuation unchanged."))

# End Problem 6
#==================================================