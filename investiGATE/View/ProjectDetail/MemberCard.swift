//
//  MemberCard.swift
//  investiGATE
//
//  Created by Raihana Zahra on 3/15/25.
//

import SwiftUI

struct MemberCard: View {
    @State var user: User
    
    var body: some View {
        VStack(alignment: .leading) {
            if let profileURL = user.profilePicture, let url = URL(string: profileURL) {
                AsyncImage(url: url) { image in
                    image.resizable()
                        .scaledToFill()
                } placeholder: {
                    Image(systemName: "person.fill")
                        .resizable()
                        .foregroundColor(.gray)
                }
                .frame(width: 70, height: 70)
                .clipShape(Circle())
            } else {
                Image(systemName: "person.fill")
                    .resizable()
                    .frame(width: 70, height: 70)
                    .foregroundColor(.gray)
            }
            
            Text(user.displayName)
                .font(.caption)
                .bold()
                .foregroundColor(Color.prim)
            
            Text(user.majorDepartment.joined(separator: ", "))
                .font(.caption2)
                .foregroundColor(Color.prim)
            }

    }
}

let sampleUsers = User(
    id: "123",
    displayName: "Alice Johnson",
    email: "alice@email.com",
    creationDate: Date(),
    providerRef: "google",
    isProfessor: false,
    researchInterests: ["AI", "Bioinformatics"],
    majorDepartment: ["CMSI", "BIOL"],
    bio: "Bioinformatics enthusiast.",
    profilePicture: nil,
    gradDate: nil,
    currentYear: "Senior",
    link: []
)

#Preview {
    MemberCard(user: sampleUsers)
}
