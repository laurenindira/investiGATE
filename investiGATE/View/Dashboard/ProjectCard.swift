//
//  ProjectCard.swift
//  investiGATE
//
//  Created by Cecilia Zaragoza on 3/15/25.
//

import SwiftUI

struct ProjectCard: View {
    @State var project: Project
    
    var body: some View {
        VStack(alignment: .leading) {
            Image(systemName: "Home")
            
            Text(project.title)
                .font(.body)
                .lineLimit(3)
                .frame(maxWidth: 140)
                .fixedSize(horizontal: false, vertical: true)
            
            Image(systemName: "Home")
                .resizable()
                .scaledToFill()
                .frame(width: 150, height: 150)
                .background(.black)
                .clipShape(RoundedRectangle(cornerRadius: 15))
            
            HStack {
            // TODO: in future, should iteratively create tags for each department stored in project like in Tag Preview
                HStack {
                    ForEach(project.departments, id: \.self) { department in
                        Tag(keyword: department)
                    }
                }
                
            }
        }
        //.frame(maxWidth: 160, maxHeight: 270, alignment: .top)
        
    }
}

#Preview {
    ProjectCard(project: Project(
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
    )
}
