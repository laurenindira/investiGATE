//
//  AuthViewModel.swift
//  investiGATE
//
//  Created by Lauren Indira on 3/15/25.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore
import GoogleSignIn

@Observable
class AuthViewModel: NSObject, ObservableObject {
    static var shared = AuthViewModel()
    
    var user: User? {
        didSet {
            if let currentUser = user {
                saveUserToCache(user: currentUser)
                userDefaults.set(currentUser != nil, forKey: "isSignedIn")
            } else {
                clearUserCache()
            }
        }
    }
    
    //firebase
    private let auth = Auth.auth()
    private let db = Firestore.firestore()
    
    //local caching 
    private let userDefaults = UserDefaults.standard
    private let userKey = "cachedUser"
    
    //loading and errors
    var isLoading: Bool = false
    var errorMessage: String?
    
    //testing for signed in status
    override init() {
        guard auth.currentUser != nil else {
            self.user = nil
            return
        }
        
        if let savedUserData = userDefaults.data(forKey: userKey),
           let savedUser = try? JSONDecoder().decode(User.self, from: savedUserData) {
            user = savedUser
            UserDefaults.standard.set(true, forKey: "isSignedIn")
        }
    }
    
    //MARK: - Sign up
    func signUpWithEmail(tempUser: User, password: String) async throws {
        self.isLoading = true
        
        do {
            let result = try await auth.createUser(withEmail: tempUser.email, password: password)
            let user = User(id: result.user.uid, displayName: tempUser.displayName, email: tempUser.email, creationDate: Date(), providerRef: "email/password", isProfessor: tempUser.isProfessor, researchInterests: tempUser.researchInterests, majorDepartment: tempUser.majorDepartment, bio: "", profilePicture: "", gradDate: tempUser.gradDate ?? nil, currentYear: tempUser.currentYear ?? nil, link: [])
            self.user = user
            try await saveUserToFirestore(user: user)
            saveUserToCache(user: user)
            UserDefaults.standard.set(true, forKey: "isSignedIn")
            self.isLoading = false
        } catch let error as NSError {
            self.errorMessage = error.localizedDescription
            print("ERROR: Sign up failure - \(String(describing: errorMessage))")
            self.isLoading = false
            throw error
        }
    }

    //MARK: - Sign in
    func signInWithEmail(email: String, password: String) async throws {
        self.isLoading = true
        
        do {
            let result = try await auth.signIn(withEmail: email, password: password)
            await loadUserFromFirebase()
            UserDefaults.standard.set(true, forKey: "isSignedIn")
            self.isLoading = false
        } catch let error as NSError {
            self.errorMessage = error.localizedDescription
            print("ERROR: Sign in failure - \(String(describing: errorMessage))")
            self.isLoading = false
            throw error
        }
    }
    
