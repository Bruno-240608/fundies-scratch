use context starter2024

fun is-leap-year(year :: Number) -> Boolean:
  doc: "returns  if a year is a leap, num-modulo checks if it is divisible by 4"
  #the true condition
  if num-modulo(year, 4) == 0: 
    true
  else if num-modulo(year, 100) == 0: #checks century years which are divisable by 4 but not leap years are accounted as false 
  false
  else: #the false condition which is the rest 
    false
  end
         
where:
  is-leap-year(2020) is true
    is-leap-year(2025) is false
  is-leap-year(2028) is true
  is-leap-year(2023) is false 
  is-leap-year(1900) is false 
  is-leap-year(2000) is true
end 
  
fun tick(seconds :: Number) -> Number:
  doc: "takes number of seconds and returns the next second"
  if (seconds >= 60) and (seconds <= -1): #possible false conditions
    raise("invalid second")
  else if seconds == 59:
    0
  else:
      seconds + 1
    end

    where:
    tick(8) is 9
    tick(0) is 1 
  tick(59) is 0
  
  end
    

fun rock-paper-scissors(player1 :: String, player2 :: String) -> String:
  doc: "Takes the choices of two players (each 'rock', 'paper', or 'scissors') and returns 'player 1' or 'player 2' to indicate the winner, 'tie' if both players chose the same thing, or 'invalid choice' if either input isn't one of the three valid choices."
  ask:
    | (player1 == "rock") and (player2 == "scissors") then: "player 1"
    | (player1 == "scissors") and (player2 == "rock") then: "player 2"
    | (player1 == "paper") and (player2 == "rock") then: "player 1"
    | (player1 == "rock") and (player2 == "paper") then: "player 2"
    | (player1 == "scissors") and (player2 == "paper") then: "player 1"
    | (player1 == "paper") and (player2 == "scissors") then: "player 2"
    | player1 == player2 then: "tie"
    | otherwise: "invalid choice"
  end 
where:
  rock-paper-scissors("rock", "scissors") is "player 1"
  rock-paper-scissors("scissors", "rock") is "player 2"
  rock-paper-scissors("paper", "rock") is "player 1"
  rock-paper-scissors("rock", "paper") is "player 2"
  rock-paper-scissors("scissors", "paper") is "player 1"
  rock-paper-scissors("paper", "scissors") is "player 2"
  rock-paper-scissors("rock", "rock") is "tie"
  rock-paper-scissors("paper", "paper") is "tie"
  rock-paper-scissors("scissors", "scissors") is "tie"
  rock-paper-scissors("lizard", "rock") is "invalid choice"
  rock-paper-scissors("rock", "puck") is "invalid choice"
end
              
            
planets = table: planet :: String, Distance :: Number
  row: "Mercury", 0.39
  row: "Venus", 0.72
  row: "Earth", 1
  row: "Mars", 1.52
  row: "Jupiter", 5.2
  row: "Saturn", 9.54
  row: "Uranus", 19.2
  row: "Neptune", 30.06
end

mars = planets.row-n(3)
mars-distance = mars["Distance"]
  
 

    
    
    
   
    
    
      
