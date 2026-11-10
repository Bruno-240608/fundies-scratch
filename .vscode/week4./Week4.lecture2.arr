use context dcic2024


#|
  the two operations:
   1-transform-column:
   your function takes: one value
   you get back: same columns, new values in one
   
   2- build column:
   your function takes: one whole Row
   you get back: one extra column
|#

sales = table: item :: String, price :: Number, qty :: Number
  row: "Tea", 2.50, 4
  row: "Coffe", 3.00, 2
  row: "Cake", 4.25, 3
end

#transform column
#add VAT to every price.
fun add-vat(p :: Number) -> Number:
  doc: "returns the price with 20 percent VAT added"
  p * 1.2
where:
  add-vat(10) is 12
  add-vat(0) is 0
end

with-vat = transform-column(sales, "price", add-vat)
with-vat.get-column("price")
with-vat.get-column("price")

transform-column(sales, "price", lam(p): p * 1.2 end)

#build-column
fun line-total(r :: Row) -> Number:
  doc: "returns price times quantity for one order line"
  r["price"] * r["qty"] 
where: 
  line-total(sales.row-n(0)) is 10
  line-total(sales.row-n(2)) is 12.75
  end
  
  with-total = build-column(sales, "total", line-total)
  with-total.get-column("total")

billed = build-column(transform-column(sales, "price", add-vat), "total", line-total) 
  
  #build-column(sales, "total", line-total)
  #transform-column(sales, "price", add-vat)

items = table: item :: String, x-coordinate :: Number, y-coordinate :: Number
  row: "Sword of Dawn",           23,  -87
  row: "Healing Potion",         -45,   12
  row: "Dragon Shield",           78,  -56
  row: "Magic Staff",             -9,   64
  row: "Elixir of Strength",      51,  -33
  row: "Cloak of Invisibility",  -66,    5
  row: "Ring of Fire",            38,  -92
  row: "Boots of Swiftness",     -17,   49
  row: "Amulet of Protection",    82,  -74
  row: "Orb of Wisdom",          -29,  -21
end

fun subtract-1(n :: Number) -> Number:
  doc: "subtracts 1 from input"
  n - 1
where:
  subtract-1(10) is 9
  subtract-1(0) is -1
  subtract-1(-3.5) is -4.5
end

fun pull-closer(t :: Table) -> Table:
  doc: "returns the table with every item moved 10 percent nearer the origin"
  transform-column(
    transform-column(t, "x-coordinate", (lam(n:: Number) -> Number: n * 0.9 end), 
      "y-coordinate", lam(n :: Number) -> Number: n * 0.9 end
      )
    
new-items = 
  transform-column(
    transform-column(items, "x-coordinate", lam(x): x * 0.9 end),
    "y-coordinate", lam(y): y * 0.9 end)
closest = order-by(
  build-column(new-items, "d",
    lam(r): num-sqr(r["x-coordinate"]) + num-sqr(r["y-coordinate"]) end),
  "d", true).row-n(0)["item"]

