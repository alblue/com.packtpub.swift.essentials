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

import UIKit

class MessageViewController: UIViewController {
	
	let messages = [
		"Ouch, that hurts",
		"Please don't do that again",
		"Why did you press that?",
	]
	@IBAction func changeMessage() {
		message.text = messages[Int(arc4random_uniform(UInt32(messages.count)))]
	}
	@IBOutlet weak var message: UILabel!
	override func viewDidLoad() {
		let red = CGFloat(drand48())
		let green = CGFloat(drand48())
		let blue = CGFloat(drand48())
		message.backgroundColor = UIColor(
			red:red,
			green:green,
			blue:blue,
			alpha:0.5
		)
	}
}
