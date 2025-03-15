//
//  NameSelectionOnboarding.swift
//  investiGATE
//
//  Created by Lauren Indira on 3/15/25.
//

import SwiftUI

struct NameSelectionOnboarding: View {
    @Binding var user: User
    @Binding var step: Int
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("So, what do you want us to call you?")
                .font(.headline)
            
            GenTextField(placeholder: "enter your name", text: $user.displayName)
            
            Button {
                if !user.displayName.isEmpty { step += 1 }
            } label: {
                GenButton(placeholder: "Next", backgroundColor: Color.prim, foregroundColor: Color.white, imageRight: "arrow.right", isSystemImage: true)
            }
            .disabled(user.displayName.isEmpty)
            .opacity((user.displayName == "") ? 0.5 : 1)
            .padding(.top, 20)
            
        }
        .padding()
    }
}

#Preview {
    NameSelectionOnboarding(user: .constant(User(id: "", displayName: "", email: "", creationDate: Date(), providerRef: "google", isProfessor: false, researchInterests: [], majorDepartment: [], link: [])), step: .constant(1))
}
