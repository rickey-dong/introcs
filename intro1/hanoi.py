def hanoi(n, start, middle, end):
    if n == 1:
        print(str(start) + " to " + str(end))
    else:
        hanoi(n-1, start, end, middle)
        hanoi(1, start, middle, end)
        hanoi(n-1, middle, start, end)

hanoi(3, 0, 1, 2)