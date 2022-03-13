//
//  AppDelegate.swift
//  Chess960Gen
//
//  Created by Robert Silverman on 4/4/20.
//  Copyright © 2020 Robert Silverman. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		// Override point for customization after application launch.
		return true
	}

	// MARK: UISceneSession Lifecycle

	func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
		// Called when a new scene session is being created.
		// Use this method to select a configuration to create the new scene with.
		return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
	}

	func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
		// Called when the user discards a scene session.
		// If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
		// Use this method to release any resources that were specific to the discarded scenes, as they will not return.
	}

	// helpers
	static func afterDelay
		(_ delay: Double, closure: @escaping ()->()) {
		DispatchQueue.main.asyncAfter( deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC),
		                execute: closure
		)
	}
}

extension UINavigationController {
	
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        let appearance = UINavigationBarAppearance()
        
		if let font = UIFont(name: "Lato-Bold", size: 20) {
			appearance.titleTextAttributes = [.font: font]
		}
		if let font = UIFont(name: "Lato-Black", size: 30) {
			appearance.largeTitleTextAttributes = [.font: font]
		}

		navigationBar.standardAppearance = appearance
    }
}
