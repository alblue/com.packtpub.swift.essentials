// Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

for i in 1...12 {
	var j = (i-7)*(i-6)
	var k = i
	println("I is \(i)")
}

let blue = UIColor.blueColor()
let size = CGRect(x:0,y:0,width:200,height:100)
let label = UILabel(frame:size)
label.text = str
label.textColor = blue;
label.font = UIFont.systemFontOfSize(24)

let logo = UIImage(named:"logo")

import XCPlayground

XCPCaptureValue("logo",logo)

for n in 1...6 {
  if n % 2 == 0 {
	XCPCaptureValue("even",n)
	XCPCaptureValue("odd",0)
  } else {
	XCPCaptureValue("odd",n)
	XCPCaptureValue("even",0)
  }
}
