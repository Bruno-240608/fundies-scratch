use context starter2024
check:
  true is true
  not(true) is false
  
  # and
  true and true is true
  false and true is false
  (4 < 5) and ((4 + 2) == 6) is true
  
  # or
  true or false is true
  false or false is false
  (4 > 5) or ("a" == "b") is false
end


fun choose-hat-debug(temp-in-C :: Number) -> String:
  doc: "determines appropriate head gear, with 27C or above a sun hat, below nothing"
  spy:
    temp-in-C,
    comparison: temp-in-C > 27
  end
  if temp-in-C >= 27:
    "sun hat"
  else:
    "no hat"
  end
where:
  choose-hat-debug(25) is "no hat"
  choose-hat-debug(32) is "sun hat"
  choose-hat-debug(27) is "sun hat"
end


# The full design recipe
# FOUR STEPS: do them in this order, and write the code last
# 1. Type annotation: What goes in, what comes out
# 2. Docstring: one English sentence saying what it is for
# 3. Examples: concrete input-output pairs in a where: block
# 4. Code: the body, written last


# if/else and ask expressions
# These are examples using a function parameter, so x is defined.

fun calculate(x :: Number) -> Number:
  if x == 0:
    1
  else if x > 0:
    x * 2
  else:
    x * -1
  end
end


fun calculate-ask(x :: Number) -> Number:
  ask:
    | x == 0 then: 1
    | x > 0 then: x * 2
    | otherwise: x * -1
  end
end


fun grade(marks :: Number) -> String:
  doc: "returns the letter grade for a mark out of 100"
  
  if marks >= 90:
    "A"
  else if marks >= 80:
    "B"
  else if marks >= 70:
    "C"
  else if marks >= 60:
    "D"
  else:
    "F"
  end
  
where:
  grade(95) is "A"
  grade(85) is "B"
  grade(75) is "C"
  grade(65) is "D"
  grade(45) is "F"
  grade(90) is "A"
  grade(95) is "A"
end


fun grade-ask(marks :: Number) -> String:
  doc: "returns the letter grade for a mark out of 100"
  ask:
    | marks >= 90 then: "A"
    | marks >=  80 then: "B"

 end
  