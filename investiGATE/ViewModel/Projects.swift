//
//  Projects.swift
//  investiGATE
//
//  Created by Cecilia Zaragoza on 3/15/25.
//

import Foundation
import Firebase

let PROJECT_COLLECTION_NAME = "projects"
let ALL_PROJECT_COLLECTION_NAME = "allProjects"

enum ProjectServiceError: Error {
    case mismatchedDocumentError
    case userNotLoggedIn
    case unexpectedError
}

// may have to make this a MainActor, will see later though
class Projects: ObservableObject {
    static var shared = Projects()
    @Published var projects: [Project]
    
    var isLoading: Bool
    var errorMessage: String = ""
    
    //@Published var error: Error?
    @Published var maxProjectCount: Int
    
    private let db = Firestore.firestore()
    private var auth = AuthViewModel.shared
    
    init() {
        projects = [Project]()
        maxProjectCount = 0
        isLoading = false
    }
    
    func createProject(title: String, departments: [String], topics: [String], description: String, team: [String], requirements: String, hiring: Bool) async throws {
        guard let userID = auth.user?.id else {
            self.errorMessage = "ERROR: user not logged in"
            print("ERROR: user not logged in")
            return
        }
        
        guard let userDisplayName = auth.user?.displayName else {
            self.errorMessage = "ERROR: user not logged in"
            print("ERROR: user not logged in")
            return
        }
        
        let id = UUID().uuidString
        // TODO: ADD PROJECT ID
        do {
            try await db.collection(ALL_PROJECT_COLLECTION_NAME).document(userID).collection(PROJECT_COLLECTION_NAME).document(id).setData([
                "id": id,
                "title": title,
                "departments": departments,
                "topics": topics,
                "projectLeadId": userID,
                "projectLeadName": userDisplayName,
                "description": description,
                "team": team,
                "requirements": requirements,
                "hiring": hiring
          ])
        } catch {
          print("Error writing document: \(error)")
        }
        
        
    }

    @MainActor
    func fetchProjects() async {
        guard let userID = auth.user?.id else {
            self.errorMessage = "ERROR: user not logged in"
            print("ERROR: user not logged in")
            return
        }

        self.isLoading = true

        do {
            self.projects = try await fetchUserProjects(userID: userID)
            print("Successfully fetched projects:", projects)
        } catch {
            self.errorMessage = error.localizedDescription
            print("ERROR: Failed to fetch projects - \(self.errorMessage)")
        }

        self.isLoading = false
    }
    
    
    private func fetchUserProjects(userID: String) async throws -> [Project] {
        do {
            print("USERID", userID)
            let querySnapshot = try await db.collection(ALL_PROJECT_COLLECTION_NAME).document(userID).collection(PROJECT_COLLECTION_NAME).getDocuments()
            print("TRYING TO FETCH FROM DATABASE")
            return try querySnapshot.documents.compactMap { document in
                do {
                    var project = try document.data(as: Project.self)
                    project.id = document.documentID
                    return project
                } catch {
                    print("MISMATCHED DOCUMENTS")
                    throw ProjectServiceError.mismatchedDocumentError
                }
            }
        } catch {
            print("ERROR!!!!!!!!!!!!!!!: unexpected error when fetching")
            throw ProjectServiceError.unexpectedError
        }
    }
//  
//    private func fetchUserMealLogs(userID: String) async throws -> [MealLog] {
//        let querySnapshot = try await db.collection("mealLog").document(userID).collection("logs").getDocuments()
//        return querySnapshot.documents.compactMap { document in
//            var mealLog = try? document.data(as: MealLog.self)
//            mealLog?.id = document.documentID
//            return mealLog
//        }
//    }
//    
//    func fetchMealLogs() async {
//        guard let userID = auth.currentUser?.id else {
//            errorMessage = "User is not log in"
//            return
//        }
//        
//        DispatchQueue.main.async {
//            self.isLoading = true
//        }
//
//        defer {
//            DispatchQueue.main.async {
//                self.isLoading = false
//            }
//        }
//        
//        do {
//            let fetchedMealLogs = try await fetchUserMealLogs(userID: userID)
//            DispatchQueue.main.async {
//                self.mealLogs = fetchedMealLogs
//                self.fetched = true
//            }
//        } catch {
//            errorMessage = "Something wrong with fetching meals log: \(error.localizedDescription)"
//        }
//        filterMealLogs()
//    }
}
