//
//  MajorSelectionOnboarding.swift
//  investiGATE
//
//  Created by Lauren Indira on 3/15/25.
//

import SwiftUI

struct MajorSelectionOnboarding: View {
    @Binding var user: User
    @Binding var step: Int
    @Namespace private var animation
    
    //TODO: add more
    let majorOptions = ["CMSI", "POLS", "CMSD", "MATH", "ENGL", "BIOL", "CHEM"]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Cool! Now, tell us what your majors are!")
                .font(.headline)
            Text("(It's how we give you relevant research recommendations)")
                .font(.footnote)
            
            //SELECTED SUBJECTS
            ScrollView(.horizontal) {
                HStack(spacing: 12) {
                    ForEach(user.majorDepartment, id: \.self) { major in
                        TagView(tag: major, backColor: Color.prim, textColor: Color.white, icon: "checkmark")
                            .matchedGeometryEffect(id: major, in: animation)
                            .onTapGesture {
                                withAnimation(.snappy) {
                                    user.majorDepartment.removeAll(where: { $0 == major } )
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
                if user.majorDepartment.isEmpty {
                    Text("You gotta pick at least one major!")
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
                    ForEach(majorOptions.filter { !user.majorDepartment.contains($0) }, id: \.self) { major in
                        TagView(tag: major, backColor: Color.surface, textColor: Color.black, icon: "plus")
                            .matchedGeometryEffect(id: major, in: animation)
                            .onTapGesture {
                                withAnimation(.snappy) {
                                    user.majorDepartment.insert(major, at: 0)
                                }
                            }
                    }
                }
                .padding()
            }
            
            Button {
                if !user.majorDepartment.isEmpty { step += 2 }
            } label: {
                GenButton(placeholder: "Next", backgroundColor: Color.prim, foregroundColor: Color.white, imageRight: "arrow.right", isSystemImage: true)
            }
            .disabled(user.majorDepartment.count < 1)
            .opacity(user.majorDepartment.count < 1 ? 0.5 : 1)
            .padding(.top, 20)
        }
        .padding()
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button() {
                    step -= 1
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
    MajorSelectionOnboarding(user: .constant(User(id: "", displayName: "", email: "", creationDate: Date(), providerRef: "google", isProfessor: false, researchInterests: [], majorDepartment: [], link: [])), step: .constant(1))
}
