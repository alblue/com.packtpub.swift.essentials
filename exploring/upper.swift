#!/usr/bin/env xcrun swift
import Foundation
let args = Process.arguments[1..<Process.arguments.count]
if Process.arguments.count == 1 {
  println("Run with some arguments")
} else { 
  for arg in args {
    println("Argument: \(arg.uppercaseString)")
  }
}
println()
println("To compile this run: xcrun swiftc -o upper \(Process.arguments[0])")
exit(0)

