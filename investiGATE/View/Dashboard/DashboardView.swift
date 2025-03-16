//
//  SwiftUIView.swift
//  investiGATE
//
//  Created by Cecilia Zaragoza on 3/15/25.
//

import SwiftUI
import SwiftUIInfiniteCarousel

struct DashboardView: View {
    @EnvironmentObject var projectsService: Projects
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
                        .frame(width: UIScreen.main.bounds.width * 0.75)
                    
                    //CAROUSEL
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Fresh out the gate")
                            .font(.title3).bold()
                            .foregroundStyle(Color.prim)
                            .padding(.bottom, -10)
                        
                        CarouselView(featuredProjects: recentProjects)
                    }
                    
                    VStack(alignment: .leading) {
                        Text("These might spark your interest...")
                            .font(.title3).bold()
                            .foregroundStyle(Color.prim)
                        ScrollView(.horizontal) {
                            HStack {
                                ForEach(recommendedProjects, id: \.self) { project in
                                    NavigationLink {
                                        //TODO: ADD DETAIL PAGE
                                    } label: {
                                        ProjectInfoCard(project: project)
                                    }
                                }
                            }
                        }
                        .scrollIndicators(.hidden)
                    }
                  
                    //CURRENT PROJECTS
                    VStack(alignment: .leading) {
                        Text("What you're working on")
                            .font(.title3).bold()
                            .foregroundStyle(Color.prim)
                        ScrollView(.horizontal) {
                            HStack {
                                ForEach(currentProjects, id: \.self) { project in
                                    NavigationLink {
                                        //TODO: ADD DETAIL PAGE
                                    } label: {
                                        ProjectInfoCard(project: project)
                                    }
                                }
                            }
                        }
                        .scrollIndicators(.hidden)
                    }
                }
                .padding()
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        NavigationLink {
                            SettingsView()
                        } label: {
                            Image(systemName: "gear")
                        }
                    }
                }
                .padding()
            }
        }
        .task {
            await projectsService.fetchProjects()
            
            print("got projects back?", projectsService.projects)
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
                projectLeadId: "1",
                projectLeadName: "Dondi",
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
                projectLeadId: "1",
                projectLeadName: "Dondi",
                description: "Modeling gene regulatory networks and protein-protein interactions.",
                team: ["1", "2"],
                requirements: "bio or cmsi major",
                hiring: false
            ),
            Project(id: "", title: "fake title one but longer for testing", departments: ["BIOL", "CMSI"], topics: ["math", "bugs"], projectLeadId: "1", projectLeadName: "Dr. Linda Loo", description: "this project is about", team: [], requirements: "", hiring: true, thumbnailURL: "https://snworksceo.imgix.net/ids/673119a2-05dd-4329-a9cc-9cc0f4496267.sized-1000x1000.png?w=1000"),
            Project(id: "", title: "fake title one but longer for testing", departments: ["BIOL", "CMSI"], topics: ["math", "bugs"], projectLeadId: "1", projectLeadName: "Dr. Linda Loo", description: "this project is about", team: [], requirements: "", hiring: true, thumbnailURL: "https://snworksceo.imgix.net/ids/673119a2-05dd-4329-a9cc-9cc0f4496267.sized-1000x1000.png?w=1000")
            
        ],
        currentProjects: [
            Project(
                id: "1",
                title: "GRNsight: Defining Gene Regulatory Networks",
                departments: ["CMSI", "BIOL"],
                topics: ["Genes", "Web Development"],
                projectLeadId: "1",
                projectLeadName: "Dondi",
                description: "Modeling gene regulatory networks and protein-protein interactions.",
                team: ["1", "2"],
                requirements: "bio or cmsi major",
                hiring: false
            )
        ]
    )
    .environmentObject(Projects())
}
