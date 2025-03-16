//
//  SignInView.swift
//  investiGATE
//
//  Created by Lauren Indira on 3/15/25.
//

import SwiftUI

struct SignInView: View {
    @Environment(AuthViewModel.self) private var auth
    @Environment(\.dismiss) private var dismiss
        
    @State private var showAlert = false
    @State private var alertMessage = ""
        
    @State var email: String = ""
    @State var password: String = ""
    @State var showPassword: Bool = false
    
    @State private var tempUser: User = User(id: "", displayName: "", email: "", creationDate: Date(), providerRef: "", isProfessor: true, researchInterests: [], majorDepartment: [], link: [])
    
    var showPasswordToggle: Bool {
        get { showPassword }
        set { showPassword = newValue }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                
                Spacer()
                
                //LOGO
                Image("investigate_wordmark")
                    .resizable()
                    .scaledToFit()
                    .frame(width: UIScreen.main.bounds.width * 0.8)
                
                Spacer()
                
                //FIELDS
                VStack {
                    VStack(alignment: .leading, spacing: 5) {
                        Text("email")
                        GenTextField(placeholder: "email", text: $email)
                    }
                    
                    VStack(alignment: .leading, spacing: 5) {
                        Text("password")
                        SecureTextField(placeholder: "passwpord", showPassword: showPassword, text: $password)
//                        GenTextField(placeholder: "password", text: $email)
                    }
                }
                .padding(.bottom, 40)
                
                Spacer()
                
                //BUTTONS
                Button {
                    emailSignIn()
                } label: {
                    GenButton(placeholder: "sign in", backgroundColor: Color.prim, foregroundColor: Color.white, imageRight: "arrow.right", isSystemImage: true)
                }
                .disabled(!isFormValid)
                
                Text("or")
                
                Button {
                    googleSignIn()
                } label: {
                    GenButton(placeholder: "sign in with Google", backgroundColor: Color.prim, foregroundColor: Color.white, imageRight: "google_logo", isSystemImage: false)
                }
                
                
            }
            .frame(maxHeight: UIScreen.main.bounds.height)
            .padding()
            .background(Color.bg)
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Something went wrong while making your account"), message: Text(auth.errorMessage ?? ""), primaryButton: .default(Text("Try again")), secondaryButton: .cancel(Text("Go back")) { dismiss() })
        }
    }
    
    func emailSignIn() {
        Task {
            do {
                try await auth.signInWithEmail(email: email, password: password)
            } catch {
                showAlert = true
            }
        }
    }
    
    func googleSignIn() {
        auth.signInWithGoogle(tempUser: tempUser, presenting: getRootViewController()) { error in
            if error != nil {
                showAlert = true
            }
        }
    }
}

extension SignInView: FormAuthenticationProtocol {
    var isFormValid: Bool {
        return !email.isEmpty && !password.isEmpty && password.count >= 6 && email.contains("@") && email.contains(".")
    }
}

#Preview {
    SignInView()
}
