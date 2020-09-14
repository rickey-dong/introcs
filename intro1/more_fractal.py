import turtle

hol = turtle.Turtle()
hol.lt(90)

def tree(turtle, depth, size, angle):
    if depth == 0:
        turtle.fd(size)
        turtle.bk(size)
    else:
        tree(turtle, depth - 1, size, angle)
        turtle.fd(size)
        turtle.lt(angle)
        tree(turtle, depth - 1, size, angle)
        turtle.rt(angle * 2)
        tree(turtle, depth - 1, size, angle)
        turtle.lt(angle)
        turtle.bk(size)

tree(hol, 1, 30, 40)

hol.clear()

tree(hol, 2, 30, 40)

hol.clear()

hol.rt(90)
hol.setx(-150)
    
def sep_triangle(turtle, depth, size):
    if depth == 0:
        turtle.fd(size)
        turtle.lt(120)
        turtle.fd(size)
        turtle.lt(120)
        turtle.fd(size)
        turtle.lt(120)
    else:
        sep_triangle(turtle, depth - 1, size)
        sep_triangle(turtle, depth - 1, size / 2)
        turtle.fd(size / 2)
        sep_triangle(turtle, depth - 1, size / 2)
        turtle.bk(size / 2)
        turtle.lt(60)
        turtle.fd(size / 2)
        turtle.rt(60)
        sep_triangle(turtle, depth - 1, size / 2)
        turtle.rt(120)
        turtle.fd(size / 2)
        turtle.lt(120)
        
sep_triangle(hol, 0, 300)

hol.clear()

sep_triangle(hol, 2, 300)

hol.clear()

window = turtle.Screen()
window.exitonclick()