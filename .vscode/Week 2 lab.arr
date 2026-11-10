include image 
#t-shirt shop
#calculate the cost
c = 12 #string that represents the total value of a t-shirt
s = 3 #string that represents the total value of a deisgn fee

total = (5 * c) + s #the cost for 5 identical t-shirts + the design fee
total

second_total = (7 * c) + s #the cost for 7 identical t-shirts + design fee
second_total

#
#rectangular poster
height = 420 #string representing the value of the heigh of the poster
width = 594 #string representing the value of the width of the poster
perimeter = 2 * (width + height)# expresion representing the equation of the perimeter
price = perimeter * 0.10#
price

#if you forgot the parentheses, the width would be multiplied by 2 and the heigh added to the result of that equation

#string surprises
#saving a tagline
tagline = "Designs for everyone!"#if you remove quote , you get an error, hence to fix it you need to add it back
tagline
#colour inventory
r = "red" #assing value to string of colors
b = "blue"
g = "green"

r + b # if you add the two colors, it outputs a combination of the strings
# if you do 1 + "blue" you will get an error since the operator expects to be given two numbers or two strings

#traffic light
base = rectangle(40, 100, "solid", "black")#asigning value to rectangle paramets
# assigning value to remianing circles
red = circle(15,"solid","red")
green = circle(15,"solid","green")
yellow = circle(15,"solid","yellow")

ry = above(red,green) #above function allows to position red circle over the green one
rg = above(yellow,ry) #we used the variable assigned to the new position in order to position the new figure in the same rectangle and not generate a new one
light = overlay(rg,base) #final variable using past values  to place one on top of the other, resulting in the traffic light 
light

#pole exercise
pole = rectangle(30,90,"solid","black")#assign value to pole
above(light,pole)

#broken code hunt
# Goal: A rectangle with width 50 and height 20, solid black
rectangle(50,20,"solid", "black") # you had to move the string "solid" to the right and the height of the rectangle to the left
circle(30, "solid", "red") #the string solid was missing quotating marks hence the error

#flag design 

rect = rectangle(200,150,"solid","red")
ye = rectangle(50,152,"solid","black")
rs = rectangle(50,150,"solid","yellow")
step1 = overlay-xy(rs,2,1,rect) #use overlay-xy to position the preceding variables by parameters such as 2 and 1
flag = overlay-xy(ye,-160,0,step1)

flag