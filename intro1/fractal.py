import turtle

ret = turtle.Turtle()

def dragon(turtle, depth, size):
    if depth == 0:
        turtle.fd(size)
    else:
        dragon(turtle, depth - 1, size)
        turtle.lt(120)
        dragon(turtle, depth - 1, size)
        turtle.rt(120)
        dragon(turtle, depth - 1, size)
        
#dragon(ret, 2, 25)
dragon(ret, 6, 10)
window = turtle.Screen()
window.exitonclick()