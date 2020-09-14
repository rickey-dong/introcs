import turtle

john = turtle.Turtle()

def regular_polygon(turtle, numberofsides, size):
    turtle.pu()
    turtle.sety(-240)
    turtle.setx(-240)
    turtle.pd()
    sides = 0
    while sides < numberofsides:
        turtle.rt(360 / numberofsides)
        turtle.fd(size)
        sides += 1

regular_polygon(john, 5, 100)

def square_spiral(turtle, size):
    turtle.pu()
    turtle.setx(240)
    turtle.pd()
    while size > 0:
        turtle.fd(size)
        turtle.rt(90)
        size -= 1

square_spiral(john, 50)

def spiral(turtle, size, angle):
    turtle.pu()
    turtle.setx(0)
    turtle.sety(100)
    turtle.pd()
    while size > 0:
        turtle.fd(size)
        turtle.rt(angle)
        size -= 0.5
        
spiral(john, 30, 20)

window = turtle.Screen()
window.exitonclick()

