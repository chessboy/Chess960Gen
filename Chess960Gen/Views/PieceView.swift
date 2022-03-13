//
//  PieceView.swift
//  Chess960Gen
//
//  Created by Robert Silverman on 4/5/20.
//  Copyright © 2020 Robert Silverman. All rights reserved.
//

import SwiftUI

struct PieceView: View {
	
	@Binding var rowPosition: String
	@Binding var flipped: Bool

	var width: CGFloat
	var newPiecePositions: [PiecePosition] = []

	init(rowPosition: Binding<String>, flipped: Binding<Bool>, width: CGFloat) {
        self._rowPosition = rowPosition
		self._flipped = flipped
        self.width = width
		self.newPiecePositions = genPiecePositions
    }

	var genPiecePositions: [PiecePosition] {

		var piecePositions: [PiecePosition] = []
		let recoded = PiecePosition.recodedPosition(rowPosition)
				
		var newBlackRow = PiecePosition.blackRow
		var newWhiteRow = PiecePosition.whiteRow
		let one8th: CGFloat = width/8.0
		let one16th: CGFloat = width/16.0
		
		for i in 0..<8 {
			let piece = PiecePosition.pieceIds[i]
			let newPosition = PiecePosition.indexOfPieceId(piece, in: recoded)
			let x: CGFloat = CGFloat(newPosition) * one8th + one16th
			
			newBlackRow[i].point.x = flipped ? width - x : x
			newWhiteRow[i].point.x = flipped ? width - x : x
			newBlackRow[i].point.y = flipped ? width - one16th : one16th
			newWhiteRow[i].point.y = flipped ? one16th : width - one16th
		}

		piecePositions.append(contentsOf: newBlackRow)
		piecePositions.append(contentsOf: newWhiteRow)

		let blackPawnY = flipped ? width - one8th - one16th : one8th + one16th
		let whitePawnY = flipped ? one8th + one16th : width - one8th - one16th
		
		for i in 0..<8 {
			let blackPawn = PiecePosition(id: "BP\(i)", imageName: "bp", point: CGPoint(x: CGFloat(i) * one8th + one16th, y: blackPawnY))
			let whitePawn = PiecePosition(id: "WP\(i)", imageName: "wp", point: CGPoint(x: CGFloat(i) * one8th + one16th, y: whitePawnY))
			piecePositions.append(blackPawn)
			piecePositions.append(whitePawn)
		}
		
		return piecePositions
	}
	
	var body: some View {
		ZStack {
			
			BoardLabelsView(flipped: self.$flipped, width: self.width)
			
			ForEach(0..<self.newPiecePositions.count) { index in
				Image(self.newPiecePositions[index].imageName)
					.resizable()
					.frame(width: self.width/8.0, height: self.width/8.0)
					.position(self.newPiecePositions[index].point)
					.shadow(color: Color.black.opacity(0.3), radius: 1, x: 0, y: 1)
			}
		}
    }
}

struct PieceView_Previews: PreviewProvider {
	static var previews: some View {
		PreviewWrapper()
	}

	struct PreviewWrapper: View {
				
		@State(initialValue: 518) var positionNumber: Int
		@State(initialValue: "RNBQKBNR") var rowPosition: String
		@State(initialValue: false) var flipped: Bool

		var body: some View {
			GeometryReader { geo in
				VStack {
					
					ZStack {
						Rectangle()
							.foregroundColor(Colors.boardBorder)
							.frame(width: min(geo.size.width, geo.size.height))
							.frame(height: min(geo.size.width, geo.size.height))

						ZStack {
							Image("board")
								.resizable()
								.frame(width: min(geo.size.width, geo.size.height))
								.frame(height: min(geo.size.width, geo.size.height))

							PieceView(rowPosition: self.$rowPosition, flipped: self.$flipped, width: min(geo.size.width, geo.size.height))
								.frame(width: min(geo.size.width, geo.size.height))
								.frame(height: min(geo.size.width, geo.size.height))
						}
						.overlay(Rectangle().stroke(Color.black.opacity(0.2), lineWidth: 1))
						.scaleEffect(0.96)
					}
					
					Text("#\(self.positionNumber)")
						.appFont(size: 30)
						.frame(maxWidth: .infinity)
					
					Button(action: {
						withAnimation(.easeInOut(duration: 0.75), {
							self.positionNumber = Int.random(in: 0..<960)
							self.rowPosition = Constants.allPositions[self.positionNumber]
						})
					}) {
						Text("random")
							.appFont(size: 30)
							.padding()
					}
					
					Button(action: {
						withAnimation(.easeInOut(duration: 0.5), {
							self.flipped.toggle()
						})
					}) {
						Text("flip")
							.appFont(size: 30)
							.padding()
					}

					Spacer()
				}
			}
		}
	}
}
