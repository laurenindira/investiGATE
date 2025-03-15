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
    @State private var userType: UserType? = nil
    
    enum UserType {
        case professor
        case student
    }
    
    var body: some View {
        VStack {
            if step == 1 {
                //what should we call you
                NameSelectionOnboarding(user: $user, step: $step)
            } else if step == 2 {
                //are you a professor or student
                UserTypeOnboarding(user: $user, step: $step)
            } else if step == 3 {
                //what is your major OR department
                MajorSelectionOnboarding(user: $user, step: $step)
            } else if step == 4 {
                DepartmentSelectionOnboarding(user: $user, step: $step)
            } else if step == 5 {
                //research interests
                ResearchInterestsOnboarding(user: $user, step: $step)
            } else if step == 6 {
                //what is your current stage IF STUDENT
                CurrentYearOnboarding(user: $user, step: $step)
            }
        }
    }
}

#Preview {
    OnboardingController(user: .constant(User(id: "", displayName: "", email: "", creationDate: Date(), providerRef: "google", isProfessor: false, researchInterests: [], majorDepartment: [], link: [])))
        .environmentObject(AuthViewModel())
}
