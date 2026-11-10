use context starter2024
include csv
include data-source
workouts = table: date :: String, activity :: String, duration :: Number
  row: "2026-04-01", "Running", 30
  row: "2026-04-02", "Running", 30
  row: "2026-04-03", "Cycling", 60
end
check: 
  table: date :: String, activity :: String, duration :: Number
    row: "2026-04-01", "Running", 30
    row: "2026-04-02", "Running", 30
  row: "2026-04-03", "Cycling", 60
  end
  is
  table: date :: String, activity :: String, duration :: Number
    row: "2026-04-01", "Running", 30
    row: "2026-04-02", "Running", 30
    row: "2026-04-03", "Cycling", 60
  end
end
  workouts
first-row = workouts.row-n(0)
first-row

first-row['activity']
workouts.row-n(1)["duration"]




recipes = load-table:
  title :: String,
  servings :: Number,
  prep-time :: Number
  source: csv-table-url("https://raw.githubusercontent.com/NU-London/LCSCI4207-datasets/refs/heads/main/recipes.csv", default-options)
  sanitize servings using num-sanitizer
  sanitize prep-time using num-sanitizer
end

recipes
recipes.length()



#State first column :: data type and further 

glucose-levels = load-table:
  plant_commmon_name :: String,
  location_latitude :: Number,
  location_longitue :: Number,
  date_sighted :: Number,
  soil_type :: String,
  plant_height_cm :: Number,
  plant_color :: String,
  source: csv-table-url("https://raw.githubusercontent.com/NU-London/LCSCI4207-datasets/refs/heads/main/plant_sightings.csv", default-options)
  sanitize 
  
  
  