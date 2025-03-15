//
//  SwiftUIView.swift
//  investiGATE
//
//  Created by Cecilia Zaragoza on 3/15/25.
//

import SwiftUI

struct DashboardView: View {
    @State var recentProjects: [Project] = []
    @State var recommendedProjects: [Project] = []
    @State var currentProjects: [Project] = []
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {
                    ScrollView {
                        HStack {
                            //                        carousel w/ 5 recently added projects
                            ForEach(recentProjects, id: \.self) { project in
                                ProjectCard(project: project)
                            }
                        }
                    }
                    
                    
                    Text("These might spark your interest")
                    HStack {
                        
                        ForEach(recommendedProjects, id: \.self) { project in
                            ProjectCard(project: project)
                        }
                    }
                    
                    Text("What you're working on")
                    HStack {
                        ForEach(currentProjects, id: \.self) { project in
                            ProjectCard(project: project)
                        }
                    }
                }
                
            }
            
        }
        
    }
}

#Preview {
    DashboardView(
        recentProjects: [
            Project(
                id: "1",
                title: "GRNsight: Defining Gene Regulatory Networks",
                departments: ["CMSI", "BIOL"],
                topics: ["Genes", "Web Development"],
                projectLead: "Dondi",
                projectDescription: "Modeling gene regulatory networks and protein-protein interactions.",
                team: ["1", "2"],
                requirements: "bio or cmsi major",
                hiring: false
            )
            
        ],
        recommendedProjects: [
            Project(
                id: "1",
                title: "GRNsight: Defining Gene Regulatory Networks",
                departments: ["CMSI", "BIOL"],
                topics: ["Genes", "Web Development"],
                projectLead: "Dondi",
                projectDescription: "Modeling gene regulatory networks and protein-protein interactions.",
                team: ["1", "2"],
                requirements: "bio or cmsi major",
                hiring: false
            )
            
        ],
        currentProjects: [
            Project(
                id: "1",
                title: "GRNsight: Defining Gene Regulatory Networks",
                departments: ["CMSI", "BIOL"],
                topics: ["Genes", "Web Development"],
                projectLead: "Dondi",
                projectDescription: "Modeling gene regulatory networks and protein-protein interactions.",
                team: ["1", "2"],
                requirements: "bio or cmsi major",
                hiring: false
            )
        ]
    )
}
