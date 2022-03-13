import SwiftUI

struct PositionSelector: View {
	var positions = (0..<960).map({
		"\(String($0).padding(leftTo: 3, withPad: "0")) \(Constants.allPositions[$0].chessSymbolized)"
	})
	
	@Binding var showingSelector: Bool
	@Binding var positionNumber: Int

	var body: some View {
		
		NavigationView {
				
			VStack {
				Spacer()
				Picker(selection: self.$positionNumber, label: Text("Position")) {
					ForEach(0 ..< self.positions.count) {
						Text(self.positions[$0])
							.font(.custom("ChessAlpha2", size: 30))
					}
				}
				.pickerStyle(WheelPickerStyle())
				Spacer()
				Spacer()
				Spacer()
				Spacer()
			}
			.navigationBarTitle(Text("Select a position"))
			.navigationBarItems(trailing: Button(action: {self.showingSelector = false}) {
				Text("Done")
					.appFont(.bold, size: 18)
					.foregroundColor(Colors.brand)
			})
		}
	}
}

struct PositionSelector_Previews: PreviewProvider {
	static var previews: some View {
		PreviewWrapper()
	}

	struct PreviewWrapper: View {
		
		@State(initialValue: 518) var positionNumber: Int
		@State(initialValue: false) var showingSelector: Bool

		var body: some View {
			PositionSelector(showingSelector: $showingSelector, positionNumber: $positionNumber)
		}
	}
}

