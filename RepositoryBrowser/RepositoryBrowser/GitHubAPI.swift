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
import UIKit

class GitHubAPI {
	let base:NSURL
	let services:[String:String]
	let cache = NSCache()
	class func connect() -> GitHubAPI? {
		return connect("https://api.github.com")
	}
	class func connect(url:String) -> GitHubAPI? {
		if let nsurl = NSURL(string:url) {
			return connect(nsurl)
		} else {
			return nil
		}
	}
	class func connect(url:NSURL) -> GitHubAPI? {
		if let data = NSData(contentsOfURL:url) {
			if let json = NSJSONSerialization.JSONObjectWithData(data,options:nil,error:nil) as? [String:String] {
			 return GitHubAPI(url,json)
			} else {
				return nil
			}
		} else {
			return nil
		}
	}
	init(_ base:NSURL, _ services:[String:String]) {
		self.base = base
		self.services = services
	}
	func getURLForUserRepos(user:String) -> NSURL {
		let key = "r:\(user)"
		if let url = cache.objectForKey(key) as? NSURL {
			return url
		} else {
			let userRepositoriesURL = services["user_repositories_url"]!
			let userRepositoryURL = URITemplate.replace(userRepositoriesURL, values:["user":user])
			let url = NSURL(string:userRepositoryURL, relativeToURL:base)!
			cache.setObject(url,forKey:key)
			return url
		}
	}
	func withUserRepos(user:String, fn:([[String:String]]) -> ()) {
		let key = "repos:\(user)"
		if let repos = cache.objectForKey(key) as? [[String:String]] {
			fn(repos)
		} else {
			let url = getURLForUserRepos(user)
			url.withJSONArrayOfDictionary {
				repos in
				self.cache.setObject(repos,forKey:key)
				fn(repos)
			}
		}
	}
	func getURLForUserInfo(user:String) -> NSURL {
		let key = "ui:\(user)"
		if let url = cache.objectForKey(key) as? NSURL {
			return url
		} else {
			let userURL = services["user_url"]!
			let userSpecificURL = URITemplate.replace(userURL, values:["user":user])
			let url = NSURL(string:userSpecificURL, relativeToURL:base)!
			cache.setObject(url,forKey:key)
			return url
		}
	}
	func withUserImage(user:String, fn:(UIImage -> ())) {
		let key = "image:\(user)"
		if let image = cache.objectForKey(key) as? UIImage {
			fn(image)
		} else {
			let url = getURLForUserInfo(user)
			url.withJSONDictionary {
				userInfo in
				if let avatar_url = userInfo["avatar_url"] {
					if let avatarURL = NSURL(string:avatar_url, relativeToURL:url) {
						if let data = NSData(contentsOfURL:avatarURL) {
							if let image = UIImage(data: data) {
								self.cache.setObject(image,forKey:key)
								fn(image)
							}
						}
					}
				}
			}
		}
	}
}
