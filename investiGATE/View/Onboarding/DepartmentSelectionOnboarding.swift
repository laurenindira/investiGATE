//
//  DepartmentSelectionOnboarding.swift
//  investiGATE
//
//  Created by Lauren Indira on 3/15/25.
//

import SwiftUI

struct DepartmentSelectionOnboarding: View {
    @Binding var user: User
    @Binding var step: Int
    @Namespace private var animation
    
    //TODO: add more
    let departmentOptions = ["CMSI", "POLS", "CMSD", "MATH", "ENGL", "BIOL", "CHEM"]
    
    //TODO: go back and limit this to just one department
    var body: some View {
        VStack(alignment: .leading) {
            Text("Cool! Now, tell us what departments you work in")
                .font(.headline)
            Text("(It's how we give you relevant research recommendations)")
                .font(.footnote)
            
            //SELECTED SUBJECTS
            ScrollView(.horizontal) {
                HStack(spacing: 12) {
                    ForEach(user.majorDepartment, id: \.self) { department in
                        TagView(tag: department, backColor: Color.prim, textColor: Color.white, icon: "checkmark")
                            .matchedGeometryEffect(id: department, in: animation)
                            .onTapGesture {
                                withAnimation(.snappy) {
                                    user.majorDepartment.removeAll(where: { $0 == department } )
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
                    Text("You gotta pick at least one department!")
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
                    ForEach(departmentOptions.filter { !user.majorDepartment.contains($0) }, id: \.self) { department in
                        TagView(tag: department, backColor: Color.surface, textColor: Color.black, icon: "plus")
                            .matchedGeometryEffect(id: department, in: animation)
                            .onTapGesture {
                                withAnimation(.snappy) {
                                    user.majorDepartment.insert(department, at: 0)
                                }
                            }
                    }
                }
                .padding()
            }
            
            Button {
                if !user.majorDepartment.isEmpty { step += 1 }
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
                    step -= 2
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
    DepartmentSelectionOnboarding(user: .constant(User(id: "", displayName: "", email: "", creationDate: Date(), providerRef: "google", isProfessor: false, researchInterests: [], majorDepartment: [], link: [])), step: .constant(1))
}
