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

import XCTest

class CardsTest:XCTestCase {
	func testSuit() {
		let suit_clubs:Suit = Suit.Clubs
		let clubs:Suit = .Clubs
		XCTAssertEqual(suit_clubs,clubs,"Clubs are equal")
	}
	func testRank() {
		XCTAssertEqual(Rank.Two.rawValue,2,"Rank.Two.rawValue == 2")
		XCTAssertEqual(Rank(rawValue: 14)!,Rank.Ace,"Rank(rawValue:14)! ==  Rank.Ace")
	}
	func testCard() {
		let aceOfSpades:Card = .Face(.Ace,.Spades)
		let theJoker:Card = .Joker

		var jokerSeen = false;
		var aceOfSpadesSeen = false;

		for card in [aceOfSpades,theJoker] {
			switch(card) {
			case .Face(.Ace,.Spades): aceOfSpadesSeen = true
			case .Face(let rank, let suit): XCTFail("Saw a card \(rank) of \(suit)")
			case .Joker: jokerSeen = true
			}
		}
		XCTAssert(jokerSeen)
		XCTAssert(aceOfSpadesSeen)
	}
}
