//
//  FontFactory.swift
//  CoronaHelp
//
//  Created by Robert Silverman on 3/31/20.
//  Copyright © 2020 Robert Silverman. All rights reserved.
//

import Foundation
import SwiftUI

// Factory benefits:
// 1. Consistently use the same font family throughout the app
// 2. Single place to swap families
// 3. Caching for less memory use
//
// usage:
//	 let font = FontFactory.font(.semibold, size: 18)
//
// or:
//	 SomeView()
//		 .appFont(.semibold, size: 18)
//
class FontFactory {
	
	enum FontStyle: String, CustomStringConvertible {
		case black, bold, semibold, regular, light
		
		var description: String {
			return rawValue.capitalized
		}
	}

	static let fontFamiliy = "Lato"
	private static var cache = [String: Font]()
		
	static func font(_ style: FontStyle, size: CGFloat) -> Font {
		let key = makeKey(style, size: size)

		if let font = cache[key] {
			//print("found: \(key) in cache")
			return font
		}
		
		let font = Font.custom("\(fontFamiliy)-\(style)", size: size)
		cache[key] = font
		return font
	}
	
	private static func makeKey(_ style: FontStyle, size: CGFloat) -> String {
		return "\(style)-\(size)"
	}
}

extension View {
	func appFont(_ style: FontFactory.FontStyle = .regular, size: CGFloat) -> some View {
		self.font(FontFactory.font(style, size: size))
	}
}
