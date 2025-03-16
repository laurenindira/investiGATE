//
//  CarouselView.swift
//  investiGATE
//
//  Created by Lauren Indira on 3/15/25.
//

import SwiftUI

struct CarouselView: View {
    @EnvironmentObject var auth: AuthViewModel
    var featuredProjects: [Project]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 15) {
                ForEach(featuredProjects, id: \.self) { project in
                    NavigationLink {
                        //
                    } label: {
                        CarouselCard(project: project)
                            .transition(.slide)
                            .animation(.easeInOut, value: featuredProjects)
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}


#Preview {
    CarouselView(featuredProjects: [
        Project(id: "", title: "fake title one", departments: ["BIOL", "CMSI"], topics: ["math", "bugs"], projectLead: "Dr. Linda Loo", description: "this project is about", team: [], requirements: "", hiring: true),
        Project(id: "", title: "fake title one", departments: ["BIOL", "CMSI"], topics: ["math", "bugs"], projectLead: "Dr. Linda Loo", description: "this project is about", team: [], requirements: "", hiring: true),
        Project(id: "", title: "fake title one", departments: ["BIOL", "CMSI"], topics: ["math", "bugs"], projectLead: "Dr. Linda Loo", description: "this project is about", team: [], requirements: "", hiring: true)
    ])
        .environment(AuthViewModel())
}
