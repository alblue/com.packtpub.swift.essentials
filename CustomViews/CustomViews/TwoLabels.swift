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

import UIKit

class TwoLabels:UIView {
	var left:UILabel = UILabel()
	var right:UILabel = UILabel()
	required init?(coder:NSCoder) {
		super.init(coder:coder)
		setupView()
	}
	override init(frame: CGRect) {
		super.init(frame:frame)
		setupView()
	}
	func setupView() {
		addSubview(left)
		addSubview(right)
		configureView()
		setNeedsUpdateConstraints()
	}
	func configureView() {
		left.text = "Left"
		right.text = "Right"
	}
	override func updateConstraints() {
		translatesAutoresizingMaskIntoConstraints = false
		left.translatesAutoresizingMaskIntoConstraints = false
		right.translatesAutoresizingMaskIntoConstraints = false
		removeConstraints(constraints)
		// left.width = right.width * 1 + 0
		let equalWidths = NSLayoutConstraint(item: left, attribute: .Width, relatedBy: .Equal, toItem: right, attribute: .Width, multiplier: 1, constant: 0)
		addConstraint(equalWidths)
		let options = NSLayoutFormatOptions()
		let namedViews = ["left":left,"right":right]
		addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[left]-[right]-|", options: options, metrics:nil, views: namedViews));
		addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-[left]-|", options: options, metrics:nil, views: namedViews));
		addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-[right]-|", options: options, metrics:nil, views: namedViews));
		super.updateConstraints()
	}
}
