//
//  SplashView.swift
//  investiGATE
//
//  Created by Lauren Indira on 3/15/25.
//

import SwiftUI

struct SplashView: View {
    @EnvironmentObject var auth: AuthViewModel
    @State private var tempUser: User = User(id: "", displayName: "", email: "", creationDate: Date(), providerRef: "", isProfessor: true, researchInterests: [], majorDepartment: [], link: [])
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.bg
                    .ignoresSafeArea()
                
                VStack {
                    Spacer()
                    
                    VStack {
                        Image("logo_blue")
                            .resizable()
                            .scaledToFit()
                            .frame(width: UIScreen.main.bounds.width * 0.6)
                        Text("open up the gates")
                    }
                    
                    Spacer()
                    
                    VStack {
                        NavigationLink {
                            SignUpView(tempUser: tempUser)
                            //OnboardingController(user: $tempUser)
                        } label: {
                            GenButton(placeholder: "Let's get started!", backgroundColor: Color.prim, foregroundColor: Color.white, imageRight: "arrow.right", isSystemImage: true)
                        }
                        
                        HStack {
                            Text("already have an account?")
                            NavigationLink("Sign in!", destination: SignInView())
                                .foregroundStyle(Color.prim)
                        }
                    }
                }
                .padding()
            }
        }
    }
}

#Preview {
    SplashView()
        .environmentObject(AuthViewModel())
}
