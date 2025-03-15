//
//  tempDash.swift
//  investiGATE
//
//  Created by Lauren Indira on 3/15/25.
//

import SwiftUI

struct tempDash: View {
    @EnvironmentObject var auth: AuthViewModel
    
    var body: some View {
        Text("this is a dashboard")
        
        Button {
            Task {
                auth.signOut()
            }
        } label: {
            GenButton(placeholder: "sign out", backgroundColor: Color.prim, foregroundColor: Color.white, isSystemImage: false)
        }
    }
}

#Preview {
    tempDash()
        .environmentObject(AuthViewModel())
}
