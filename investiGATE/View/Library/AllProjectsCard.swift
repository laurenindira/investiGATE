//
//  AllProjectsCard.swift
//  investiGATE
//
//  Created by Lauren Indira on 3/15/25.
//

import SwiftUI

struct AllProjectsCard: View {
    var project: Project
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            //TITLE
            Text(project.title)
                .font(.title2).bold()
                .multilineTextAlignment(.leading)
            
            //TAGS
            ScrollView(.horizontal) {
                HStack {
                    ForEach(project.departments, id: \.self) { department in
                        Text(department)
                            .font(.footnote)
                            .foregroundStyle(Color.white)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 5)
                            .background {
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(TagColor.from(department))
                            }
                    }
                    
                    ForEach(project.topics, id: \.self) { topic in
                        Text(topic)
                            .font(.footnote)
                            .foregroundStyle(Color.white)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 5)
                            .background {
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(TagColor.from(topic))
                            }
                    }
                    
                    if project.hiring {
                        Text("Hiring")
                            .font(.footnote)
                            .foregroundStyle(Color.white)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 5)
                            .background {
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(Color.good)
                            }
                    } else {
                        Text("Not Hiring")
                            .font(.footnote)
                            .foregroundStyle(Color.white)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 5)
                            .background {
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(Color.bad)
                            }
                    }
                }
            }
            
            //PROJECT LEAD
            HStack {
                Image(systemName: "figure.wave")
                Text("Project Lead: ")
                    .bold()
                Text(project.projectLeadName)
            }
        }
        .padding()
        .frame(width: UIScreen.main.bounds.width * 0.9)
        .background {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.surface)
        }
    }
}

#Preview {
    AllProjectsCard(project: Project(id: "", title: "fake title one but longer for testing", departments: ["BIOL", "CMSI"], topics: ["math", "bugs"], projectLeadId: "3", projectLeadName: "Dr Linda Loo", description: "this project is about", team: [], requirements: "", hiring: true, thumbnailURL: "https://snworksceo.imgix.net/ids/673119a2-05dd-4329-a9cc-9cc0f4496267.sized-1000x1000.png?w=1000"))
}
