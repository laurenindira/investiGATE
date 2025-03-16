//
//  SignUpView.swift
//  investiGATE
//
//  Created by Lauren Indira on 3/15/25.
//

import SwiftUI

struct SignUpView: View {
    @Environment(AuthViewModel.self) private var auth
    @Environment(\.dismiss) private var dismiss
    
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    @State var email: String = ""
    @State var password: String = ""
    @State var confirmPassword: String = ""
    @State var showPassword: Bool = false
    @State var showConfirmPassword: Bool = false
    
    var tempUser: User
    
    var showPasswordToggle: Bool {
        get { showPassword }
        set { showPassword = newValue }
    }
    
    var showConfirmPasswordToggle: Bool {
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
                        GenTextField(placeholder: "password", text: $password)
                    }
                    
                    VStack(alignment: .leading, spacing: 5) {
                        Text("confirm password")
                        GenTextField(placeholder: "confirm password", text: $confirmPassword)
                    }
                }
                .padding(.bottom, 40)
                
                Spacer()
                
                //BUTTONS
                Button {
                    emailSignUp()
                } label: {
                    GenButton(placeholder: "make my account!", backgroundColor: Color.prim, foregroundColor: Color.white, imageRight: "arrow.right", isSystemImage: true)
                }
                .disabled(!isFormValid)
                
                Text("or")
                
                Button {
                    googleSignUp()
                } label: {
                    GenButton(placeholder: "sign up with Google", backgroundColor: Color.prim, foregroundColor: Color.white, imageRight: "google_logo", isSystemImage: false)
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
    
    func emailSignUp() {
        Task {
            do {
                try await auth.signUpWithEmail(tempUser: tempUser, password: password)
            } catch {
                showAlert = true
            }
        }
    }
    
    func googleSignUp() {
        auth.signInWithGoogle(tempUser: tempUser, presenting: getRootViewController()) { error in
            if error != nil {
                showAlert = true
            }
        }
    }
}

extension SignUpView: FormAuthenticationProtocol {
    var isFormValid: Bool {
        return !email.isEmpty && !password.isEmpty && !confirmPassword.isEmpty && password == confirmPassword && password.count >= 6 && email.contains("@") && email.contains(".")
    }
}

#Preview {
    SignUpView(tempUser: User(id: "", displayName: "", email: "", creationDate: Date(), providerRef: "google", isProfessor: false, researchInterests: [], majorDepartment: [], link: []))
        .environmentObject(AuthViewModel())
}
