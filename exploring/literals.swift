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

"Hello World"                           // String
3+4                                     // Int

3.141                                   // Double (64 bit)
299_792_458                             // Int with underscores for readability
-1                                      // Int is signed 32 or 64 bit
1_800_123456                            // Underscores have no effect on value

0b1010011                               //  83 decimal: binary values begin 0b
0o123                                   //  83 decimal: octal values begin 0o
0123                                    // 123 decimal: leading zeros decimal
0x7b                                    // 123 decimal: hex values begin 0x

3.141                                   // 64-bit Double value
Float(3.141)                            // 32-bit Float value
Float80(3.141)                          // 80-bit Float value

299.792458e6                            // 299792458 as a Double: e6 is *10^6
299.792_458_e6                          // 299792458: underscores can be used

0x1p8                                   // 256  as a Double: p8 is *2^8
0x1p10                                  // 1024 as a Double: p10 is *2^10
0x4p10                                  // 4096 as a Double: p10 is *2^10

1e-1                                    // 0.1  as a Double: e-1 is *10^-1
1e-2                                    // 0.01 as a Double: e-2 is *10^-2
0x1p-1                                  // 0.5  as a Double: p0-1 is *2^-1
0x1p-2                                  // 0.5  as a Double: p0-2 is *2^-2
0xAp-1                                  // 5    as a Double: p0-1 is *2^-1

"\\"                                    // \ character
"\0"                                    // nul character
"\'"                                    // single quote character
"\""                                    // double quote character
"\t"                                    // tab character
"\n"                                    // newline character
"\r"                                    // carriage return character
"\u{20AC}"                              // unicode character (Euro) €
"\u{1F600}"                             // unicdoe character (Smiley) 😀

"3+4 is \(3+4)"                         // interpolated string is "3+4 is 7"
"7x2 is \(7*2)"                         // interpolated string is "7x2 is 14"

let pi = 3.141                          // let introduces a constant pi
// pi = 3                               // cannot re-assign constants
// error: cannot assign to 'let' value 'pi'
var i = 0                               // type infers i is Int
++i                                     // ++ increment for integral types
                                        // ++ and -- may be removed in Swift 3

let e:Float = 2.718                     // specify type to change default
let ff:UInt8 = 255                      // Int8,Int16,Int32,Int64 and UInt*
let ooff = UInt16(ff)                   // Can convert to a different type
// Int8(255)                            // 255 cannot be represented in Int8
// error: integer overflows when converted from 'Int' to 'Int8'
// UInt8(Int8(-1))                      // negative cannot be in unsigned
// error: negative integer cannot be converted to unsigned type 'UInt8'

var shopping = [                        // arrays start with [ and end with ]
  "Milk",                               // comma separated elements
  "Eggs",                               // type of array is type of elements[]
  "Coffee",                             // trailing comma is recommended
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

var costs = [                           // Dictionaries store key/value pairs
  "Milk":1,                             // Keys can be any (hashable) object
  "Eggs":2,                             // colon separates key from value
  "Coffee":3,                           // value can be any type
]

var m = shopping[0]                     // subscripts arrays == "Milk"
var c = costs["Milk"]                   // subscripts dictionaries == 1?
shopping.count                          // returns a count of elements 3
shopping += ["Tea"]                     // += is an array append operator
shopping.count                          // returns a count of elements, now 4
// costs["Tea"] = ""                    // assignment is typechecked in dict
// error: cannot assign value of type 'String' to type 'Int?'
costs["Tea"] = 4                        // assignment into a dictionary
costs.count                             // count works on dictionaries too

var shoppingSet: Set = [                // Sets are unordered
  "Milk",
  "Eggs",
  "Coffee",
]
// var shoppingSet = Set( [ "Milk", "Eggs", "Coffee", ] ) // same as above
shoppingSet.contains("Milk")            // contains used to test membership
shoppingSet.contains("Tea")             // == false
shoppingSet.remove("Coffee")            // remove items, returns "Coffee"?
shoppingSet.remove("Tea")               // returns nil if item is not present
shoppingSet.insert("Tea")               // insert can be used to add items
shoppingSet.contains("Tea")             // == true

var cannotBeNil: Int = 1                // non-optional cannot be assigned nil
// cannotBeNil = nil
// error: cannot assign a value of type 'nil' to a value of type 'Int'
var canBeNil: Int? = 1                  // returns Optional(1)
canBeNil = nil                          // nil can be assigned to optional

var opt = Optional(1)                   // may have values opt:Int? == 1
opt == nil                              // false; optional with value is not nil
opt! == 1                               // unwrap a known optional to get value
opt = nil                               // optionals can be nil if not present
// opt!                                 // in nil case unwrapping causes a crash
// fatal error: unexpectedly found nil while unwrapping an Optional value

var implicitlyUnwrappedOptional:Int! = 1// unwrapped on demand
implicitlyUnwrappedOptional + 2         // == 3
implicitlyUnwrappedOptional = nil       // assign nil
// implicitlyUnwrappedOptional + 2      // causes error
// fatal error: unexpectedly found nil while unwrapping an Optional value

1           ?? 2                        // == 1
nil         ?? 2                        // == 2
Optional(1) ?? 2                        // == 1

costs["Tea"] ?? 0                       // == 4
costs["Sugar"] ?? 0                     // == 0

var cost = 0
if let cc = costs["Coffee"] {           // introduces new constant 'cc' for body
  cost += cc                            // cc is non-nil and already unwrapped
}                                       // cc is no longer in scope here

if let cm = costs["Milk"], let ct = costs["Tea"] {
  cost += cm + ct                       // both cm and ct are unwrapped
}                                       // only if both are not nil

if let cb = costs["Bread"] {            // can add else clauses as well
  cost += cb
} else {
  print( "No bread" )                   // else clause run if costs["Bread"] nil
}

// var i from above
i = 17                                  // % is the remainder operator
i % 2 == 0 ? "Even" : "Odd"             // ternary if operator is test ? t : f

var position = 21
switch position {                       // switch can be any expression
  case 1: print("1st")                  // case statements do not fall through
  case 2: print("2nd")                  // each is independent
  case 3: print("3rd")
  case 4...20:                          // ranges can be used as a match
     print("\(position)th")             // prints if >= 4 and <= 20
  case position where (position % 10) == 1: // as can where clauses
     print("\(position)st")
  case let p where (p % 10) == 2:       // also can use local constants
     print("\(p)nd")
  case let p where (p % 10) == 3:
     print("\(p)rd")
  default: print("\(position)th")       // default for catch-all case
}
// prints 21st

4...10 ~= 4                             // 4 matches the pattern (range) 4...10
4...21 ~= 4                             // 21 does not match 4...10

1...10 ~= 10                            // 10 is in 1...10
1..<10 ~= 10                            // 10 is not in 1..<10
1..<10 == 1...9                         // both are 1 to 9 inclusive

