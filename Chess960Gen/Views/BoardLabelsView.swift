//
//  BoardLabelsView.swift
//  Chess960Gen
//
//  Created by Robert Silverman on 4/9/20.
//  Copyright © 2020 Robert Silverman. All rights reserved.
//

import SwiftUI

struct BoardLabelsView: View {
	
	@Binding var flipped: Bool
	var width: CGFloat

	init(flipped: Binding<Bool>, width: CGFloat) {
		self._flipped = flipped
        self.width = width
    }

    var body: some View {

		ZStack {
			if flipped {
				ForEach(PiecePosition.files.reversed(), id: \.self) { file in
					Text(file)
						.appFont(size: 12)
						.foregroundColor(Colors.boardLabel)
						.position(CGPoint(x: self.width/8 - 4 + CGFloat(PiecePosition.files.reversed().firstIndex(of: file) ?? 0) * self.width/8, y: self.width - 9))
				}
				
				ForEach(PiecePosition.ranks.reversed(), id: \.self) { rank in
					Text(rank)
						.appFont(size: 10)
						.foregroundColor(Colors.boardLabel)
						.position(CGPoint(x: 5, y: 9 + CGFloat(PiecePosition.ranks.reversed().firstIndex(of: rank) ?? 0) * self.width/8))
				}
			} else {
				ForEach(PiecePosition.files, id: \.self) { file in
					Text(file)
						.appFont(size: 12)
						.foregroundColor(Colors.boardLabel)
						.position(CGPoint(x: self.width/8 - 4 + CGFloat(PiecePosition.files.firstIndex(of: file) ?? 0) * self.width/8, y: self.width - 9))
				}
				
				ForEach(PiecePosition.ranks, id: \.self) { rank in
					Text(rank)
						.appFont(size: 10)
						.foregroundColor(Colors.boardLabel)
						.position(CGPoint(x: 5, y: 9 + CGFloat(PiecePosition.ranks.firstIndex(of: rank) ?? 0) * self.width/8))
				}
			}
		}
	}
}

struct BoardLabelsView_Previews: PreviewProvider {
	static var previews: some View {
		BoardLabelsViewWrapper()
	}
	
	struct BoardLabelsViewWrapper: View {
		
		@State(initialValue: false) var flipped: Bool

		var body: some View {
			GeometryReader { geo in
				BoardLabelsView(flipped: .constant(false), width: geo.size.width)
			}
		}
	}
}
