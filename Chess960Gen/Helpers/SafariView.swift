// https://david.y4ng.fr/swiftui-and-sfsafariviewcontroller/

import SwiftUI
import SafariServices

struct SafariView: UIViewControllerRepresentable {
	typealias UIViewControllerType = CustomSafariViewController

	var url: URL?

	func makeUIViewController(context: UIViewControllerRepresentableContext<SafariView>) -> CustomSafariViewController {
		return CustomSafariViewController()
	}

	func updateUIViewController(_ safariViewController: CustomSafariViewController, context: UIViewControllerRepresentableContext<SafariView>) {
		safariViewController.url = url
	}
}
