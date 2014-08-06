#!/usr/bin/env xcrun swift

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


// --- Functions ---

func costOf(                            // define function costOf
  items:[String],                       // first argument is array of String
  _ costs:[String:Int])                 // second is dictionary of String:Int
   -> Int {                             // which returns an Int
  var cost = 0                          // cost is local to this function
  for item in items {                   // loop as before
    if let ci = costs[item] {
      cost += ci
    }
  }
  return cost                           // return the cost from the function
}
costOf(shopping,costs) == 10            // call function

// --- Named arguments ---

func costOfNamed(                       // same function but with named args
  basket items:[String],                // basket is the external parameter name
  prices costs:[String:Int])            // prices is the external parameter name
   -> Int {
  var cost = 0                          // cost is local to this function
  for item in items {                   // loop as before
    if let ci = costs[item] {
      cost += ci
    }
  }
  return cost                           // return the cost from the function
}
costOfNamed(basket:shopping,prices:costs) // call with named arguments

// --- Default arguments ---

func costOfDefault(                     // same function but with default value
  items items:[String],                 // same as before
  costs:[String:Int] = costs)           // parameter defaults to 'costs'
   -> Int {
  var cost = 0                          // cost is local to this function
  for item in items {                   // loop as before
    if let ci = costs[item] {
      cost += ci
    }
  }
  return cost                           // return the cost from the function
}
costOfDefault(items:shopping)           // uses default costs
costOfDefault(items:shopping, costs:costs) // call with explicit costs value

// --- guards ---

func cardName(value:Int) -> String {
  guard value >= 1 && value <= 13 else {
    return "Unknown card"
  }
  let cardNames = [11:"Jack",12:"Queen",13:"King",1:"Ace",]
  return cardNames[value] ?? "\(value)"
}
cardName(11) == "Jack"
cardName(15) == "Unknown card"

func firstElement(list:[Int]) -> String {
  guard let first = list.first else {
    return "List is empty"
  }
  return "Value is \(first)"
}
firstElement([]) == "List is empty"
firstElement([1,2,3]) == "Value is 1"

// --- Variadic functions ---

func minmax(numbers:Int...)             // numbers... is variadic, acts as array
 -> (Int,Int) {                         // can return multiple values in a tuple
  var min = Int.max                     // Int.max is the largest Int
  var max = Int.min                     // Int.min is the smallest Int
  for number in numbers {               // loop through numbers
    if number < min {
      min = number                      // and remember smallest
    }
    if number > max {
      max = number                      // and largest
    }
  }
  return (min,max)                      // (min,max) is tuple which get returned
}

minmax(1,2,3,4) // == (1,4)             // can pass in arbitrary number of args
// minmax() == (Int.max,Int.min)        // but doesn't make sense with zero args

func minmaxOpt(numbers:Int...)          // same function but with
  -> (Int,Int)? {                       // an optional tuple return type
    var min = Int.max
    var max = Int.min
    if numbers.count == 0 {             // if no numbers are provided
        return nil                      // then return nil (no value)
    } else {
        for number in numbers {
            if number < min {
                min = number
            }
            if number > max {
                max = number
            }
        }
        return(min,max)                 // otherwise return a tuple with values
    }
}
minmaxOpt()                             // == nil
minmaxOpt(1)                            // == (1,1)
minmaxOpt(1,2,3,4)                      // == (1,4)

// --- Structures ---

struct MinMax {                         // can create structures
  var min:Int                           // min must be specified upon creation
  var max:Int                           // max must be specified upon creation
}

func minmaxStruct(numbers:Int...)       // function as before
 -> MinMax? {                           // except returning a struct
  var minmax = MinMax(min:Int.max, max:Int.min) // init struct
  if numbers.count == 0 {
    return nil                          // nil as before for optionality
  } else {
    for number in numbers {
      if number < minmax.min {
        minmax.min = number             // assign to struct member
      }
      if number > minmax.max {
        minmax.max = number             // assign to struct member
      }
    }
    return minmax                       // return struct as a whole
  }
}
minmaxStruct(1,2,3,4)

// --- Error handling ---

struct Oops : ErrorType {
  let message: String
}

// throw Oops(message: "Something went wrong") // will throw an error

func cardNameError(value:Int) throws -> String {
  guard value >= 1 && value <= 13 else {
    throw Oops(message:"Unknown card")
  }
  let cardNames = [11:"Jack",12:"Queen",13:"King",1:"Ace",]
  return cardNames[value] ?? "\(value)"
}
// cardNameError(1) == "Ace"
// cardNameError(15) // Unknown card

do {
  let name = try cardNameError(15)
  print("You chose \(name)")
} catch {
  print("You chose an invalid card")    // error is 'error' here
}

do {
  let name = try cardNameError(15)
  print("You chose \(name)")
} catch let e {                         // error is 'e' here
  print("There was a problem \(e)")     // can also use where clauses
}

let aceOptional = try? cardNameError(1) // == "Ace"
let unknown = try? cardNameError(15)    // == nil

let value = 13
if let card = try? cardNameError(value) {
  print("You chose: \(card)")
}

func deferExample() {
  defer {                               // executed at function return
    print("C")
  }
  print("A")
  defer {
    print("B")
  }
}
deferExample()                          // prints A, B, C

func deferEarly() {
  defer {
    print("C")
  }
  print("A")
  return
  defer {                               // generates an unreachable warning
    print("B")
  }
}
deferEarly()                            // prints A, C

