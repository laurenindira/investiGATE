//
//  ProfileView.swift
//  investiGATE
//
//  Created by Raihana Zahra on 3/15/25.
//

import SwiftUI

import SwiftUI

import SwiftUI

struct ProfileView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                
                // Profile Header
                HStack {
                    Image("profile pic")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 80, height: 80)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.gray, lineWidth: 2))
                    
                    VStack(alignment: .leading) {
                        Text("Sam Charger")
                            .font(.title)
                            .bold()
                        
                        Text("junior cs + english major")
                            .foregroundColor(.blue)
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        // TODO: settings page
                    }) {
                        Image(systemName: "gearshape.fill")
                            .font(.title2)
                            .foregroundColor(.gray)
                    }
                }
                .padding(.horizontal)
                
                // Research Interests
                Text("Research Interests")
                    .font(.headline)
                    .padding(.horizontal)
                
                // Current Projects
                Text("Current Projects")
                    .font(.headline)
                    .padding(.horizontal)
                
                ProjectCardView(title: "title", date: "date")
                
                // Past Projects
                Text("Past Projects")
                    .font(.headline)
                    .padding(.horizontal)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ProjectCardView(title: "title", date: "date")
                    }
                    .padding(.horizontal)
                }
                
                // Saved Projects
                VStack(alignment: .leading, spacing: 5) {
                    Text("Saved Projects")
                        .font(.headline)
                    Text("Looks like you don’t have any projects saved!")
                        .foregroundColor(.gray)
                }
                .padding(.horizontal)
                
                // My Documents
                Text("My Documents")
                    .font(.headline)
                    .padding(.horizontal)
                
                HStack {
                    DocumentButton(title: "Resume")
                    DocumentButton(title: "Portfolio")
                }
                .padding(.horizontal)
                
                Spacer()
            }
            .padding(.top, 20)
        }
    }
}


#Preview {
    ProfileView()
}
