include image 

#define width


#define lenght of triangle
triangle-lenght = 30
orange-triangle = triangle(triangle-lenght,"solid","orange")
orange-triangle

side-lenght = 40

color = "red"

sq = square(side-lenght,"solid",color)
sq

re = square(40,"solid","red")
re

check "same image, different code":
  sq is re
end

circle-radius = 20
rectangle-length = 100
rectangle-width = 60

yellow-circle = circle(circle-radius, "solid", "yellow")
black-rect = rectangle(rectangle-length, rectangle-width, "solid", "black")

two-circles = beside(yellow-circle, yellow-circle)
result = above(two-circles, black-rect)

result

flag = flag(
