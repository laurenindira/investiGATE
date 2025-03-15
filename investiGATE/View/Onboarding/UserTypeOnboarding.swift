//
//  UserTypeOnboarding.swift
//  investiGATE
//
//  Created by Lauren Indira on 3/15/25.
//

import SwiftUI

struct UserTypeOnboarding: View {
    @Binding var user: User
    @Binding var step: Int
    var userPick: Bool? = nil
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Nice to meet you! Are you a professor or a student?")
                .font(.headline)
            
            HStack(spacing: 20) {
                Button(action: {
                    user.isProfessor = true
                }) {
                    Text("Professor")
                        .foregroundColor(user.isProfessor == true ? .white : Color.black)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 20)
                        .background(user.isProfessor == true ? Color.prim : Color.surface)
                        .cornerRadius(10)
                }
                
                Button(action: {
                    user.isProfessor = false
                }) {
                    Text("Student")
                        .foregroundColor(user.isProfessor == false ? .white : Color.black)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 20)
                        .background(user.isProfessor == false ? Color.prim : Color.surface)
                        .cornerRadius(10)
                }
            }
            .animation(.easeInOut, value: user.isProfessor)
            
            Button {
                if user.isProfessor {
                    step += 2
                } else {
                    step += 1
                }
                
            } label: {
                GenButton(placeholder: "Next", backgroundColor: Color.prim, foregroundColor: Color.white, imageRight: "arrow.right", isSystemImage: true)
            }
            .padding(.top, 20)
        
        }
        .padding()
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button() {
                    step -= 1
                } label: {
                    HStack {
                        Image(systemName: "chevron.left")
                            .font(.body)
                        Text("Back")
                    }
                    .foregroundStyle(Color.prim)
                }
            }
        }
    }
}

#Preview {
    UserTypeOnboarding(user: .constant(User(id: "", displayName: "", email: "", creationDate: Date(), providerRef: "google", isProfessor: false, researchInterests: [], majorDepartment: [], link: [])), step: .constant(1))
}
