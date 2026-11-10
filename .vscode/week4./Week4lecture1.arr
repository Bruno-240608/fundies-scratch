use context dcic2024
include csv

#function over spefici rows

#filter-with passes function as an argument

#higher-order function, it takes a function as one of its arguments

#filter-with(function)

orders = table: time, amount
  row: "08:00", 10.50
  row: "09:30", 5.75
  row: "10:15", 8.00 #index 2
  row: "11:00", 3.95 #index 3
  row: "14:00", 4.95 
  row: "16:95", 7.95
end
orders

fun is-high-value(o :: Row) -> Boolean:
  o["amount"] >= 8.0
where:
  is-high-value(orders.row-n(2))  is true 
  is-high-value(orders.row-n(4)) is false
end 

new-high-orders = filter-with(orders, is-high-value) 

high-value-orders = table: time, amount
  row: "08:00", 10.50
  row: "10.15", 8.00
end

check:
  new-high-orders is high-value-orders
end

check:
  new-high-orders is high-value-orders
end

filter-with(orders, lam(o): o["amount"] >= 8.0 end)

#order-by
order-by(orders, "amount", true) #ascending 
order-by(orders, "amount", false) #descending

fun is-morning(o :: Row) -> Boolean:
  o["time"] <= "12:00"
where:
  is-morning(orders.row-n(4)) is false
  is-morning(orders.row-n(2)) is true
  is-morning(orders.row-n(0))  is true
  is-morning(orders.row-n(5)) is false
end

morning-orders  = filter-with(t: table, keep time, lam(o): o["time"] <= "12:00" end)

fun compute-sum(f-number :: Number, s-number :: Number) -> Number:
  doc:"this function takes two numbers and compute thier sum"
  f-number + s-number
where:
  compute-sum(2, 3) is 5
  compute-sum(9, 9) is 18
  compute-sum(6, 7) is 13
end 

