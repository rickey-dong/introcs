def square(x):
  return x ** 2
  
def negate(n):
  return n * -1

def funkyCalc(x,y,z):
  return ((3 * x) + (0.5 * y)) / (2 * z) 

def distance(x1,y1,x2,y2):
  return ((((x2 - x1)** 2) + ((y2 - y1)** 2))** 0.5)

def ftoc(f):
    return (((f - 32) * 5) / 9.0)  

def ctof(c):
  return (((c * 9) / 5.0) + 32)

def evalQuadratic(a,b,c,x):
  return ((a * (x** 2)) + (b * x) + (c))

def isBig(n):
  return n > 10000

def isEven(n):
  return (n % 2) == 0

def sleep_in(weekday, vacation):
  return (not weekday) or (vacation)

def monkey_trouble(a_smile, b_smile):
  return (a_smile and b_smile) or (not a_smile and not b_smile)

def parrot_trouble(talking, hour):
  return (talking) and ((hour < 7) or (hour > 20)) 

def makes10(a, b):
  return ((a == 10) or (b == 10)) or (a + b == 10)

def near_hundred(n):
  return (n >= 90) and (n <= 110) or (n >= 190) and (n <= 210)

def pos_neg(a, b, negative):
  return ((negative == False) and ((a < 0 and b > 0) or (a > 0 and b < 0))) or ((negative == True) and (a < 0 and b < 0))

;