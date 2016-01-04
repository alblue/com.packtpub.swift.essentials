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

import WatchKit
import Foundation

class RepositoryRowController: NSObject {
	@IBOutlet weak var name: WKInterfaceLabel!
}
class RepositoryListController: WKInterfaceController {
	let delegate = WKExtension.sharedExtension().delegate as! ExtensionDelegate
	@IBOutlet weak var repositoriesTable: WKInterfaceTable!
	var repos = []
	override func awakeWithContext(context: AnyObject?) {
		super.awakeWithContext(context)
		if let user = context as? String {
			delegate.loadReposFor(user) {
				result in
				self.repositoriesTable.setNumberOfRows(
					result.count, withRowType: "repository")
				self.repos = result
				for (index,repo) in result.enumerate() {
					let controller = self.repositoriesTable
						.rowControllerAtIndex(index) as! RepositoryRowController
					controller.name.setText(repo["name"] ?? "")
				}
			}
		} else {
			repos = []
		}
	}
	override func contextForSegueWithIdentifier(
		segueIdentifier: String,
		inTable table: WKInterfaceTable,
		rowIndex: Int) -> AnyObject? {
			return repos[rowIndex]
	}
}