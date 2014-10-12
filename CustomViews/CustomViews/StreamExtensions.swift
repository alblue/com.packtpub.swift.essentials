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

extension NSStream {
	class func open(host:String,_ port:Int) -> (NSInputStream, NSOutputStream)? {
		if let (input,output) = connect(host,port) {
			input.open()
			output.open()
			return (input,output)
		} else {
			return nil
		}
	}
	class func connect(host:String,_ port:Int) -> (NSInputStream, NSOutputStream)? {
		var input:NSInputStream?
		var output:NSOutputStream?
		NSStream.getStreamsToHostWithName(host, port: port, inputStream: &input, outputStream: &output)
		if input == nil || output == nil {
			return nil
		} else {
			return (input!,output!)
		}
	}
}

extension NSInputStream {
	func readBytes(size:Int) -> [UInt8]? {
		let buffer = Array<UInt8>(count:size,repeatedValue:0)
		var completed = 0
		while completed < size {
			let read = self.read(UnsafeMutablePointer(buffer) + completed, maxLength: size - completed)
			if read < 0 {
				return nil
			} else {
				completed += read
			}
		}
		return buffer
	}
	func readData(size:Int) -> NSData? {
		if let buffer = readBytes(size) {
			return NSData(bytes: UnsafeMutablePointer(buffer), length: buffer.count)
		} else {
			return nil
		}
	}
}

extension NSOutputStream {
	func writeData(data:NSData) -> Int {
		let size = data.length
		var completed = 0
		while completed < size {
			var wrote = write(UnsafePointer(data.bytes) +
				completed, maxLength:size - completed)
			if wrote < 0 {
				return wrote
			} else {
				completed += wrote
			}
		}
		return completed
	}
}

