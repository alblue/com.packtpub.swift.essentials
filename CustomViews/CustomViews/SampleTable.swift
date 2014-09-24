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

class SampleTable: UITableViewController {
	var items = [
		("First", "A first item"),
		("Second", "A second item"),
	]
	required init?(coder: NSCoder) {
		super.init(coder:coder)
	}
	override func viewDidLoad() {
		let xib = UINib(nibName:"CounterView",bundle:nil)
		let objects = xib.instantiateWithOwner(self, options:nil)
		let counter = objects.first as? UIView
		tableView.tableHeaderView = counter
		let footer = UITableViewHeaderFooterView()
		footer.contentView.addSubview(TwoLabels(frame:CGRect.zero))
		tableView.tableFooterView = footer
	}
	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return items.count
	}
	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let (title,subtitle) = items[indexPath.row]
		let cell = tableView.dequeueReusableCellWithIdentifier("prototypeCell")!
		let titleLabel = cell.viewWithTag(1) as! UILabel
		let subtitleLabel = cell.viewWithTag(2) as! UILabel
		titleLabel.text = title
		subtitleLabel.text = subtitle
		return cell
	}
}
