// Copyright (c) 2014, Alex Blewitt, Bandlem Ltd
// Copyright (c) 2014, Packt Publishing Ltd
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import Foundation

extension NSData {
	var utf8string:String {
		return NSString(data:self,encoding:NSUTF8StringEncoding)
	}
}

extension String {
	var utf8data:NSData {
		return self.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)!
	}
	func fromHex() -> Int {
		var result = 0
		for c in self {
			result *= 16
			switch c {
			case "0": result += 0
			case "1": result += 1
			case "2": result += 2
			case "3": result += 3
			case "4": result += 4
			case "5": result += 5
			case "6": result += 6
			case "7": result += 7
			case "8": result += 8
			case "9": result += 9
			case "a", "A": result += 10
			case "b", "B": result += 11
			case "c", "C": result += 12
			case "d", "D": result += 13
			case "e", "E": result += 14
			case "f", "F": result += 15
			default: break
			}
		}
		return result;
	}
}

extension Int {
	func toHex(digits:Int) -> String {
		return NSString(format:"%0\(digits)x",self)
	}
}
