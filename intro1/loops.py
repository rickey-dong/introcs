def sumFromZeroToN(n):
  i = 0
  while n > 0:
    i = i + n
    n = n - 1
  return(i)
      
      
def sumAtoB(a,b):
  i = 0
  while b >= a:
    i = i + b
    b = b - 1
  return i

def fiveSumFromZeroToN(n):
  i = 0
  while n > 0:
    if n % 5 == 0:
      i = i + n
    n = n - 1
  return i


def specialSumInclusive(n):
  i = 0
  while n > 0:
    if n % 5 == 0 or n % 3 == 0:
      i = i + n
    n = n - 1
  return i

def specialSumExclusive(n):
  i = 0
  while n > 0:
    if n % 7 == 0  and n % 5 == 0:
      i = i + n
    n = n - 1
  return i


def sumOfFirstNSquares(n):
  i = 0
  while n > 0:
    i = i + (n * n)
    n = n - 1
  return i


def sumSquaresBetween(a,b):
  i = 0
  if (a**.5) % 1 != 0:
    c = ((a**.5) // 1) + 1
  else:
    c = (a**.5) // 1
  while c <= (b**.5):
    i = i + c**2
    c = c + 1
  return int(i)

def sumOfPowers(n):
  i = 0
  p = 1
  while 2**p <= n:
    i = 2**p + i
    p = p + 1
  return i

def sumDigits(n):
  i = 10
  while abs(n) / i >= 1:
    i = i * 10
  current = abs(n)
  l = 0
  t = 0
  while i != 0:
    l = current // i
    t = t + l
    current = current - l * i
    i = i / 10
  return t

def countDigits(n):
  d=1
  div= 10
  while abs(n) / div > 0:
    d = d + 1
    div = div * 10
  return d

def countOddDigits(n):
  d = 10
  while abs(n) / d > 1:
    d = d * 10
  c = abs(n)
  l = 0
  t = 0
  while d != 0 and d > 0:
    l = c // d
    if l%2 == 1:
      t = t + 1
    c = c - l * d
    d = d / 10
  return t

def countPrimeDigits(n):
  d = 10
  while abs(n) / d > 1:
    d = d * 10
  c = abs(n)
  l = 0
  t = 0
  while d != 0 and d > 0:
    l = c // d
    if l == 2 or l == 3 or l == 5 or l == 7:
      t = t + 1
    c = c - l * d
    d = d / 10
  return t
