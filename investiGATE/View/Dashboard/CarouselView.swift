//
//  CarouselView.swift
//  investiGATE
//
//  Created by Lauren Indira on 3/15/25.
//

import SwiftUI
import SwiftUIInfiniteCarousel

struct CarouselView: View {
    @EnvironmentObject var auth: AuthViewModel
    var featuredProjects: [Project]
    
    var body: some View {
        InfiniteCarousel(data: featuredProjects, secondsDisplayingBanner: 3, height: 300, horizontalPadding: 0, cornerRadius: 20, transition: .scale) { project in
            //TODO: need to add image compatability
            VStack(alignment: .leading) {
                Spacer()
                
                Text(project.title)
                    .font(.title2).bold()
                    .foregroundStyle(Color.white)
                
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(project.departments, id: \.self) { department in
                            Text(department)
                                .font(.callout)
                                .foregroundStyle(Color.white)
                                .padding(10)
                                .background {
                                    RoundedRectangle(cornerRadius: 20)
                                        .fill(TagColor.from(department))
                                }
                        }
                    }
                }
                .frame(maxWidth: UIScreen.main.bounds.width)
            }
            .padding()
            .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: 250)
            .background {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.sec)
            }
        }
    }
}


#Preview {
    CarouselView(featuredProjects: [
        Project(id: "", title: "fake title one", departments: ["BIOL", "CMSI"], topics: ["math", "bugs"], projectLead: "Dr. Linda Loo", description: "this project is about", team: [], requirements: "", hiring: true),
        Project(id: "", title: "fake title two", departments: ["BIOL", "CMSI"], topics: ["math", "bugs"], projectLead: "Dr. Linda Loo", description: "this project is about", team: [], requirements: "", hiring: true),
        Project(id: "", title: "fake title three", departments: ["BIOL", "CMSI"], topics: ["math", "bugs"], projectLead: "Dr. Linda Loo", description: "this project is about", team: [], requirements: "", hiring: true)
    ])
        .environment(AuthViewModel())
}
