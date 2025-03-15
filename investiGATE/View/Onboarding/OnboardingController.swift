//
//  OnboardingController.swift
//  investiGATE
//
//  Created by Lauren Indira on 3/15/25.
//

import SwiftUI

struct OnboardingController: View {
    @EnvironmentObject var auth: AuthViewModel
    @Binding var user: User
    @State private var step: Int = 1
    
    var body: some View {
        VStack {
            if step == 1 {
                
            } else if step == 2 {
                
            } else if step == 3 {
                
            } else if step == 4 {
                
            }
        }
    }
}

#Preview {
    OnboardingController(user: .constant(User(id: "", displayName: "", email: "", creationDate: Date(), providerRef: "google", isProfessor: false, researchInterests: [], majorDepartment: [], link: [])))
        .environmentObject(AuthViewModel())
}
