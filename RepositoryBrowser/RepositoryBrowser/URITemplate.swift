// Copyright (c) 2016, Alex Blewitt, Bandlem Ltd
// Copyright (c) 2016, Packt Publishing Ltd
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

class URITemplate {
	class func replace(template:String, values:[String:String]) -> String {
		var replacement = template
		while true {
			if let parameterRange = replacement.rangeOfString("\\{[^}]*\\}", options: NSStringCompareOptions.RegularExpressionSearch) {
				var value:String
				let parameter = replacement.substringWithRange(parameterRange)
				if parameter.hasPrefix("{?") {
					value = ""
				} else {
					let start = parameterRange.startIndex.successor()
					let end = parameterRange.endIndex.predecessor()
					let name = replacement.substringWithRange(Range<String.Index>(start:start,end:end))
					value = values[name] ?? ""
				}
				replacement.replaceRange(parameterRange, with: value)
			} else {
				break
			}
		}
		return replacement
	}
}
