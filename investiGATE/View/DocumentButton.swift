//
//  DocumentButton.swift
//  investiGATE
//
//  Created by Raihana Zahra on 3/15/25.
//

import SwiftUI

struct DocumentButton: View {
    var title: String
    var date: String
    
    var body: some View {
        VStack {
            Text(title)
                .bold()
                .foregroundColor(Color.darkblue)
            
            Text(date)
                .font(.footnote)
                .foregroundColor(.gray)
        }
        .frame(width: 125, height: 125)
        .background(Color.document)
        .clipShape(RoundedRectangle(cornerRadius: 25))
    }
}

#Preview {
    DocumentButton(title: "resume", date: "")
}
