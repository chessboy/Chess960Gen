//
//  ChessPosition.swift
//  Chess960Gen
//
//  Created by Robert Silverman on 4/5/20.
//  Copyright © 2020 Robert Silverman. All rights reserved.
//

import Foundation
import SwiftUI

extension String {
	var chessSymbolized: String {
		return self
			.replacingOccurrences(of: "R", with: "ä")
			.replacingOccurrences(of: "N", with: "â")
			.replacingOccurrences(of: "B", with: "à")
			.replacingOccurrences(of: "Q", with: "æ")
			.replacingOccurrences(of: "K", with: "è")
			.replacingOccurrences(of: "P", with: "ê")
		//.uppercased()
	}
}

struct PiecePosition: Identifiable {
	var id: String
	var imageName: String
	var point: CGPoint = .zero
	
	static var files = ["a", "b", "c", "d", "e", "f", "g", "h"]
	static var ranks = ["8", "7", "6", "5", "4", "3", "2", "1"]
	static let pieceIds = ["R1", "R2", "N1", "N2", "B1", "B2", "Q1", "K1"]
	
	static func indexOfPieceId(_ pieceId: String, in recodedPosition: String) -> Int {
		return (recodedPosition.indexDistance(of: pieceId) ?? 0) / 2
	}
	
	static let blackRow: [PiecePosition] = [
		PiecePosition(id: "R1", imageName: "br"),
		PiecePosition(id: "R2", imageName: "br"),
		PiecePosition(id: "N1", imageName: "bn"),
		PiecePosition(id: "N2", imageName: "bn"),
		PiecePosition(id: "B1", imageName: "bb"),
		PiecePosition(id: "B2", imageName: "bb"),
		PiecePosition(id: "Q1", imageName: "bq"),
		PiecePosition(id: "K1", imageName: "bk"),
	]
	
	static let whiteRow: [PiecePosition] = [
		PiecePosition(id: "R1", imageName: "wr"),
		PiecePosition(id: "R2", imageName: "wr"),
		PiecePosition(id: "N1", imageName: "wn"),
		PiecePosition(id: "N2", imageName: "wn"),
		PiecePosition(id: "B1", imageName: "wb"),
		PiecePosition(id: "B2", imageName: "wb"),
		PiecePosition(id: "Q1", imageName: "wq"),
		PiecePosition(id: "K1", imageName: "wk"),
	]
	
	// recode a position with indexes of occurences of the same piece from left to right, eg: BBQNNRKR -> B1B2Q1N1N2R1K1R2
	static func recodedPosition(_ position: String) -> String {
		
		var recoded = ""
		
		var rook = 1
		var knight = 1
		var bishop = 1
		
		for c in position {
			switch c {
			case "R":
				recoded += "R\(rook)"
				rook += 1
			case "N":
				recoded += "N\(knight)"
				knight += 1
			case "B":
				recoded += "B\(bishop)"
				bishop += 1
			default:
				recoded += "\(c)1"
			}
		}
		
		return recoded
	}
}
