//
//  SettingsView.swift
//  investiGATE
//
//  Created by Lauren Indira on 3/15/25.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var auth: AuthViewModel
    @EnvironmentObject var projectVM: Projects
    
    var body: some View {
        NavigationStack {
            VStack {
                
                Button {
                    Task {
                       auth.signOut()
                    }
                } label: {
                    GenButton(placeholder: "sign out", backgroundColor: Color.prim, foregroundColor: Color.white, isSystemImage: false)
                }
            }
            .padding()
        }
    }
}

#Preview {
    SettingsView()
        .environmentObject(AuthViewModel())
        .environmentObject(Projects())
}
