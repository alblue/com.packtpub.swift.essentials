#!/usr/bin/env xcrun swift

for i in 1...12 {                       // for-in loop over a numeric range
  print("i is \(i)")                    // print out i
}

for _ in 1...12 {                       // underscore is a hole - ignored value
  print("Looping...")                   // underscore cannot be read
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
for item in shopping {                  // for-in loop iterates over collection
  if let c = costs[item] {              // if block uses let in case cost is nil
    cost += c                           // note this is not idiomatic; see below
  }                                     // for tuple iteration
}
cost == 10

Array(costs.keys)                       // creates a new array based on keys
Array(costs.values)                     // creates a new array based on values

for item in costs.keys {                // can iterate over keys in a dictionary
  print(item)
}

var (a,b) = (1,2)                       // tuple assignment; effectively a=1,b=2

for (item,cost) in costs {              // can iterate over key/values together
  print("The \(item) " +
   "costs \(cost)")
}

var sum = 0
for var i=0;i<=10;i++ {                 // can use traditional for loops as well
  sum += i                              // however may be removed in Swift 3
}
sum == 55

for var i=0,j=10; i<=10 && j >= 0; i++, j-- { // can use many loop variables
  print("\(i), \(j)");
}

// --- break, continue and labels ---

var deck = [1...13,1...13,1...13,1...13]
suits: for suit in deck {               // suit: introduces a label at this for block
  for card in suit {                    // nested for block
    if card == 3 {
      continue                          // goes to 'for card in suit' with next card
    }
    if card == 5 {
      continue suits                    // goes to the 'for suit in deck' with next suit
    }
    if card == 7 {
      break                             // leaves 'for card in suit' block
    }
    if card == 13 {
      break suits                       // leaves 'for suit in deck' block
    }
  }
}

