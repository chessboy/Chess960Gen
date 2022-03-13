//
//  ActionButton.swift
//  Chess960Gen
//
//  Created by Robert Silverman on 4/7/20.
//  Copyright © 2020 Robert Silverman. All rights reserved.
//

import SwiftUI

struct ActionButton: View {
	var systemIcon: String
	var action: ()->()

    var body: some View {

	Button(action: {
		withAnimation(.easeInOut(duration: 0.5)) {
			self.action()
		}}) {
		Image(systemName: systemIcon)
			.font(Font.system(size: 18).bold())
			.foregroundColor(Colors.button)
			.frame(width: 44, height: 34)
			.overlay(RoundedRectangle(cornerRadius: 6).stroke(Color("brand").opacity(1), lineWidth: 1.5))
		}.buttonStyle(ScaleButtonStyle())
	}
}

struct ActionButton_Previews: PreviewProvider {
    static var previews: some View {
        ActionButton(systemIcon: "arrow.2.squarepath", action: {})
    }
}
