//
//  Extensions.swift
//  Chess960Gen
//
//  Created by Robert Silverman on 4/4/20.
//  Copyright © 2020 Robert Silverman. All rights reserved.
//

import SwiftUI

extension String {
	//https://stackoverflow.com/questions/42192289/is-there-a-built-in-swift-function-to-pad-strings-at-the-beginning
	func padding(leftTo paddedLength:Int, withPad pad:String=" ", startingAt padStart:Int=0) -> String {
		let rightPadded = self.padding(toLength:max(count,paddedLength), withPad:pad, startingAt:padStart)
		return "".padding(toLength:paddedLength, withPad:rightPadded, startingAt:count % paddedLength)
	}

	func padding(rightTo paddedLength:Int, withPad pad:String=" ", startingAt padStart:Int=0) -> String {
		return self.padding(toLength:paddedLength, withPad:pad, startingAt:padStart)
	}

	func padding(sidesTo paddedLength:Int, withPad pad:String=" ", startingAt padStart:Int=0) -> String {
		let rightPadded = self.padding(toLength:max(count,paddedLength), withPad:pad, startingAt:padStart)
		return "".padding(toLength:paddedLength, withPad:rightPadded, startingAt:(paddedLength+count)/2 % paddedLength)
	}
}

struct ScaleButtonStyle: ButtonStyle {
	var scale: CGFloat = 1.15
	func makeBody(configuration: Self.Configuration) -> some View {
		configuration.label
			.scaleEffect(configuration.isPressed ? scale : 1.0)
	}
}


extension String {
    subscript (bounds: CountableClosedRange<Int>) -> String {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return String(self[start...end])
    }

    subscript (bounds: CountableRange<Int>) -> String {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return String(self[start..<end])
    }
}

extension StringProtocol {
    func indexDistance(of element: Element) -> Int? { firstIndex(of: element)?.distance(in: self) }
    func indexDistance<S: StringProtocol>(of string: S) -> Int? { range(of: string)?.lowerBound.distance(in: self) }
}
extension Collection {
    func distance(to index: Index) -> Int { distance(from: startIndex, to: index) }
}
extension String.Index {
    func distance<S: StringProtocol>(in string: S) -> Int { string.distance(to: self) }
}


extension StringProtocol {
    func index<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> Index? {
        range(of: string, options: options)?.lowerBound
    }
    func endIndex<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> Index? {
        range(of: string, options: options)?.upperBound
    }
    func indices<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> [Index] {
        var indices: [Index] = []
        var startIndex = self.startIndex
        while startIndex < endIndex,
            let range = self[startIndex...]
                .range(of: string, options: options) {
                indices.append(range.lowerBound)
                startIndex = range.lowerBound < range.upperBound ? range.upperBound :
                    index(range.lowerBound, offsetBy: 1, limitedBy: endIndex) ?? endIndex
        }
        return indices
    }
    func ranges<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> [Range<Index>] {
        var result: [Range<Index>] = []
        var startIndex = self.startIndex
        while startIndex < endIndex,
            let range = self[startIndex...]
                .range(of: string, options: options) {
                result.append(range)
                startIndex = range.lowerBound < range.upperBound ? range.upperBound :
                    index(range.lowerBound, offsetBy: 1, limitedBy: endIndex) ?? endIndex
        }
        return result
    }
}
