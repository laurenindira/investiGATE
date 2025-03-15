//
//  User.swift
//  investiGATE
//
//  Created by Lauren Indira on 3/15/25.
//

import Foundation
import SwiftUI

struct User: Identifiable, Codable {
    //auth
    var id: String
    var displayName: String
    var email: String
    var creationDate: Date
    var providerRef: String //either google or email
    
    var isProfessor: Bool //bool check
    var researchInterests: [String]
    var majorDepartment: [String] //major for students, associated department for professors
    var bio: String? //optional description for profile page
    var profilePicture: String? //TODO: implement Firebase Storage for image uploads OR only do async images from internet
    
    //student specific
    var gradDate: Date? //date for students, nil for professors
    var currentYear: String? //freshman, sophomore, junior, senior, grad OR nil for professors
    //TODO: figure out how these references are gonna work lol. links?
    var link: [UserLinks]
}

struct UserLinks: Codable {
    var linkName: String
    var linkURL: String
}
