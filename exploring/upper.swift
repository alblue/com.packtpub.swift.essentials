#!/usr/bin/env xcrun swift

import func Darwin.exit

let args = Process.arguments[1..<Process.arguments.count]
if Process.arguments.count == 1 {
  print("Run with some arguments")
  print("To compile this run: xcrun swiftc -o upper \(Process.arguments[0])")
} else {
  for arg in args {
    print("\(arg.uppercaseString)")
  }
}
exit(0)

