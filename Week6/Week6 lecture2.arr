use context dcic2024


#|
   cases (List) l:
   | empty = > ... #the answer for no elements
   | link (f, r) => ...#combine f with the answer for r
   end
|#

[list: 1, 2, 3].first # 1
[list: 1, 2, 3].rest #[list: 2, 3]
[list: 1].rest #empty /nothing
is-link([list:1, 2, 3].rest) #true
is-empty([list: ]) #true
is-empty([list: 3].rest) #true

#building lists with link

check:
  [list: ] is empty
  [list: 1] is link(1, empty)
  [list: 1, 2] is link(1, link(2, empty))
  [list: 1, 2, 3] is link(1, link(2, link(3, empty)))
end


link(1, link(2, link(3, empty)))

temp-list = link(1, link(2, link(3, empty)))
temp-list.length()

fun my-len(l):
  cases (List) l:
    |empty => 0
    | link(f,r) => 1 + my-len(r)
  end
where:
  my-len([list: 4, 5, 6, 7, 8, 9]) is 6
end

my-len([list: 3, 4])

check "some of my-len examples":
  my-len([list:1,2, 3]) is 3
  my-len([list: ]) is 0
  my-len([list: 7, 8, 9]) is 1 + my-len([list: 8, 9])
  my-len([list: 7, 8, 9]) is 1 + my-len([list: 7, 8, 9].rest)
  my-len([list: 9]) is 1 +  my-len([list: 9].rest)
end

fun my-sum(s):
  cases (List) s:
    |empty => 0
    | link(f,r) => f + my-sum(r)
  end
where:
  my-sum([list: 4, 5, 6]) is 15
  my-sum([list: ]) is 0
end

#my-double, and the tempting mistake
[list: 3 * 2, [list: 10, 4]] #[list: 6, [list: 10, 4]]
link(3 * 2,  [list: 10, 4]) #[list: 6, 10, 4]

fun my-double(l):
  cases (List) l:
    | empty => empty
    | link(f, r) => link(f * 2, my-double(r))
  end
where:
  my-double([list: 3, 5, 2]) is [list: 6, 10, 4]
end

check:
  my-double([list: 3, 5, 2]) is link(6, link(10, link(4, empty)))
  my-double([list: 3, 5, 2]) is-not [list: 3 * 2, my-double([list: 5, 2])]
end
      
#[list: 3].rest

[list: "Real madrid", "Barca", "Manchester city"]

fun string-concat(k):
  cases (List) k:
    | empty => ""
    | link(f, r) => f + string-concat(r)
  end
where: 
  string-concat([list: "Real madrid", "Barca", "Manchester city"]) is "Real madridBarcaManchester city"
end

fun strings-upper(u):
  cases (List) u:
    | empty => empty
    | link(f, r) => link(string-to-upper(f), strings-upper(r))
  end
      where: 
  strings-upper([list: "Real madrid", "Hola"]) is [list: "REAL MADRID", "HOLA"]
end

[list: 3.4,  4.7, 6.8]

fun round-numbers(m):
  cases (List) m:
    | empty => empty
    | link(f, r) => link(num-round(f), round-numbers(r))
  end
where:
  round-numbers([list: 3.5,7.2]) is [list: 4, 7]
end

