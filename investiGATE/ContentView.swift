//
//  ContentView.swift
//  investiGATE
//
//  Created by Lauren Indira on 3/15/25.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var auth: AuthViewModel
    @EnvironmentObject var projectsService: Projects
    
    @AppStorage("isSignedIn") var isSignedIn = false
    
    var body: some View {
        Group {
            if !isSignedIn {
                SplashView()
                    .environmentObject(auth)
            } else {
                TabView {
                    DashboardView()
                        .tabItem {
                            Label("Dashboard", systemImage: "house")
                        }
                    
                    AllProjectsView()
                        .tabItem {
                            Label("All Projects", systemImage: "list.bullet")
                        }
                    ProjectCreationView()
                        .tabItem {
                            Label("Project", systemImage: "plus")
                        }
                }
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(AuthViewModel())
        .environmentObject(Projects())
}
