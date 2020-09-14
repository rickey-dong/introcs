def diff21(n):
  if (n > 21): 
    return (2 * (abs(n - 21)))
  else: 
    return (abs(n - 21))

def fix_teen(n):
  if (n >= 13 and n <= 19) and (n != 15 and n != 16):
    return 0
  else:
    return n

def no_teen_sum(a, b, c):
  return fix_teen(a) + fix_teen(b) + fix_teen(c)
  
def sorta_sum(a, b):
  if (a + b >= 10 and a + b <= 19):
    return 20
  else: return a + b

def lone_sum(a, b, c):
  if a == b and b == c:
    return 0
  elif a == b:
    return c
  elif a == c:
    return b
  elif b == c:
    return a
  else: return a + b + c
  
def lucky_sum(a, b, c):
  if a == 13:
    return 0
  elif b == 13:
    return a
  elif c == 13:
    return a + b
  else: return a + b + c
  
def round10(num):
  if (num % 10 >= 5):
    return ((num / 10) + 1) * 10
  else: return ((num / 10) * 10)

def round_sum(a, b, c):
  return round10(a) + round10(b) + round10(c)

def make_bricks(small, big, goal):
  if big == 0:
    return goal <= small
  elif small == 0 and big != 0:
    return goal % 5 == 0
  elif (small) + (big * 5) < goal:
    return False
  elif (goal % 5) <= small:
    return True
  else:
    return False

def close_far(a, b, c):
  if ((abs(b - a)) <= 1  and ((abs(c - a)) >= 2 and (abs(c - b))) >= 2):
    return True
  elif (abs(c - a)) <= 1 and (abs(b - a)) >= 2 and (abs(b - c)) >= 2:
    return True
  else: return False
  
def magicPair(a,b):
  if b < 10:
    if (a / 10) == b:
      if (a / 10) + b == (a % 10):
        return True
    if (a % 10) == b:
      if (a % 10) + b == (a / 10):
        return True
  else:
    if (a / 10) == (b / 10):
      if (a / 10) + (b / 10) == (a % 10) + (b % 10):
        return True
    if (a % 10) == (b % 10):
      if (a % 10) + (b % 10) == (a / 10) + (b / 10):
        return True
    if (a / 10) == (b % 10):
      if (a / 10) + (b % 10) == (a % 10) + (b / 10):
        return True
      else: return False
    if (a % 10) == (b / 10):
      if (a % 10) + (b / 10) == (a / 10) + (b % 10):
        return True
    if (a / 100) == (b / 10):
      if (a / 100) + (b / 10) == ((a / 10) % 10) + ((a % 100) % 10):
        return True
    if ((a % 100) % 10) == (b / 10):
      if ((a % 100) % 10) + (b / 10) == ((a / 10) % 10) + (b % 10):
        return True
      else: return False
    else: return False