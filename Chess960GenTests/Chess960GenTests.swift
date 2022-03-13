//
//  Chess960GenTests.swift
//  Chess960GenTests
//
//  Created by Robert Silverman on 4/4/20.
//  Copyright © 2020 Robert Silverman. All rights reserved.
//

import XCTest
@testable import Chess960Gen

class Chess960GenTests: XCTestCase {
	
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
		
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPositionData() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
		XCTAssert(Constants.allPositions.count == 960)
		XCTAssert(Constants.allPositions.first == "BBQNNRKR")
		XCTAssert(Constants.allPositions.last == "RKRNNQBB")
		XCTAssert(Constants.allPositions[518] == "RNBQKBNR")
		
		
		for i in 0..<960 {
			XCTAssert(Constants.allPositions[i].count == 8)
		}
    }
	
	func testPadding() throws {
		XCTAssert("4".padding(leftTo: 3, withPad: "0") == "004")
		XCTAssert("4".padding(rightTo: 3, withPad: "0") == "400")
		XCTAssert("4".padding(sidesTo: 3, withPad: "0") == "040")
	}

	func testRecoding() throws {
		for i in 518..<519 {
			
			let encoded = PiecePosition.recodedPosition(Constants.allPositions[i])
			print()
			print(encoded)
					
			for piece in PiecePosition.pieceIds {
				let position = PiecePosition.indexOfPieceId(piece, in: encoded)
				print("\(piece) found in position \(position)")
			}
			
			print()
		}
	}
	
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
