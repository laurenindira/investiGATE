//
//  SwiftUIView.swift
//  investiGATE
//
//  Created by Cecilia Zaragoza on 3/15/25.
//

import SwiftUI
import SwiftUIInfiniteCarousel

struct DashboardView: View {
    @State var recentProjects: [Project] = []
    @State var recommendedProjects: [Project] = []
    @State var currentProjects: [Project] = []
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    //LOGO
                    Image("investigate_wordmark")
                        .resizable()
                        .scaledToFit()
                        .frame(width: UIScreen.main.bounds.width * 0.6)
                    
                    //CAROUSEL
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Fresh out the gate")
                            .font(.title3).bold()
                            .foregroundStyle(Color.prim)
                        
                        CarouselView(featuredProjects: recentProjects)
                    }
                    
                    //RECOMMNEDED PROJECTS
                    VStack(alignment: .leading) {
                        Text("These might spark your interest...")
                        HStack {
                            ForEach(recommendedProjects, id: \.self) { project in
                                ProjectCard(project: project)
                            }
                            Spacer()
                        }
                    }
                    .padding(.top)
                    
                    
                    
                    VStack(alignment: .leading) {
                        Text("What you're working on")
                        HStack {
                            ForEach(currentProjects, id: \.self) { project in
                                ProjectCard(project: project)
                            }
                            Spacer()
                        }
                        
                    }
                }
                .padding()
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
                description: "Modeling gene regulatory networks and protein-protein interactions.",
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
                description: "Modeling gene regulatory networks and protein-protein interactions.",
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
                description: "Modeling gene regulatory networks and protein-protein interactions.",
                team: ["1", "2"],
                requirements: "bio or cmsi major",
                hiring: false
            )
        ]
    )
}
