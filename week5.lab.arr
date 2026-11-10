use context dcic2024

include csv
include data-source
#|
Task plan (Task 2)
Inputs: dep_delay, arr_delay, tailnum, flight, carrier, dep_time
Outputs: cleaned flights_53 table with a dedup_key column + a duplicate count table

1. Load CSV into flights_53, num-sanitizer on numeric columns
2. tailnum: replace "" with "UNKNOWN" (transform-column + lam)
3. dep_delay, arr_delay: replace negatives with 0 (transform-column + lam)
4. Helper to turn dep_time (517) into "05:17" (num-floor, num-modulo, num-to-string)
5. build-column dedup_key = flight + "-" + clean carrier + "-" + time (trim, string-to-upper)
6. count on dedup_key to find duplicates (count 2+)
|#

flights_53 = load-table: rownames, dep_time, sched_dep_time, dep_delay, arr_time, sched_arr_time, arr_delay, carrier, flight, tailnum, origin, dest, air_time, distance, hour, minute, time_hour
  source: csv-table-file("flights_sample53.csv", default-options)
    sanitize rownames using num-sanitizer
  sanitize dep_time using num-sanitizer
  sanitize sched_dep_time using num-sanitizer
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

flights_step_1 = transform-column(flights_53, "tailnum", lam(t): if t == "": "Uknown" else: t end end) 
flights_step_2 = transform-column(flights_step_1, "dep_delay", lam(d): if d < 0:0 else: d end end)

flights_step_3 = transform-column(flights_step_2, "arr_delay", lam(a): if a < 0: 0 else: a end end)
fun trim(s :: String) -> String:
  doc: "Remove spaces from the given string."
  n = string-length(s)
  if n == 0:
    ""
  else:
    string-replace(s, " ", "")
  end
end

fun format-time(dep_time :: Number) -> String:
  doc: "returns the departure times in HH:MM format as a string"
  hours = num-floor(dep_time / 100)
  minutes = dep_time - (hours * 100)
  h-str = if hours < 10: "0" + num-to-string(hours) else: num-to-string(hours) end
  m-str = if minutes < 10: "0" + num-to-string(minutes) else: num-to-string(minutes) end
  h-str + ":" + m-str
where:
  format-time(1455) is "14:55"
  format-time(741) is "07:41"
end
flights_step_4 = build-column(flights_step_3, "dedup_key", lam(k): num-to-string(k["flight"]) + "-" +  trim(string-to-upper(k["carrier"])) + "-" + format-time(k["dep_time"]) end) 
count(flights_step_4, "dedup_key")
group(flights_step_4, "dedup_key")

flights_step_5 = transform-column(flights_step_4, "carrier", lam(c): trim(string-to-upper(c)) end)

freq-bar-chart(flights_step_5, "carrier")

flights_step_6 = filter-with(flights_step_5, lam(d): d["distance"] < 3000 end)


histogram(flights_step_6, "distance", 200)
scatter-plot(flights_step_6, "air_time", "distance")
distances = flights_step_6.get-column("distance")

fun total(lst :: List) -> Number block:
  doc: "Calculates total distance flown"
  var sum-so-far = 0
  for each(d from lst):
    sum-so-far := sum-so-far + d
  end
  sum-so-far
where:
  total([list: 0, 1, 2, 3]) is 6
  total([list: ]) is 0
end

fun maximum(lst :: List) -> Number block:
  doc: "Returns the largest distance"
  var max-so-far = 0
  for each(d from lst):
    if d > max-so-far:
      max-so-far := d
    else:
      max-so-far := max-so-far
    end
  end
  max-so-far
where:
  maximum([list: 3, 7, 2]) is 7
  maximum([list: 5]) is 5
end
  
 average = total(distances) / length(distances)
  
weeks-per-year =  48

check:
  weeks-per-year is 48
end

