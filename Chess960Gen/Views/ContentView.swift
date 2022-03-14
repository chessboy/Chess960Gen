//
//  ContentView.swift
//  Chess960Gen
//
//  Created by Robert Silverman on 4/4/20.
//  Copyright © 2020 Robert Silverman. All rights reserved.
//

import SwiftUI

struct ContentView: View {

	@State var positionIndex: Int = Constants.initialPositionIndex
	@State var rowPosition: String = Constants.allPositions[Constants.initialPositionIndex]
	@State var flipped: Bool = false
    @State var showingSelector: Bool = false
	@State var showingSafari: Bool = false

	var positionIndexFormatted: String {
		return "\(positionIndex)".padding(leftTo: 3, withPad: "0")
	}
		
	func generateNewPosition() {
		self.positionIndex = Int.random(in: 0..<960)
		animatePositionChange()
	}
	
	func animatePositionChange() {
		withAnimation(.easeInOut(duration: 0.75)) {
			self.rowPosition = Constants.allPositions[self.positionIndex]
		}
	}
	
	var body: some View {
		
		GeometryReader { geo in
			VStack(alignment: .center, spacing: 20) {
				
				Text("Chess 960 Generator")
					.appFont(.black, size: 25)
					.padding()
				
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

													
				HStack(alignment: .center) {
					Spacer()
					Spacer()

					// tappable position label
					Button(action: { self.showingSelector.toggle() }) {
						HStack(alignment: .center, spacing: 0) {
							Text("#")
								.appFont(.bold, size: 20)
								.foregroundColor(Colors.textDark)
								.frame(width: 16, height: 20)
								.offset(CGSize(width: 2, height: -5))
							Text(self.positionIndexFormatted)
								.appFont(.regular, size: 32)
								.foregroundColor(Colors.textDark)
								.frame(width: 60, height: 30)
						}
					}
					.buttonStyle(ScaleButtonStyle())
					.sheet(isPresented: self.$showingSelector, onDismiss: {
						self.animatePositionChange()
					}) {
						PositionSelector(showingSelector: self.$showingSelector, positionNumber: self.$positionIndex)
					}
					Spacer()
					// buttons
					ActionButton(systemIcon: Constants.SystemIcon.randomize.rawValue, action: { self.generateNewPosition()
					})
					Spacer()
					ActionButton(systemIcon: Constants.SystemIcon.flip.rawValue, action: { withAnimation(.easeInOut(duration: 0.5)) {
						self.flipped.toggle()
					}})
					Spacer()
					Spacer()
				}.padding(.top)
				.scaleEffect(1.25)
				
				Spacer()
				// wikipedia button
				Button(action: { self.showingSafari.toggle() }) {
					HStack(alignment: .center, spacing: 4) {
						Image("wiki-logo")
							.resizable()
							.scaledToFit()
							.frame(width: 30, height: 30)
							.opacity(0.66)

						Text("Chess960 Setup and Rules")
							.appFont(.semibold, size: 20)
							.foregroundColor(Colors.brand)
							//.frame(width: 75)
					}
					.padding(.bottom, 10)
				}
				.buttonStyle(ScaleButtonStyle())
				.sheet(isPresented: self.$showingSafari) {
					SafariView(url: URL(string: "https://en.wikipedia.org/wiki/Fischer_random_chess")!)
				}
				Spacer()
			}
		}
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
		
		ForEach(["iPhone 11 Pro Max", "iPhone 11 Pro", "iPhone 8 Plus", "iPhone 8"], id: \.self) { deviceName in
			ContentView()
				.previewDevice(PreviewDevice(rawValue: deviceName))
				.previewDisplayName(deviceName)
				.preferredColorScheme(.dark)
		}
    }
}
