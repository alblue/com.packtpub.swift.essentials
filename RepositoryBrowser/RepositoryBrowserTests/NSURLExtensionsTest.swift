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

import XCTest

class NSURLExtensionsTest: XCTestCase {
	
	func testNSURLJSON() {
		let json = "{\"test\":\"value\"}".dataUsingEncoding(NSUTF8StringEncoding)!
		let base64 = json.base64EncodedDataWithOptions(nil)
		let data = NSString(data: base64, encoding: NSUTF8StringEncoding)!
		let dataURL = NSURL(string:"data:text/plain;base64,\(data)")!
		dataURL.withJSONDictionary {
			dict in
			XCTAssertEqual(dict["test"] ?? "", "value", "Value is as expected")
		}
	}
	func testNSURLJSONArray() {
		let json = "[{\"test\":\"value\"}]".dataUsingEncoding(NSUTF8StringEncoding)!
		let base64 = json.base64EncodedDataWithOptions(nil)
		let data = NSString(data: base64, encoding: NSUTF8StringEncoding)!
		let dataURL = NSURL(string:"data:text/plain;base64,\(data)")!
		dataURL.withJSONArrayOfDictionary {
			dict in
			XCTAssertEqual(dict[0]["test"] ?? "", "value", "Value is as expected")
		}
	}
}
