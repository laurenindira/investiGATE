//
//  ProjectCreationView.swift
//  investiGATE
//
//  Created by Lauren Indira on 3/15/25.
//

import SwiftUI

struct ProjectCreationView: View {
    @EnvironmentObject var auth: AuthViewModel
    @EnvironmentObject var projectsService: Projects
    @State var title: String = ""
    @State var departmentText: String = ""
    @State var topicText: String = ""
    @State var description: String = ""
    @State var requirements: String = "" // requirements for someone to join research team
    @State var hiring: Bool = true
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    VStack(spacing: 10) {
                        //TITLE
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Enter the project title")
                                .font(.headline).bold()
                                .foregroundStyle(Color.prim)
                            GenTextField(placeholder: "eg. Shakespeare's Impact on Modern Society", text: $title, linelimit: 3)
                        }
                        
                        //DEPARTMENTS
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Enter the associated departments (comma-separated)").font(.headline).bold()
                                .foregroundStyle(Color.prim)
                            GenTextField(placeholder: "eg. CMSI, POLS", text: $departmentText)
                        }
                        
                        //TAGS
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Enter any associated project topics (comma-separated)")
                                .font(.headline).bold()
                                .foregroundStyle(Color.prim)
                            
                            GenTextField(placeholder: "eg. artificial intelligence, iOS development", text: $topicText, linelimit: 2)
                        }
                        
                        Toggle(isOn: $hiring) {
                            Text("Is the project currently hiring?")
                        }
                    }
                    
                    Divider()
                    
                    //DESCRIPTION
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Project Description or Abstract")
                            .font(.headline)
                        GenTextField(placeholder: "eg. This project aims to investigate the enduring relevance of William Shakespeare’s works in contemporary society, with a specific emphasis on how his plays continue to influence modern pop culture, education, and social discourse. ", text: $description, linelimit: 5)
                    }
                    
                    //REQUIREMENTS
                    VStack(alignment: .leading, spacing: 5) {
                        Text("What we're looking for")
                            .font(.headline)
                        GenTextField(placeholder: "eg. motivated students, skilled in literary analysis", text: $requirements, linelimit: 5)
                    }
                    
                    Button {
                        createProject()
                        //addingProject = false
                    } label: {
                        GenButton(placeholder: "add project", backgroundColor: Color.prim, foregroundColor: Color.white, isSystemImage: false)
                    } .disabled(title.isEmpty || departmentText.isEmpty || topicText.isEmpty || description.isEmpty || requirements.isEmpty)
                }
                .padding()
            }
            .navigationTitle("Add a Project")
            
        }
    }
    
    func createProject() {
        let departmentList = departmentText.split(separator: ",").map { $0.trimmingCharacters(in: .whitespaces)}
        let topicList = topicText.split(separator: ",").map { $0.trimmingCharacters(in: .whitespaces) }
        
        Task {
            do {
                try await projectsService.createProject(title: title, departments: departmentList, topics: topicList, description: description, team: [""], requirements: requirements, hiring: hiring, thumbnailURL: nil)
                
                resetFields()
            } catch {
                print("Error in creating project")
            }
        }
    }
    
    func resetFields() {
        title = ""
        departmentText = ""
        topicText = ""
        description = ""
        requirements = ""
        hiring = true
    }
}

#Preview {
    ProjectCreationView(title: "", departmentText: "", topicText: "", description: "", requirements: "", hiring: true)
        .environmentObject(Projects())
}
