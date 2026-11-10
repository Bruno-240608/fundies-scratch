use context dcic2024

# Bruno

# exercise 1
#1 
(3 * 3.20) # this will give 9.6
#2
"Oat" + " " + "latte" # this will give "Oat latte"
#3
string-length("cappuccino") # this will give 10 as there are 10 characters

# exercise 2
latte-price :: Number = 3.20
fun order-cost(drinks :: Number, price :: Number) -> Number:
  doc: "returns total cost of order"
  price * drinks
where: order-cost(2,latte-price) is 6.40
  order-cost(0,latte-price) is 0
end

#exercise 3 
fun discount-rate(drinks :: Number) -> Number:
  doc: "returns the discount rate based on number of drinks"
  if drinks < 5:
    0
  else if (drinks >= 5) and (drinks <= 9):
    0.1
  else:
    0.2
  end
where:
    discount-rate(4) is 0
    discount-rate(5) is 0.1
    discount-rate(9) is 0.1
    discount-rate(10) is 0.2
end
  
#exercise 4
orders = table: customer, drinks, price
  row: "Amira", 2, 3.20
  row: "Ben", 6, 2.80
  row: "Chen", 12, 3.00
  row: "Dara", 1, 3.50
end

cost-included = build-column(orders, "cost", lam(r): r["drinks"] * r["price"] end)

thirsty-customers = filter-with(cost-included, lam(r): r["drinks"] >= 5 end)

#Customers left are Ben and Chen

#exercise 5

drinks-list = orders.get-column("drinks")

fun total-drinks-loop(drinks-num :: List<Number>) -> Number block:
  doc: "returns total drinks"
  var total = 0
  for each(d from drinks-num):
    total := total + d
  end 
  total
end


fun total-drinks-fold(drinks-num :: List<Number>) -> Number:
  doc: "returns total drinks using fold"
  drinks-num.foldl(lam(d, acc): d + acc end, 0)
end

check:
  total-drinks-loop(drinks-list) is total-drinks-fold(drinks-list)
end


#Exercise 6 
data Order:
  | eat-in(drinks :: Number)
  | takeaway(drinks :: Number, own-cup :: Boolean)
end

fun cup-fee(o :: Order) -> Number:
  doc: "returns cup fee in pounds where  0.25 per drink for a takeaway without its own cup, and 0 otherwise"
  cases (Order) o:
    | eat-in(_) => 0
    | takeaway(drinks, own-cup) =>
      if own-cup: 0
      else: 0.25 * drinks
      end
  end
where: 
  cup-fee(eat-in(2)) is 0
  cup-fee(takeaway(2, true)) is 0
  cup-fee(takeaway(2, false)) is 0.50
end

fun total-drinks-rec(nums :: List<Number>) -> Number:
  doc: "adds up list of numbers using recursion"
  cases (List) nums:
    | empty => 0
    | link(f, r) => f + total-drinks-rec(r)
  end
where:
  total-drinks-rec([list: 12, 8, 2]) is 22
  total-drinks-rec([list: ]) is 0
end

  