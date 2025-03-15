//
//  investiGATEAppDelegate.swift
//  investiGATE
//
//  Created by Lauren Indira on 3/15/25.
//

import Foundation
import SwiftUI
import FirebaseCore
import GoogleSignIn

class investiGATEAppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}
