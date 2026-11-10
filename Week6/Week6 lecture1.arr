use context dcic2024
data Post:
    post(username :: String, caption :: String, likes :: Number, shares :: Number)
end

post-1 = post("@climate_now", "Artice sea ice hits a record low", 1250, 340)
post-2 = post("@cityfarm", "Our rooftop garden this week", 85, 4)
post-3 = post("@nu_london", "Welcome to week 6!", 410, 12)

feed :: List<Post> = [list: post-1, post-2, post-3]

post-1.likes
feed.length()

#functions over a Post
fun engagement(p :: Post) -> Number:
  doc: "likes plus shares for a post"
  p.likes + p.shares
where:
  engagement(post-1) is 1590
  engagement(post("@hello", "hello this is james Bond", 0, 0)) is 0 
end

fun is-viral(p :: Post) -> Boolean:
  doc: "true when a post has more than 1000 likes"
  p.likes > 1000
where:
  is-viral(post-1) is true
  is-viral(post-2) is false
  is-viral(post("@Jamesbond", "Hello, My name is James Bond", 1000, 50)) is false 
end

#conditional data:
#Priority: Variants with no fields:
data Priority:
  | Low
  | Medium
  | High    # Fixed to capital H
end

data Task:
  | task(description :: String, priority :: Priority)
  | note(description :: String)
end


# Make sure these use the exact capitalized names
task-1-priority = Low
task-2-priority = Medium
task-3-priority = High

check:
  is-Priority(task-1-priority) is true
  # Note: The built-in tester functions will mirror the capitalization of your variants
  is-Low(task-2-priority) is false
  is-Medium(task-3-priority) is false
end

# Update your task creation to use the capitalized variants as well
task-1 = task("Buy groceries", High)
task-2 = task("pay taxes", Low)
note-1 = note("Mañana tengo junta con Jubin")

task-1.priority
note-1.description
is-task(task-1)
is-note(task-1)

#describe
fun describe(t :: Task) -> String:
  cases (Task) t:
    |task(d,p) => "Task: " + d 
    |note(d) => "NOTE: " + d
  end
end

#the task(d, p) pattern must have one name per field, in order.
# The note branch has one namem because note has one field

describe(task-1)
describe(note-1)

fun is-urgent(t :: Task) -> Boolean:
  doc: "true for a task with high priority; notes are never urgent"
  cases (Task) t:
    | task(d, p) => is-High(p)
    | else => false
  end
where:
  is-urgent(task-2) is true
  is-urgent(task-1) is true
  is-urgent(note-1) is false
end

#a variant with no branch
fun describe-again(t :: Task) -> String:
  cases (Task) t:
    | task(d, p) => "TASK: " + d
  end
end

describe-again(task-1)
#describe-again(note-1)

data temperature:
  |celsius(degrees :: Number)
  |fahrenheit(degrees :: Number)
  |kelvin(degrees :: Number)
end

fun to-celsius(t :: temperature) -> Number:
  cases (temperature) t:
    |celsius(c) => c
    | fahrenheit(f) => (f - 32) * (5 / 9)
    | kelvin(k) => k-273.15
  end
end
