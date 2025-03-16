//
//  Project.swift
//  investiGATE
//
//  Created by Cecilia Zaragoza on 3/15/25.
//

import Foundation
import SwiftUI

struct Project: Identifiable, Codable, Hashable {
    var id: String
    var title: String
    var departments: [String]
    var topics: [String]
    var projectLeadId: String
    var projectLeadName: String //maybe professor object?
    var description: String
    var team: [String] // list of userIds
    var requirements: String // requirements for someone to join research team
    var hiring: Bool
    var thumbnailURL: String?
}
