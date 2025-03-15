//
//  ProfileView.swift
//  investiGATE
//
//  Created by Raihana Zahra on 3/15/25.
//

import SwiftUI

struct ProfileView: View {
    @State var project: Project
    @State var user: User
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                
                // Profile Header
                HStack {
                    Image("profile pic")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 80, height: 80)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.gray, lineWidth: 2))
                    
                    VStack(alignment: .leading) {
                        Text(user.displayName)
                            .font(.title)
                            .bold()
                            .foregroundColor(Color.darkblue)
                        
                        Text("junior cs + english major")
                            .foregroundColor(Color.lightblue)
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        // TODO: settings page
                    }) {
                        Image(systemName: "gearshape.fill")
                            .font(.title2)
                            .foregroundColor(.gray)
                    }
                }
                .padding(.horizontal)
                
                // Research Interests
                Text("Research Interests")
                    .font(.headline)
                    .padding(.horizontal)
                    .foregroundColor(Color.darkblue)
                
                // Current Projects
                Text("Current Projects")
                    .font(.headline)
                    .padding(.horizontal)
                    .foregroundColor(Color.darkblue)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 15) {
                        ProjectCard(project: project)
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 60)
                    .frame(height: 300)
                }
                
                // Past Projects
                Text("Past Projects")
                    .font(.headline)
                    .padding(.horizontal)
                    .foregroundColor(Color.darkblue)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 15) {
                        ProjectCard(project: project)
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 60)
                    .frame(height: 300)
                }
                
                // Saved Projects
                VStack(alignment: .leading, spacing: 5) {
                    Text("Saved Projects")
                        .font(.headline)
                    Text("Looks like you don’t have any projects saved!")
                        .foregroundColor(.gray)
                }
                .padding(.horizontal)
                
                // My Documents
                Text("My Documents")
                    .font(.headline)
                    .padding(.horizontal)
                    .foregroundColor(Color.darkblue)
                
                HStack {
                    DocumentButton(title: "Resume")
                    DocumentButton(title: "Portfolio")
                }
                .padding(.horizontal)
                
                Spacer()
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
    profilePicture: nil,
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
    projectDescription: "Modeling gene regulatory networks and protein-protein interactions.",
    team: ["1", "2"],
    requirements: "Bio or CMSI major",
    hiring: false
)

#Preview {
    ProfileView(project: sampleProject, user: sampleUser)
}
