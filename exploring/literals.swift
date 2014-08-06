#!/usr/bin/env xcrun swift

// Try out these expressions in the Swift interpreter 
//
// $ xcrun swift
// Welcome to Swift!  Type :help for assistance.
//   1> "Hello World"
// $R0: String = "Hello World"
//   2> 3+4
// $R1: Int = 7
//   3> $R0
// $R2: String = "Hello World"
//   4> $R1
// $R3: Int = 7

// Literal Values and Expressions

"Hello World"       // String
3+4                 // Int

3.141               // Double (64 bit)
299_792_458         // Int with underscores for readability
-1                  // Int is signed 32/64 bit (arch dependent)
1_800_123456        // Underscores have no effect on value

0b1010011           //  83 decimal: binary values begin 0b
0o123               //  83 decimal: octal values begin 0o
0123                // 123 decimal: leading zeros are still decimal
0x7b                // 123 decimal: hex values begin 0x

3.141               // 64-bit Double value
Float(3.141)        // 32-bit Float value
Float80(3.141)      // 80-bit Float value

299.792458e6        // 299792458 as a Double: e6 is *10^6
299.792_458_e6      // 299792458: underscores can be used

0x1p8               // 256  as a Double: p8 is *2^8
0x1p10              // 1024 as a Double: p10 is *2^10
0x4p10              // 4096 as a Double: p10 is *2^10

1e-1                // 0.1  as a Double: e-1 is *10^-1
1e-2                // 0.01 as a Double: e-2 is *10^-2
0x1p-1              // 0.5  as a Double: p0-1 is *2^-1
0x1p-2              // 0.5  as a Double: p0-2 is *2^-2
0xAp-1              // 5    as a Double: p0-1 is *2^-1

"\\"                // \ character
"\0"                // nul character
"\'"                // quote character
"\""                // double quote character
"\t"                // tab character
"\n"                // newline character
"\r"                // carriage return character
"\u{20AC}"          // unicode character (Euro) € 
"\u{1F600}"         // unicdoe character (Smiley) 😀

"3+4 is \(3+4)"     // interpolated string evaluates to 3+4 is 7
"7x2 is \(7*2)"     // interpolated string evaluates to 7x2 is 14

let pi = 3.141      // let introduces a constant pi
// pi = 3           // cannot re-assign constants
// <REPL>:2:4: error: cannot assign to 'let' value 'pi'
var i = 0           // type infers i is Int
++i                 // ++ exists for integral types to increment

let e:Float = 2.718 // specify type after colon to change default
let ff:UInt8 = 255  // Int8,Int16,Int32,Int64 and UInt* variants
let ooff=UInt16(ff) // Can convert to a different type with initializer

var shopping = [    // arrays start with [ and end with ]
  "Milk",           // comma separated elements
  "Eggs",           // type of array is type of elements[]         
  "Coffee",         // trailing comma is allowed and recommended
]

// trailing commas permit new entries to be added to the end of
// an array without incurring an SCM diff and so should be used
//
// compare the following: which looks better in an SCM diff?
//
//   var shopping = [
//     "Milk",
//     "Eggs",
//     "Coffee",
// +   "Tea",
//   ]
//
//   var shopping = [
//     "Milk",
//     "Eggs",
// -    "Coffee"
// +    "Coffee",
// +   "Tea"
//   ]

var costs = [       // Dictionaries store key/value pairs
  "Milk":1,         // Keys can be any (hashable) object
  "Eggs":2,         // colon separates key from value
  "Coffee":3,       // value can be any type
]

var m = shopping[0] // subscripts index arrays == "Milk"
var c = costs["Milk"]// subscripts index dictionaries == Optional(1)
shopping.count      // returns a count of elements 3
shopping += ["Tea"] // += is an array append operator
shopping.count      // returns a count of elements, now 4
// costs["Tea"] = ""// assignment is typechecked into dictionary
// <REPL>:8:1: error: '@lvalue $T5' is not identical to '(String, Int)'
costs["Tea"] = 4    // assignment into a dictionary (replace/add)
costs.count         // count works on dictionaries too

var o = Optional(1) // Optionals are maybe values opt:Int? == 1
o == nil            // false; an optional with a value is not nil
o! == 1             // unwrap a known optional to get value == 1
o = nil             // optionals can be nil if not present
// o!               // in whcih case unwrapping causes a crash
// fatal error: unexpectedly found nil while unwrapping an Optional value

var cost = 0                // can check for nil before use
if costs["Milk"] != nil {   // but this is not idiomatic swift
  cost += costs["Milk"]!    // not ! to unwrap optional
}
cost == 1

1           ?? 2            // returns 1 - ?? is the nil coalescing operator
nil         ?? 2            // returns 2
Optional(1) ?? 2            // returns 1

if let cm = costs["Milk"] { // introduces new constant 'cm' for body
  cost += cm                // value is non-nil and already unwrapped
}                           // cm is no longer in scope here

if let cb = costs["Bread"] {// can add else clauses as well
  cost += cb
} else {
  println( "No bread" )     // else clause run since costs["Bread"] is nil
}

var r = 17                  // % is the remainder so r % 2 is even iff 0 
r % 2 == 0 ? "Even" : "Odd" // ternary if operator is test ? true : false

var position = 21
switch position {           // switch can be any expression
  case 1: println("1st")    // case statements do not fall through
  case 2: println("2nd")    // each is independent
  case 3: println("3rd")
  case 4...20:              // ranges can be used as a match
     println("\(position)th") // prints if >= 4 and <= 20
  case position where (position % 10) == 1: // as can where clauses
     println("\(position)st")
  case let p where (p % 10) == 2: // also can use local constants
     println("\(p)nd")
  case let p where (p % 10) == 3:
     println("\(p)rd")
  default: println("\(position)th") // default for catch-all case
}
// prints 21st

4...10 ~= 4                 // 4 matches the pattern (range) 4...10
4...21 ~= 4                 // 21 does not match 4...10

1...10 ~= 10                // 10 is in 1...10
1..<10 ~= 10                // 10 is not in 1..<10
1..<10 == 1...9             // both are 1 to 9 inclusive

