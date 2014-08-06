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

func costOf(                // define function costOf
  items:[String],           // first argument is array of String
  costs:[String:Int])       // second argument is dictionary of String and Int
   -> Int {                 // which returns an Int
  var cost = 0              // cost is local to this function
  for item in items {       // loop as before
    if let cm = costs[item] {
      cost += cm
    }
  }
  return cost               // return the cost from the function
}
costOf(shopping,costs) == 10 // call function

// --- Named arguments ---

func costOfNamed(           // same function but with named arguments
  basket items:[String],    // basket is the external parameter name
  prices costs:[String:Int])// prices is the external parameter name
   -> Int {
  var cost = 0              // cost is local to this function
  for item in items {       // loop as before
    if let cm = costs[item] {
      cost += cm
    }
  }
  return cost               // return the cost from the function
}
costOfNamed(basket:shopping,prices:costs) // call with named arguments

// --- Shorthand named arguments ---

func costOfShorthandNamed(  // same function but with shorthand named arguments
  #items:[String],          // items is the external parameter name
  #costs:[String:Int])      // costs is the external parameter name
   -> Int {
  var cost = 0              // cost is local to this function
  for item in items {       // loop as before
    if let cm = costs[item] {
      cost += cm
    }
  }
  return cost               // return the cost from the function
}
costOfShorthandNamed(items:shopping,costs:costs) // call with named arguments

// --- Default arguments ---

func costOfDefault(         // same function but with default value
  #items:[String],          // same as before
   costs:[String:Int] = costs) // parameter defaults to the 'costs' value
   -> Int {
  var cost = 0              // cost is local to this function
  for item in items {       // loop as before
    if let cm = costs[item] {
      cost += cm
    }
  }
  return cost               // return the cost from the function
}
costOfDefault(items:shopping) // call with named arguments, uses default costs

// --- Variadic functions ---

func minmax(numbers:Int...) // numbers... is variadic, acts as an array in func
 -> (Int,Int) {             // can return multiple values in a tuple
  var min = Int.max         // Int.max is the largest Int
  var max = Int.min         // Int.min is the smallest Int
  for number in numbers {   // loop through numbers
    if number < min {
      min = number          // and remember smallest
    } else if number > max {
      max = number          // and largest
    }
  }
  return(min,max)           // (min,max) is tuple which get returned
}

minmax(1,2,3,4) // == (1,4) // can pass in arbitrary number of args
// minmax() == (Int.max,Int.min) // but doesn't make sense with zero args

func minmaxOpt(numbers:Int...) // same function
  -> (Int,Int)? {           // but with an optional tuple return type
    var min = Int.max
    var max = Int.min
    if(numbers.count == 0) {// if we don't get any numbers
        return nil          // then return nil (no value)
    } else {
        for number in numbers {
            if number < min {
                min = number
            } else if number > max {
                max = number
            }
        }
        return(min,max)     // otherwise we return a tuple with values
    }
}
minmaxOpt()                 // == nil
minmaxOpt(1)                // == (1,1)
minmaxOpt(1,2,3,4)          // == (1,4)

// --- Structures ---

struct MinMax {             // can create structures
  var min:Int               // min must be specified upon creation
  var max:Int               // max must be specified upon creation
}

func minmaxStruct(numbers:Int...) // function as before
 -> MinMax? {               // except returning a struct
  var minmax = MinMax(min:Int.max, max:Int.min) // init struct
  if(numbers.count == 0) {
    return nil              // nil as before for optionality
  } else {
    for number in numbers {
      if number < minmax.min {
        minmax.min = number // assign to struct member
      } else if number > minmax.max {
        minmax.max = number // assign to struct member
      }
    }
    return minmax           // return struct as a whole
  }
}
minmaxStruct(1,2,3,4)
