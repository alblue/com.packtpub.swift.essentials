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

class DetailViewController: UIViewController {

	@IBOutlet weak var userLabel: UILabel?
	@IBOutlet weak var repoLabel: UILabel?
	@IBOutlet weak var issuesLabel: UILabel?
	@IBOutlet weak var watchersLabel: UILabel?

	var user: String? {
		didSet {
			configureView()
		}
	}
	var repo: String? {
		didSet {
			configureView()
		}
	}
	var data:[String:String]? {
		didSet {
			configureView()
		}
	}
	override func viewDidLoad() {
		super.viewDidLoad()
		configureView()
	}
	func configureView() {
		if let label = userLabel { label.text = user }
		if let label = repoLabel { label.text = repo }
		if let label = issuesLabel {
			label.text = self.data?["open_issues_count"]
		}
		if let label = watchersLabel {
			label.text = self.data?["watchers_count"]
		}
	}
}

