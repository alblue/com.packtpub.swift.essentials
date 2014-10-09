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

class FeedParser: NSObject, NSXMLParserDelegate {
	var inEntry:Bool = false
	var inTitle:Bool = false
	var title:String?
	var link:String?
	var items:[(String,String)] = []
	init(_ data:NSData) {
		let parser = NSXMLParser(data: data);
		parser.shouldProcessNamespaces = true
		super.init()
		parser.delegate = self
		// If you get an EXC_BAD_ACCESS on the parse()
		// line, check your delegate methods are declared
		// to allow implicitly unwrapped optionals since
		// sometimes these values may be nil
		parser.parse()
	}
	// Xcode 6.0.1 fails to call this unless the
	// namespaceURI, qualifiedName and attributes
	// are implicitly unwrapped optionals.
	// The casting for dictionary appears to be
	// unhelpful, so using NSDictionary directly
	// allows the values to be extracted.
	func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String!, qualifiedName: String!, attributes: NSDictionary!) {
		switch elementName {
		case "entry":
			inEntry = true
		case "title":
			inTitle = true
		case "link":
			link = attributes.objectForKey("href") as String?
		default: break
		}
	}
	// Similar to the above, namespaceURI and
	// qualifiedName may be nil, so must be declared
	// as implicitly unwrapped optionals.
	func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String!, qualifiedName: String!) {
		switch elementName {
		case "entry":
			inEntry = false
			if title != nil && link != nil {
				items += [(title!,link!)]
			}
			title = nil
			link = nil
		case "title": inTitle = false
		default: break
		}
	}
	func parser(parser: NSXMLParser, foundCharacters string: String) {
		if inEntry && inTitle {
			title = string
		}
	}
}
