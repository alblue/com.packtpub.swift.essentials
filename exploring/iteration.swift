#!/usr/bin/env xcrun swift

for i in 1...12 {           // for-in loop over a numeric range (1 to 12)
  println("i is \(i)")      // print out i
}

for _ in 1...12 {           // underscore is a hole - can be used to ignore
  println("Looping...")     // underscore cannot be read, only assigned to
}

// Set up data from previously
var shopping = [
  "Milk",
  "Eggs",
  "Coffee",
  "Tea",
]

var costs = [
  "Milk":1,
  "Eggs":2,
  "Coffee":3,
  "Tea":4,
]

var cost = 0
for item in shopping {      // for-in loop iterates over collection
  if let c = costs[item] {  // if block uses let in case cost not known
    cost += c               // note this is not idiomatic; see below
  }                         // for tuple iteration
}
cost == 10

Array(costs.keys)           // creates a new array based on keys (copies)
Array(costs.values)         // creates a new array based on values (copies)

for item in costs.keys {    // can iterate over keys in a dictionary
  println(item)
}

var (a,b) = (1,2)           // tuple assignment; effectively a=1, b=2

for (item,cost) in costs {  // can walk over key/values at the same time
  println("The \(item) " +  
   "costs \(cost)") 
}

var todo = shopping.generate() // returns a Generator which allows iteration
while let item = todo.next() { // what the for-in loop is equivalent to
  println("\(item)")
}

var one2ten = (1...10).generate() // can be used for ranges as well
while let number = one2ten.next() {
  println("\(number)")
}

var sum = 0
for var i=0;i<=10;i++ {     // can use traditional for loops as well
  sum += i
}
sum == 55

for var i=0,j=10; i<=10 && j >= 0; i++, j-- { // can use many loop variables
  println("\(i), \(j)");
}

// --- break, continue and labels ---

var deck = [1...13,1...13,1...13,1...13]
suits: for suit in deck {   // suit: introduces a label at this for block
  for card in suit {        // nested for block
    if card == 3 {
      continue              // goes to 'for card in suit' with next card
    }
    if card == 5 {
      continue suits        // goes to the 'for suit in deck' with next suit
    }
    if card == 7 {
      break                 // leaves 'for card in suit' block
    }
    if card == 13 {
      break suits           // leaves 'for suit in deck' block
    }
  }
}

