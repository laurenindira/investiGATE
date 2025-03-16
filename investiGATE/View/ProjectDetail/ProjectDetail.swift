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
    
    @State private var isFavorited: Bool = false
    
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
                    
                    Button(action: {
                        isFavorited.toggle()
                    }) {
                        Image(systemName: isFavorited ? "star.fill" : "star")
                            .foregroundColor(isFavorited ? .yellow : .black)
                    }
                }
                .padding(.horizontal)
                
                // Project Title & Department
                VStack(alignment: .leading, spacing: 5) {
                    Text(project.title)
                        .font(.largeTitle)
                        .bold()
                    
                    HStack {
                        Text(project.departments.joined(separator: " + "))
                            .foregroundColor(.gray)
                            .font(.subheadline)
                        
                        Text(" | ")
                            .foregroundColor(.gray)
                            .font(.subheadline)
                        
                        ForEach(project.topics, id: \.self) { topic in
                            Tag(keyword: topic)
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
                    
//                    Text("**Project Lead:** \(project.projectLead)")
//                        .font(.body)
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
                            ForEach(getTeamMembers(for: project), id: \.id) { member in
                                MemberCard(user: member)
                            }
                        }
                    }
                }
                .padding(.horizontal)
                
                // Who We're Looking For
                VStack(alignment: .leading, spacing: 10) {
                    Text("Who we’re looking for")
                        .font(.headline)
                        .foregroundColor(Color.prim)
                    
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
    
    // functions
    func getTeamMembers(for project: Project) -> [User] {
        return sampleUser.filter { project.team.contains($0.id) }
    }
}

//TODO: add actual fetching froom database
let sampleUser: [User] = [
        User(id: "1", displayName: "Alice Johnson", email: "alice@email.com",
             creationDate: Date(), providerRef: "google", isProfessor: false,
             researchInterests: ["AI", "Bioinformatics"], majorDepartment: ["CMSI", "BIOL"],
             bio: "Bioinformatics enthusiast.", profilePicture: nil, gradDate: nil, currentYear: "Senior",
             link: []),
        User(id: "2", displayName: "Bob Smith", email: "bob@email.com",
             creationDate: Date(), providerRef: "email", isProfessor: false,
             researchInterests: ["HCI", "ML"], majorDepartment: ["CS"],
             bio: "Passionate about machine learning.", profilePicture: nil, gradDate: nil, currentYear: "Junior",
             link: []),
        User(id: "3", displayName: "Charlie Davis", email: "charlie@email.com",
             creationDate: Date(), providerRef: "google", isProfessor: false,
             researchInterests: ["Cybersecurity"], majorDepartment: ["CS"],
             bio: "Exploring security in AI applications.", profilePicture: nil, gradDate: nil, currentYear: "Senior",
             link: [])
    ]

let sampleProject = Project(
    id: "1",
    title: "GRNsight: Defining Gene Regulatory Networks",
    departments: ["CMSI", "BIOL"],
    topics: ["Hiring", "Not hiring"],
    projectLeadId: "1",
    projectLeadName: "Dondi",
    description: "Lorem ipsum odor amet, consectetuer adipiscing elit. Risus hac etiam enim placerat; rhoncus morbi sapien. Dictum laoreet dui sem malesuada ante. Amet elementum tempor per maecenas commodo. Primis at praesent est potenti ridiculus torquent. Tempor ante lobortis; fames placerat rutrum mi natoque. Venenatis malesuada id a cursus dictumst iaculis. Condimentum iaculis ac maecenas fringilla velit litora convallis natoque. Consequat felis dui fusce viverra blandit finibus.",
    team: ["1", "2", "3"],
    requirements: "Bio or CMSI major with interest in computational biology.",
    hiring: true
)

#Preview {
    ProjectDetail(project: sampleProject, user: sampleUser.first!)
}
