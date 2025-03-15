//
//  OnboardingController.swift
//  investiGATE
//
//  Created by Lauren Indira on 3/15/25.
//

import SwiftUI

struct OnboardingController: View {
    @EnvironmentObject var auth: AuthViewModel
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    OnboardingController()
        .environmentObject(AuthViewModel())
}
