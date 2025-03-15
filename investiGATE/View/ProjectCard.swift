//
//  ProjectCardView.swift
//  investiGATE
//
//  Created by Raihana Zahra on 3/15/25.
//

import SwiftUI

struct ProjectCardView: View {
    var title: String
    var date: String
    
    var body: some View {
        VStack {
            Rectangle()
                .frame(width: 100, height: 100)
                .cornerRadius(25)
            
            Text(title)
                .font(.footnote)
                .lineLimit(2)
                .frame(width: 100)
            
            Text(date)
                .font(.footnote)
                .lineLimit(2)
        }
        .padding(5)
    }
}

#Preview {
    ProjectCardView(title: "in2eat", date: "11/2")
}
