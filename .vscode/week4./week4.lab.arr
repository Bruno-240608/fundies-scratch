use context dcic2024

include csv
include data-source

flights = load-table:
  rownames :: Number,
  dep_time :: Number,
  sched_dep_time :: Number, 
  dep_delay :: Number,
  arr_time :: Number, 
  sched_arr_time :: Number,
  arr_delay :: Number,
  carrier :: String,
  flight :: Number, 
  tailnum :: String,
  origin :: String,
  dest :: String,
  air_time :: Number,
  distance :: Number,
  hour :: Number,
  minute :: Number,
  time_hour :: String
  source: csv-table-file("flights.csv", default-options) 
  sanitize rownames using num-sanitizer
  sanitize dep_time using  num-sanitizer
  sanitize sched_dep_time using  num-sanitizer
  sanitize dep_delay using num-sanitizer
  sanitize arr_time using num-sanitizer
  sanitize sched_arr_time using num-sanitizer
  sanitize arr_delay using num-sanitizer
  sanitize flight using num-sanitizer
  sanitize air_time using num-sanitizer
  sanitize distance using num-sanitizer
  sanitize hour using num-sanitizer
  sanitize minute using num-sanitizer 
end

fun is_long_flight(row :: Row) -> Boolean:
  doc: " function shows if a flight is long or not depending on its distance"
  row["distance"] >= 1500
  where: 
  is_long_flight(flights.row-n(0)) is false
  is_long_flight(flights.row-n(3)) is true
  is_long_flight(flights.row-n(6)) is  false
end

new-flights = filter-with(flights, is_long_flight) #filter with input the is_long_flight function condition into the flights table

new-flights

long-flights-descending = flights.order-by("air_time", false)#false orders the column air_time values in descending order
long-flights-descending

long-flights-descending.row-n(0)
row-0 = long-flights-descending.row-n(0)
row-0["distance"]
row-0["origin"]
row-0["dest"]

fun is_delayed_departure(row :: Row) -> Boolean:
  doc: "checks if  departure delay are longer or equal to 30"
  row["dep_delay"] >= 30
where:
  is_delayed_departure(flights.row-n(0)) is false
  is_delayed_departure(flights.row-n(55)) is true
  is_delayed_departure(flights.row-n(54)) is false
end

updated_flights = filter-with(flights, is_delayed_departure)#updated_flights condition inserted into flights table

fun is_morning_sched_dep(row :: Row) -> Boolean:
  doc: "checks if scheduled departure time is before noon"
  row["sched_dep_time"] < 1200
where:
  is_morning_sched_dep(flights.row-n(0)) is true
  is_morning_sched_dep(flights.row-n(296)) is false
  is_morning_sched_dep(flights.row-n(57)) is true
end

morning_sched_flights = filter-with(flights, is_morning_sched_dep)

delayed_flights = filter-with(flights,lam(row): row["dep_delay"] >= 30 end)

delayed_morning_flights = filter-with(delayed_flights,lam(row): row["sched_dep_time"] < 1200 end)

long_delayed_morning_flights = filter-with(delayed_morning_flights, lam(row): row["distance"] > 500 end)

descending_delay = order-by(long_delayed_morning_flights, "dep_delay", false)
worst_del_flight = descending_delay.row-n(0)

worst-flight-number = worst_del_flight["flight"]
worst-origin = worst_del_flight["origin"]
worst-dep-delay = worst_del_flight["dep_delay"]

flights_step_1 = transform-column(flights, "dep_delay", lam(d): if d < 0:0 else: d end end)

flights_step_2 = transform-column(flights_step_1, "arr_delay", lam(a): if a < 0: 0 else: a end end)

flights_step_3 = build-column(flights_step_2, "effective_speed", lam(row): if row["air_time"] > 0: row["distance"] / (row["air_time"] / 60) else: 0 end end)

descending_effective_speed = order-by(flights_step_3, "effective_speed", false)

fastest_flight = descending_effective_speed.row-n(0)
fastest-carrier = fastest_flight["carrier"]
fastest-origin = fastest_flight["origin"]
fastest-dest = fastest_flight["dest"]

fun apply-arrival-discount(t :: Table) -> Table:
  doc: "Reduces arr_delay by 20% when 0 <= arr_delay <= 45."
  transform-column(t, "arr_delay,"
    lam(d): if (d >= 0) and (d <= 45): d * 0.8 else: d end end)
where:
  apply-arrival-discount(table: arr_delay
    row: -10
    row: 0
    row: 30
    row: 60
  end) is table: arr_delay
    row: -10
    row: 0
    row: 24
    row: 60
  end
end

  
  


