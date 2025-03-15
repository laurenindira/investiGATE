//
//  MemberCard.swift
//  investiGATE
//
//  Created by Raihana Zahra on 3/15/25.
//

import SwiftUI

struct MemberCard: View {
    @State var project: Project
    @State var user: User
    
    var body: some View {
        VStack(alignment: .leading) {
            Image(systemName: "person.fill")
                .resizable()
                .frame(width: 70, height: 70)
                .foregroundColor(.gray)
            
            Text("Member Name")
                .font(.caption)
                .bold()
                .foregroundColor(Color.prim)
            
            Text("Major(s)")
                .font(.caption2)
                .foregroundColor(Color.prim)
            }
            
    }
}

#Preview {
    MemberCard(project: <#Project#>, user: <#User#>)
}