    func signInWithGoogle(tempUser: User, presenting: UIViewController, completion: @escaping(Error?) -> Void) {
        self.isLoading = true
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        GIDSignIn.sharedInstance.signIn(withPresenting: presenting) { result, error in
            guard error == nil else {
                self.isLoading = false
                print("ERROR: Google sign up error - \(error?.localizedDescription ?? "")")
                completion(error)
                return
            }
            
            guard let currentUser = result?.user,
                  let idToken = currentUser.idToken?.tokenString,
                  let email = currentUser.profile?.email,
                  let fullName = currentUser.profile?.name else {
                return
            }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: currentUser.accessToken.tokenString)
            
            Auth.auth().signIn(with: credential) { result, error in
                guard let authResult = result, error == nil else {
                    self.isLoading = false
                    completion(error)
                    return
                }
                
                let uid = authResult.user.uid
                let userRef = self.db.collection("users").document(uid)
                
                userRef.getDocument { document, error in
                    if let document = document, document.exists {
                        if let data = document.data() {
                            Task {
                                await self.loadUserFromFirebase()
                                UserDefaults.standard.set(true, forKey: "isSignedIn")
                            }
                        }
                    } else {
                        let newUser = User(id: uid, displayName: fullName, email: email, creationDate: Date(), providerRef: "google", isProfessor: tempUser.isProfessor, researchInterests: tempUser.researchInterests, majorDepartment: tempUser.majorDepartment, bio: "", profilePicture: "", gradDate: tempUser.gradDate ?? nil, currentYear: tempUser.currentYear ?? nil, link: [])
                      
                        Task {
                            do {
                                try await self.saveUserToFirestore(user: newUser)
                                self.user = newUser
                                self.saveUserToCache(user: newUser)
                                UserDefaults.standard.set(true, forKey: "isSignedIn")
                                self.isLoading = false
                            } catch {
                                self.isLoading = false
                                print("ERROR: Could not save Firebase user - \(error.localizedDescription)")
                                completion(error)
                            }
                        }
                    }
                }
            }
        }
    }
    
    //MARK: - Saving user data
    func saveUserToFirestore(user: User) async throws {
        do {
            try await db.collection("users").document(user.id).setData([
                "id": user.id,
                "displayName": user.displayName,
                "email": user.email,
                "creationDate": Timestamp(date: user.creationDate),
                "providerRef": user.providerRef,
                "isProfessor": user.isProfessor,
                "reserchInterests": user.researchInterests,
                "majorDepartment": user.majorDepartment,
                "bio": user.bio ?? "",
                "profilePicture": user.profilePicture ?? "",
                "gradDate": Timestamp(date: user.gradDate ?? Date()),
                "currentYear": user.currentYear ?? "",
                "link": user.link
            ])
        } catch let error as NSError {
            self.errorMessage = error.localizedDescription
            print("ERROR: Failure saving to Firestore - \(String(describing: errorMessage))")
            throw error
        }
    }
    
    //MARK: - Loading users
    private func loadSession() async {
        guard auth.currentUser != nil else {
            self.user = nil
            return
        }
        
        if let cachedUser = loadUserFromCache() {
            self.user = cachedUser
        } else {
            await loadUserFromFirebase()
        }
    }
    
    func loadUserFromFirebase() async {
        guard let currentUser = auth.currentUser else { return }
        do {
            let snapshot = try await db.collection("users").document(currentUser.uid).getDocument()
            if let userData = snapshot.data() {
                let currentUser = try Firestore.Decoder().decode(User.self, from: userData)
                self.user = currentUser
                saveUserToCache(user: currentUser)
            }
        } catch let error as NSError {
            self.errorMessage = error.localizedDescription
            print("ERROR: Cannot load user - \(String(describing: errorMessage))")
        }
    }
    
    //MARK: - Sign out
    func signOut() {
        self.isLoading = true
        
        do {
            if auth.currentUser?.uid != nil {
                try auth.signOut()
                self.user = nil
                clearUserCache()
            }
            self.isLoading = false
        } catch let error as NSError {
            self.errorMessage = error.localizedDescription
            print("ERROR: Sign out error - \(String(describing: errorMessage))")
            self.isLoading = false
        }
    }
    
    func deleteAccount(completion: @escaping (Error?) -> Void) async throws {
        guard let currentUser = auth.currentUser else {
            completion(NSError(domain: "UserNotLoggedIn", code: 0, userInfo: [NSLocalizedDescriptionKey: "No user is currently logged in."]))
            return
        }
        
        self.isLoading = true
        let userID = currentUser.uid
        let userRef = db.collection("users").document(userID)
        
        do {
            try await userRef.delete()
            print("SUCCESS: User removed from user collection")
            try await currentUser.delete()
            print("SUCCESS: User deleted from auth console")
            self.user = nil
            clearUserCache()
        } catch let error as NSError {
            self.errorMessage = error.localizedDescription
            print("ERROR: Account deletion error - \(String(describing: errorMessage))")
            self.isLoading = false
            completion(error)
        }
    }
    
    //MARK: - Local storage functions
    private func saveUserToCache(user: User) {
        if let encodedUser = try? JSONEncoder().encode(user) {
            userDefaults.set(encodedUser, forKey: userKey)
        }
    }
    
    private func loadUserFromCache() -> User? {
        guard let savedUserData = userDefaults.data(forKey: userKey) else { return nil }
        return try? JSONDecoder().decode(User.self, from: savedUserData)
    }

    private func clearUserCache() {
        userDefaults.removeObject(forKey: userKey)
        UserDefaults.standard.set(false, forKey: "isSignedIn")
    }

}

protocol FormAuthenticationProtocol {
    var isFormValid: Bool { get }
}
