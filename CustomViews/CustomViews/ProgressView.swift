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

class ProgessView: UIView {
	let circle = CAShapeLayer()
	let square = CAShapeLayer()
	let black = UIColor.blackColor().CGColor
	required init(coder: NSCoder) {
		super.init(coder:coder)
		setupUI()
	}
	override init(frame: CGRect) {
		super.init(frame:frame)
		setupUI()
	}
	func setupUI() {
		for layer in [square, circle] {
			layer.strokeColor = black
			layer.fillColor = nil
			self.layer.addSublayer(layer)
		}
		updateUI()
	}
	func updateUI() {
		let rect = self.bounds
		let sq = rect.rectByInsetting(dx: rect.width/3, dy: rect.height/3)
		square.fillColor = black
		square.path = UIBezierPath(rect: sq).CGPath
		circle.path = UIBezierPath(ovalInRect: rect).CGPath
	}
}
