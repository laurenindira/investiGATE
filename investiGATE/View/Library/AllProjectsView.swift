//
//  AllProjectsView.swift
//  investiGATE
//
//  Created by Lauren Indira on 3/15/25.
//

import SwiftUI

struct AllProjectsView: View {
    @EnvironmentObject var auth: AuthViewModel
    @EnvironmentObject var projectsVM: Projects
    
    @State var searchText: String = ""
    @State var allProjects: [Project] = []
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {
                    //SEARCH
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .font(.callout)
                            .foregroundStyle(Color.secondaryText)
                        
                        TextField("Looking for something specific?", text: $searchText)
                            .foregroundStyle(Color.secondaryText)
                        
                        if !searchText.isEmpty {
                            Button(action: { self.searchText = "" }) {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundStyle(Color.secondaryText)
                            }
                        }
                    }
                    .padding(10)
                    .frame(width: UIScreen.main.bounds.width * 0.9)
                    .background {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.surface)
                    }
                    
                    //ALL CARDS
                    if searchResults.isEmpty {
                        
                    } else {
                        ForEach(searchResults, id: \.self) { project in
                            NavigationLink {
                                ProjectDetail(project: project)
                            } label: {
                                AllProjectsCard(project: project)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
                .padding()
            }
            .animation(.easeInOut, value: searchResults)
            .navigationTitle("All Projects")
            .onAppear {
                Task {
                    fetchProjects()
                }
            }
            .refreshable {
                await refresh()
            }
        }
    }
    
    var searchResults: [Project] {
        if searchText.isEmpty {
            return allProjects
        } else {
            return allProjects.filter { $0.title.localizedCaseInsensitiveContains(searchText) || $0.description.localizedCaseInsensitiveContains(searchText) || $0.projectLeadName.localizedCaseInsensitiveContains(searchText)}
        }
    }
    
    func fetchProjects() {
        Task {
            do {
                allProjects = try await projectsVM.fetchAllProjects()
            } catch {
                print("ERROR: FETCHING DIDNT WORK")
            }
        }
    }
    
    private func refresh() async {
        fetchProjects()
    }
}

#Preview {
    AllProjectsView()
        .environmentObject(AuthViewModel())
        .environmentObject(Projects())
}
