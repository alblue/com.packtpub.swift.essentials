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

class RemoteGitRepository {
	let host:String
	let repo:String
	let port:Int
	init(host:String, repo:String, _ port:Int = 9418) {
		self.host = host
		self.repo = repo
		self.port = port
	}
	func lsRemote() -> [String:String] {
		var refs = [String:String]()
		if let (input,output) = NSStream.open(host,port) {
			output.writePacketLine("git-upload-pack \(repo)\0host=\(host)\0")
			while true {
				if let response = input.readPacketLineString() {
					let hash = String(response.substringToIndex(41))
					let ref = String(response.substringFromIndex(41))
					if ref.hasPrefix("HEAD") {
						continue
					} else {
						refs[ref] = hash
					}
				} else {
					break
				}
			}
			output.writePacketLine()
			input.close()
			output.close()
		}
		return refs
	}
	func lsRemoteAsync(fn:(String,String) -> ()) {
		if let (input,output) = NSStream.connect(host,port) {
			input.delegate = PacketLineParser(output) { (response:NSString) -> () in
				let hash = String(response.substringToIndex(41))
				let ref = String(response.substringFromIndex(41))
				if !ref.hasPrefix("HEAD") {
					fn(ref,hash)
				}
			}
			input.scheduleInRunLoop(NSRunLoop.mainRunLoop(), forMode: NSDefaultRunLoopMode)
			input.open()
			output.open()
			output.writePacketLine("git-upload-pack \(repo)\0host=\(host)\0")
		}
	}
}
