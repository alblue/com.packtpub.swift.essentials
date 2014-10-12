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

extension NSOutputStream {
	func writePacketLine(_ message:String = "") -> Int {
		let data = message.utf8data
		let length = data.length
		if length == 0 {
			return writeData("0000".utf8data)
		} else {
			let prefix = (length + 4).toHex(4).utf8data
			return self.writeData(prefix) + self.writeData(data)
		}
	}
}

extension NSInputStream {
	func readPacketLine() -> NSData? {
		if let data = readData(4) {
			let length = data.utf8string.fromHex()
			if length == 0 {
				return nil
			} else {
				return readData(length - 4)
			}
		} else {
			return nil
		}
	}
	func readPacketLineString() -> NSString? {
		if let data = self.readPacketLine() {
			return data.utf8string
		} else {
			return nil
		}
	}
}
