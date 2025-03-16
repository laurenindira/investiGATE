//
//  investiGATEApp.swift
//  investiGATE
//
//  Created by Lauren Indira on 3/15/25.
//

import SwiftUI

@main
struct investiGATEApp: App {
    @UIApplicationDelegateAdaptor(investiGATEAppDelegate.self) var appDelegate
    @AppStorage("isSignedIn") var isSignedIn = false
    
    @StateObject private var auth = AuthViewModel.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(AuthViewModel())
                .environmentObject(Projects())
        }
    }
}
