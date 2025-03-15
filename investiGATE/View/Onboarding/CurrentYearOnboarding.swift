//
//  CurrentYearOnboarding.swift
//  investiGATE
//
//  Created by Lauren Indira on 3/15/25.
//

import SwiftUI

struct CurrentYearOnboarding: View {
    @Binding var user: User
    @Binding var step: Int
    
    let years = ["Freshman", "Sophomore", "Junior", "Senior", "Grad"]
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
        
    var body: some View {
        VStack(spacing: 20) {
            Text("What year are you in?")
                .font(.headline)
            
            LazyVGrid(columns: columns, spacing: 12) {
                ForEach(years, id: \.self) { year in
                    Button(action: {
                        user.currentYear = year
                    }) {
                        Text(year)
                            .foregroundColor(user.currentYear == year ? .white : .black)
                            .padding(.vertical, 10)
                            .frame(maxWidth: .infinity)
                            .background(user.currentYear == year ? Color.prim : Color.surface)
                            .cornerRadius(10)
                    }
                }
            }
            .animation(.easeInOut, value: user.currentYear)
            
            NavigationLink {
                SignUpView(tempUser: user)
            } label: {
                GenButton(placeholder: "Finish", backgroundColor: Color.prim, foregroundColor: Color.white, imageRight: "arrow.right", isSystemImage: true)
            }
            .disabled(user.currentYear == nil)
            .opacity(user.currentYear == nil ? 0.5 : 1)
            .padding(.top, 20)
        }
        .padding()
        
        
    }
}

#Preview {
    CurrentYearOnboarding(user: .constant(User(id: "", displayName: "", email: "", creationDate: Date(), providerRef: "google", isProfessor: false, researchInterests: [], majorDepartment: [], currentYear: "", link: [])), step: .constant(1))
}
