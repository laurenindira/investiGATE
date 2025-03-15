//
//  ProjectDetail.swift
//  investiGATE
//
//  Created by Raihana Zahra on 3/15/25.
//

import SwiftUI

struct ProjectDetail: View {
    @State var project: Project
    @State var user: User
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                
                // Back Button
                HStack {
                    Button(action: {
                        // TODO: back navigation
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.title2)
                            .foregroundColor(.black)
                    }
                    Spacer()
                }
                .padding(.horizontal)
                
                // Project Title & Department
                VStack(alignment: .leading, spacing: 5) {
                    Text(project.title)
                        .font(.largeTitle)
                        .bold()
                    
                    HStack {
                        Text(project.departments.joined(separator: " | "))
                            .foregroundColor(.gray)
                            .font(.subheadline)
                        
                        ForEach(project.topics, id: \.self) { topic in
                            Text(topic)
                                .font(.caption)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 4)
                                .background(Color.gray.opacity(0.2))
                                .clipShape(Capsule())
                        }
                    }
                }
                .padding(.horizontal)
                
                // Project Lead
                HStack {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundColor(.gray)
                    
                    Text("**Project Lead:** \(project.projectLead)")
                        .font(.body)
                }
                .padding(.horizontal)
                
                // Description Box
                VStack(alignment: .leading, spacing: 10) {
                    Text("Description")
                        .font(.headline)
                        .foregroundColor(Color.prim)
                    
                    Text(project.description)
                        .font(.body)
                        .foregroundColor(.black)
                }
                .padding()
                .background(Color.surface)
                .cornerRadius(10)
                .padding(.horizontal)
                
                // Current Team
                VStack(alignment: .leading, spacing: 10) {
                    Text("Current Team")
                        .font(.headline)
                        .foregroundColor(Color.prim)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 15) {
                            ForEach(project.team, id: \.self) { member in
                                VStack {
                                    Image(systemName: "person.circle.fill")
                                        .resizable()
                                        .frame(width: 70, height: 70)
                                        .foregroundColor(.gray)
                                    
                                    Text("Member Name")
                                        .font(.caption)
                                        .bold()
                                        .foregroundColor(Color.prim)
                                    
                                    Text("Affiliation")
                                        .font(.caption2)
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                    }
                }
                .padding(.horizontal)
                
                // Who We're Looking For
                VStack(alignment: .leading, spacing: 10) {
                    Text("Who we’re looking for")
                        .font(.headline)
                        .foregroundColor(Color.blue)
                    
                    Text(project.requirements)
                        .font(.body)
                        .foregroundColor(.black)
                }
                .padding(.horizontal)
                
                // Apply Button
                Button(action: {
                    // TODO: nav link to application
                }) {
                    GenButton(placeholder: "apply here!", backgroundColor: Color.prim, foregroundColor: Color.white, isSystemImage: true)
                }
                .padding(.horizontal)
            }
            .padding(.top, 20)
        }
    }
}

let sampleUser = User(
    id: "123",
    displayName: "Sam Charger",
    email: "sam.charger@email.com",
    creationDate: Date(),
    providerRef: "google",
    isProfessor: false,
    researchInterests: ["Artificial Intelligence", "Human-Computer Interaction"],
    majorDepartment: ["Computer Science", "English"],
    bio: "Passionate about CS and literature, exploring research in AI and UX design.",
    profilePicture: nil, // Can be a URL string if using Firebase Storage
    gradDate: Calendar.current.date(from: DateComponents(year: 2026, month: 6, day: 15)),
    currentYear: "Junior",
    link: [
        UserLinks(linkName: "LinkedIn", linkURL: "https://www.linkedin.com/in/samcharger"),
        UserLinks(linkName: "GitHub", linkURL: "https://github.com/samcharger")
    ]
)

let sampleProject = Project(
    id: "1",
    title: "GRNsight: Defining Gene Regulatory Networks",
    departments: ["CMSI", "BIOL"],
    topics: ["Genes", "Web Development"],
    projectLead: "Dondi",
    description: "Modeling gene regulatory networks and protein-protein interactions. Analyzing data structures for gene functions.",
    team: ["1", "2", "3"],
    requirements: "Bio or CMSI major with interest in computational biology.",
    hiring: true
)

#Preview {
    ProjectDetail(project: sampleProject, user: sampleUser)
}
