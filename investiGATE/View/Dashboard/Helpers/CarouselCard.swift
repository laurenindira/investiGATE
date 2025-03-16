//
//  CarouselCard.swift
//  investiGATE
//
//  Created by Lauren Indira on 3/15/25.
//

import SwiftUI

struct CarouselCard: View {
    var project: Project
    
    var body: some View {
        ZStack{
            //PHOTO
            if project.thumbnailImage != nil {
                AsyncImage(url: URL(string: project.thumbnailImage!)) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .overlay(
                                LinearGradient(colors: [.clear, Color.prim], startPoint: .center, endPoint: .bottom)
                                    .clipShape(RoundedRectangle(cornerRadius: 20))
                            )
                            .frame(width: UIScreen.main.bounds.width, height: 250)
                            .scrollTransition(.animated, axis: .horizontal) { content, phase in
                                content
                                    .opacity(phase.isIdentity ? 1.0 : 0.8)
                                    .scaleEffect(phase.isIdentity ? 1.0 : 0.8)
                            }
                    case .failure:
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.sec)
                            .frame(width: UIScreen.main.bounds.width, height: 250)
                            .background(Color.gray.opacity(0.3))
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .foregroundColor(.white)
                        
                    case .empty:
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.sec)
                            .frame(width: UIScreen.main.bounds.width, height: 250)
                            .background(Color.gray.opacity(0.3))
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .foregroundColor(.white)
                        
                    @unknown default:
                        EmptyView()
                    }
                }
            } else {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.sec)
                    .frame(width: UIScreen.main.bounds.width, height: 250)
                    .background(Color.gray.opacity(0.3))
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .foregroundColor(.white)
            }
            
            //TEXT
            VStack (alignment: .leading) {
                Spacer()
                Text(project.title)
                    .font(.title2).bold()
                    .foregroundStyle(Color.white)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(project.departments, id: \.self) { department in
                            Text(department)
                                .font(.callout)
                                .padding(10)
                                .background {
                                    RoundedRectangle(cornerRadius: 20)
                                        .fill(TagColor.from(department))
                                }
                        }
                    }
                    
                }
            }
            .frame(maxWidth: UIScreen.main.bounds.width * 0.9)
            .padding()
        }
        .padding()
        .frame(maxHeight: 200)
    }
}

#Preview {
    CarouselCard(project: Project(id: "", title: "fake title one", departments: ["BIOL", "CMSI"], topics: ["math", "bugs"], projectLead: "Dr. Linda Loo", description: "this project is about", team: [], requirements: "", hiring: true))
}
