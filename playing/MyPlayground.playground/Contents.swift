//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

for i in 1...12 {
	let j = (i-7) * (i-6)
	let k = i
	print("I is \(i)")
}

let blue = UIColor.blueColor()
let size = CGRect(x:0,y:0,width:200,height:100)
let label = UILabel(frame:size)
label.text = str
label.textColor = blue;
label.font = UIFont.systemFontOfSize(24)
let alblue = UIImage(named:"alblue")

import XCPlayground

let page = XCPlaygroundPage.currentPage
page.captureValue(alblue, withIdentifier:"Al Blue")

dispatch_async(dispatch_get_main_queue()) {
	for n in 1...6 {
		if n % 2 == 0 {
			page.captureValue(n,withIdentifier:"even")
			page.captureValue(0,withIdentifier:"odd")
		} else {
			page.captureValue(n,withIdentifier:"odd")
			page.captureValue(0,withIdentifier:"even")
		}
	}
}
page.needsIndefiniteExecution = true
