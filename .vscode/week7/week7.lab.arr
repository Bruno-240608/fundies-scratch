use context dcic2024

data SensorNet:
  |hub(bandwidth :: Number, left :: SensorNet, right :: SensorNet)
  |sensor(rate :: Number)
end

# Example network
sA = sensor(60)
sB = sensor(120)
sC = sensor(45)

#you can construct larger networks like:
hub1 = hub(150,sA,sB)
core = hub(200, hub1, sC)

fun total-load(n :: SensorNet) -> Number:
  doc: "returns the sum of all sensor rates given the sensor net"
  cases (SensorNet) n:
    |hub(bandwith, left, right) => total-load(left) + total-load(right) 
    |sensor(rate) => rate
  end
where:
  total-load(sA) is 60
  total-load(sB) is 120
  total-load(sC) is 45
  total-load(hub1) is 180
  total-load(core) is 225
end

fun fits-capacities(n :: SensorNet) -> Boolean:
  doc: "returns the validity of a network based on its bandwith being as large as as the total load of its children"
  cases (SensorNet) n:
    |hub(bandwith, left, right) =>  bandwith >= (total-load(left) + total-load(right))
    |sensor(rate) => true
  end
where:
  fits-capacities(sA) is true
  fits-capacities(sB) is true
  fits-capacities(sC) is true
  fits-capacities(hub1) is false
  fits-capacities(core) is false
end

fun deepest-depth(n :: SensorNet) -> Number:
  doc: "receives data from SensorNet and outputs the dept of the deepest sensor"
  cases (SensorNet) n:
    |hub(bandwith, left, right) => 1 + num-max(deepest-depth(left), deepest-depth(right))
    |sensor(rate) => 0
  end
where:
  deepest-depth(sA) is 0
  deepest-depth(sB) is 0
  deepest-depth(sC) is 0
  deepest-depth(hub1) is 1
  deepest-depth(core) is 2
end

fun apply-scale(n :: SensorNet, s :: Number) -> SensorNet:
  doc: "returns sensors with applied scaling factor"
  cases (SensorNet) n:
    | hub(bandwith, left, right) => hub(bandwith, apply-scale(left, s),apply-scale(right, s))
    |sensor(rate) => sensor(rate / s)
  end
where:
  apply-scale(hub1, 2) is hub(150, sensor(30), sensor(60))
  apply-scale(sA, 2) is sensor(30)
end

fun needed-scale(n :: SensorNet) -> Number:
  cases (SensorNet) n:
    | sensor(rate)  => 1
    | hub(bw, l, r) =>
      block:
        load = total-load(l) + total-load(r)
        here = load / bw
        num-max( num-max(here, needed-scale(l)), needed-scale(r) )
      end
  end
where:
  # For 'core': max(225/200 = 1.125, hub1: 180/150 = 1.2) = 1.2
  needed-scale(core) is 1.2
end

fun scale-to-fit(n :: SensorNet) -> SensorNet:
  doc: "returns feasibly network through scaling"
  if needed-scale(n) <= 1:
    n
  else:
    apply-scale(n,needed-scale(n))
  end  
where:
  scale-to-fit(sA) is sA
  scale-to-fit(hub1) is hub(150, sensor(50), sensor(100))
end

    
        