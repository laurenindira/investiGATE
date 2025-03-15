//
//  ResearchInterestsOnboarding.swift
//  investiGATE
//
//  Created by Lauren Indira on 3/15/25.
//

import SwiftUI

struct ResearchInterestsOnboarding: View {
    @Binding var user: User
    @Binding var step: Int
    @Namespace private var animation
    
    //TODO: add more
    let researchOptions = ["artifical intelligence", "bananas", "None of these actually..."]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Alright! So what are your research interests")
                .font(.headline)
            
            //SELECTED SUBJECTS
            ScrollView(.horizontal) {
                HStack(spacing: 12) {
                    ForEach(user.researchInterests, id: \.self) { interest in
                        TagView(tag: interest, backColor: Color.prim, textColor: Color.white, icon: "checkmark")
                            .matchedGeometryEffect(id: interest, in: animation)
                            .onTapGesture {
                                withAnimation(.snappy) {
                                    user.researchInterests.removeAll(where: { $0 == interest } )
                                }
                            }
                    }
                }
                .padding(.horizontal, 20)
                .padding()
            }
            .scrollClipDisabled(true)
            .scrollIndicators(.hidden)
            .padding(.top, 20)
            .overlay(content: {
                if user.researchInterests.isEmpty {
                    Text("C'mon, we know you have interests")
                        .font(.callout)
                        .padding(10)
                        .background {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.prim.opacity(0.25))
                                .stroke(Color.prim, style: StrokeStyle(lineWidth: 2))
                        }
                }
            })
            
            //TAG LIST
            VStack {
                TagLayout(alignment: .center, spacing: 10) {
                    ForEach(researchOptions.filter { !user.researchInterests.contains($0) }, id: \.self) { interest in
                        TagView(tag: interest, backColor: Color.surface, textColor: Color.black, icon: "plus")
                            .matchedGeometryEffect(id: interest, in: animation)
                            .onTapGesture {
                                withAnimation(.snappy) {
                                    user.researchInterests.insert(interest, at: 0)
                                }
                            }
                    }
                }
                .padding()
            }
            
            if user.isProfessor {
                NavigationLink {
                    SignUpView(tempUser: user)
                } label: {
                    GenButton(placeholder: "Finish!", backgroundColor: Color.prim, foregroundColor: Color.white, imageRight: "arrow.right", isSystemImage: true)
                }
                .disabled(user.researchInterests.count < 1)
                .opacity(user.researchInterests.count < 1 ? 0.5 : 1)
                .padding(.top, 20)
            } else {
                Button {
                    if !user.researchInterests.isEmpty { step += 1 }
                } label: {
                    GenButton(placeholder: "Next", backgroundColor: Color.prim, foregroundColor: Color.white, imageRight: "arrow.right", isSystemImage: true)
                }
                .disabled(user.researchInterests.count < 1)
                .opacity(user.researchInterests.count < 1 ? 0.5 : 1)
                .padding(.top, 20)
            }
        }
        .padding()
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button() {
                    if user.isProfessor {
                        step -= 1
                    } else {
                        step -= 2
                    }
                } label: {
                    HStack {
                        Image(systemName: "chevron.left")
                            .font(.body)
                        Text("Back")
                    }
                    .foregroundStyle(Color.prim)
                }
            }
        }
    }
    
    @ViewBuilder
    func TagView(tag: String, backColor: Color, textColor: Color, icon: String) -> some View {
        HStack(spacing: 5) {
            Text(tag)
                .font(.callout)
            Image(systemName: icon)
        }
        .foregroundStyle(textColor)
        .padding(.vertical, 5)
        .padding(.horizontal, 10)
        .background {
            RoundedRectangle(cornerRadius: 10)
                .fill(backColor)
        }
    }
}

#Preview {
    ResearchInterestsOnboarding(user: .constant(User(id: "", displayName: "", email: "", creationDate: Date(), providerRef: "google", isProfessor: false, researchInterests: [], majorDepartment: [], link: [])), step: .constant(1))
}
