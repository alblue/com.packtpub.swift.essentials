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

class PacketLineParser: NSObject, NSStreamDelegate {
	let output:NSOutputStream
	let callback:(NSString)->()
	var capture:PacketLineParser?
	init(_ output:NSOutputStream, _ callback:(NSString) -> ()) {
		self.output = output
		self.callback = callback
		super.init()
		// Since this is stored in an NSInputStream delegate which
		// only weakly owns this object, if no other approach is
		// taken this object will be thrown away before it receives
		// any messages. To avoid this, we create a cyclic reference
		// to itself to prevent it being closed, and then handle
		// the cleanup when the stream is ended.
		capture = self
	}
	func stream(stream: NSStream, handleEvent: NSStreamEvent) {
		let input = stream as! NSInputStream
		if handleEvent == NSStreamEvent.HasBytesAvailable {
			if let line = input.readPacketLineString() {
				callback(line)
			} else {
				output.writePacketLine()
				input.close()
				output.close()
				capture = nil
			}
		}
	}
}
