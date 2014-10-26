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

class MasterViewController: UITableViewController {

	var detailViewController: DetailViewController? = nil
	var app:AppDelegate!

	override func awakeFromNib() {
		super.awakeFromNib()
		if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
		    self.clearsSelectionOnViewWillAppear = false
		    self.preferredContentSize = CGSize(width: 320.0, height: 600.0)
		}
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "insertNewObject:")
		self.navigationItem.rightBarButtonItem = addButton
		if let split = self.splitViewController {
		    let controllers = split.viewControllers
		    self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
		}
		app = UIApplication.sharedApplication().delegate
			as? AppDelegate
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	func insertNewObject(sender: AnyObject) {
		let alert = UIAlertController(
			title: "Add user",
			message: "Please select a user to add",
			preferredStyle: .Alert)
		alert.addAction(UIAlertAction(
			title: "Cancel", style: .Cancel, handler: nil))
		alert.addAction(UIAlertAction(
			title: "Add", style: .Default) {
				alertAction in
				let username = alert.textFields![0].text
				self.app.addUser(username!)
				Threads.runOnUIThread {
					self.tableView.reloadData()
				}
			})
		alert.addTextFieldWithConfigurationHandler {
			textField -> Void in
			textField.placeholder = "Username";
		}
		presentViewController(alert, animated: true, completion: nil)
	}

	// MARK: - Segues

	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		if segue.identifier == "showDetail" {
		    if let indexPath = self.tableView.indexPathForSelectedRow {
				// get the details controller
				let controller = (segue.destinationViewController as!
					UINavigationController).topViewController
					as! DetailViewController
				// set the details
				let user = app.users[indexPath.section]
				let repo = app.repos[user]![indexPath.row]
				controller.repo = repo["name"] ?? ""
				controller.user = user
				controller.data = repo
		        controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
		        controller.navigationItem.leftItemsSupplementBackButton = true
		    }
		}
	}

	// MARK: - Table View

	override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return app.users.count
	}

	override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		let cell = UITableViewHeaderFooterView()
		let user = app.users[section]
		cell.textLabel!.text = user
		app.api.withUserImage(user) {
			image in
			let minSize = min(cell.frame.height, cell.frame.width)
			let squareSize = CGSize(width:minSize, height:minSize)
			let imageFrame = CGRect(origin:cell.frame.origin, size:squareSize)
			Threads.runOnUIThread {
				let imageView = UIImageView(image:image)
				imageView.frame = imageFrame
				cell.addSubview(imageView)
				cell.setNeedsLayout()
				cell.setNeedsDisplay()
			}
		}
		return cell
	}

	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		let user = app.users[section]
		if let repos = app.repos[user] {
			return repos.count
		} else {
			app.loadRepoNamesFor(user) { _ in
				Threads.runOnUIThread {
					tableView.reloadSections(
						NSIndexSet(index: section),
						withRowAnimation: .Automatic)
				}
			}
			return 0
		}
	}

	override func tableView(tableView: UITableView,
		cellForRowAtIndexPath indexPath: NSIndexPath)
		-> UITableViewCell {
			let cell = tableView.dequeueReusableCellWithIdentifier(
				"Cell", forIndexPath: indexPath)
			let user = app.users[indexPath.section]
			let repo = app.repos[user]![indexPath.row]
			cell.textLabel!.text = repo["name"] ?? ""
			return cell
	}

	override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
		// Return false if you do not want the specified item to be editable.
		return false
	}

}

