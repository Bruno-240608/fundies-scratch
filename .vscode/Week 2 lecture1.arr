use context starter2024



x = 'Isabella'
y = 'Rei'
z = 'Adi'

fun area(width, height):
  width * height
end

check:
  area(3, 20) is 3 * 20
  area(4, 50) is 4 * 50
end

fun welcome(name :: String) -> String:
  doc: "returns a greeting addressed to given a person" "Welcome to class, " + name
end

check:
  welcome('Isabella') is "Welcome to class, Isabella"
  welcome('Rei') is "Welcome to class, Rei"
end

armenia = frame(
  above(rectangle(120, 30, "solid", "red"),
    above(rectangle(120, 30, "solid", "blue"),
      rectangle(120, 30, "solid", "orange"))))

austria = frame(
  above(rectangle(120, 30, "solid", "red"),
    above(rectangle(120, 30, "solid", "white"),
      rectangle(120, 30, "solid", "blue"))))

fun three-stripe-flag(top,middle,bot):
  frame(
    above(rectangle(120,30, "solid", top),
      above(rectangle(120,30,"solid", middle),
      rectangle(120,30,"solid", bot))))
end


fun total_cost(num_tshirts :: Number, shirt_string :: String) -> Number:
  
  doc: "Calculate the price of t-shirt based on quantity and number of characters printed on it"
  num_tshirts * (5.00 + (string-length(shirt_string) * 0.10))
end

fun celsius-to-fahrenheit(celsius :: Number) -> Number:
  
  doc: "Converts Celsius to Fahrenheit"
  
  (celsius * (9 / 5)) + 32

end

celsius-to-fahrenheit(32)

fun fahrenheit-to-celsius(fahrenheit :: Number) -> Number:
  
  doc: "Converts Fahrenheit to Celsius"

  ((fahrenheit - 32) * 5) / 9

end