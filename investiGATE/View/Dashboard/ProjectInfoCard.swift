//
//  ProjectInfoCard.swift
//  investiGATE
//
//  Created by Lauren Indira on 3/15/25.
//

import SwiftUI

struct ProjectInfoCard: View {
    var project: Project
    
    var body: some View {
        VStack(alignment: .leading) {
            //IMAGE
            if (project.thumbnailURL != nil) && (project.thumbnailURL != "") {
                AsyncImage(url: URL(string: project.thumbnailURL!)) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .frame(width: UIScreen.main.bounds.width * 0.3, height: UIScreen.main.bounds.width * 0.3)
                
            } else {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.sec)
                    .frame(width: UIScreen.main.bounds.width * 0.3, height: UIScreen.main.bounds.width * 0.3)
            }
            
            //TITLE
            Text(project.title)
                .font(.headline).bold()
                .lineLimit(3)
                .multilineTextAlignment(.leading)
            
            //DEPARTMENTS
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
            }
        }
        .frame(width: UIScreen.main.bounds.width * 0.3)
    }
}

#Preview {
    ProjectInfoCard(project: Project(id: "", title: "fake title one but longer for testing", departments: ["BIOL", "CMSI"], topics: ["math", "bugs"], projectLead: "Dr. Linda Loo", projectDescription: "this project is about", team: [], requirements: "", hiring: true))
}
