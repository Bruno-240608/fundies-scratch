use context dcic2024
#|
   fun f(fp :: Footprint) -> ...:
   cases (Footprint) fp:
   |split(name,left,right) => ...f(left) ..f(right) ..
   |activity (name, kg) => .....
|#

data Footprint:
  | split(name :: String, left :: Footprint, right :: Footprint)
  |activity(name :: String, kg :: Number)
end

car = activity("car", 900)
flights = activity("flight", 1500)
heating = activity("heating", 1100)

travel = split("travel", car, flights)
my-footprint = split("my year", travel, heating)

#what is the total co-2?
fun total-co2(fp :: Footprint) -> Number:
  cases (Footprint) fp:
    |split(name, left, right) => total-co2(left) + total-co2(right)
    |activity(name, kg) => kg
  end
where:
  total-co2(car) is 900
  total-co2(my-footprint) is 3500
end

fun count-splits(fp :: Footprint) -> Number:
  cases(Footprint) fp:
    |split(name, left, right) =>
      1 + count-splits(left) + count-splits(right)
    |activity(name, kg) => 0
  end
where: 
  count-splits(car) is 0
  count-splits(my-footprint) is 2
  count-splits(travel) is 1
end

fun total-co2-left(fp :: Footprint) -> Number:
  cases(Footprint) fp:
    |split(name, left, right) => total-co2-left(left)
    |activity(name, kg) => kg
  end
end

check "only the left most activity is counted":
  total-co2-left(car) is 900
  total-co2-left(my-footprint) is 900
end

#practice exercises 
data River:
  | merge(width :: Number, left :: River, right :: River)
  | stream(flow-rate :: Number)
end
stream-a = stream(5)
stream-b = stream(3)
stream-c = stream(8)
merge-1 = merge(12, stream-a, stream-b)
main-river = merge(15, merge-1, stream-c)

fun total-flow(r :: River) -> Number:
  cases (River) r:
    | merge(width, left, right) => total-flow(left) + total-flow(right)
    | stream(flow) => flow
  end
where:
  total-flow(stream-a) is 5
  total-flow(main-river) is 16
end 

fun count-merges(r :: River) -> Number:
  cases (River) r:
    | merge(width, left, right) => 1 + count-merges(left) + count-merges(right)
    | stream(flow) => 0
  end
where:
  count-merges(stream-a) is 0
  count-merges(main-river) is 2
end

fun count-streams(r :: River) -> Number:
  cases (River) r:
    | merge(width, left, right) =>  count-streams(left) +  count-streams(right)
  | stream(flow) => 1
end
where:
  count-streams(stream-a) is  1
  count-streams(main-river) is 3
end

fun max-width(r :: River) -> Number:
  cases (River) r:
    |merge(width, left, right) =>  num-max(width, num-max(max-width(left), max-width(right)))
    |stream(flow) => 0
  end
where:
  max-width(stream-a) is 0
  max-width(main-river) is 15
  max-width(merge-1) is 12
end

fun widen-river(r :: River, amount :: Number) -> River:
  cases (River) r:
    |merge(width, left, right) => merge(width + amount, widen-river(left, amount), widen-river(right, amount))
    |stream(flow) => stream(flow)
  end
where:
  widen-river(stream-a, 10 ) is  stream-a
  widen-river(main-river, 10 ) is merge(25,merge(22, stream-a,stream-b), stream-c)
end

fun cap-flow(r :: River) -> River:
  cases (River):
    |merge(width, left, right) => merge(width, cap-flow(left, cap), cap-flow(right,cap)
      |stream(flow) => stream(num-min, cap))