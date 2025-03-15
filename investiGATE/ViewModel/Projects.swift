//
//  Projects.swift
//  investiGATE
//
//  Created by Cecilia Zaragoza on 3/15/25.
//

import Foundation
import Firebase

let PROJECT_COLLECTION_NAME = "projects"

enum ProjectServiceError: Error {
    case mismatchedDocumentError
    case unexpectedError
}

// may have to make this a MainActor, will see later though
class Projects: ObservableObject {
    private let db = Firestore.firestore()
    @Published var isLoading: Bool
    @Published var error: Error?
    @Published var projects: [Project]
    @Published var maxProjectCount: Int
    
    init() {
        projects = [Project]()
        maxProjectCount = 0
        isLoading = false
    }
    
    func fetchProjects(userId: String) async throws -> [Project]? {
        guard let userID = auth.user?.id else {
            self.errorMessage = "ERROR: user not logged in"
            print("ERROR: user not logged in")
            self.isLoading = false
            return
        }
        
        do {
            stacks = try await fetchUserStacks(userID: userID)
        } catch let error as NSError {
            self.errorMessage = error.localizedDescription
            print("ERROR: Failed fetch stack - \(String(describing: errorMessage))")
            self.isLoading = false
        }
        self.isLoading = false
    }
}
