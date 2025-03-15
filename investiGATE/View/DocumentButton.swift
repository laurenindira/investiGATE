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
            
            Text(date)
                .font(.footnote)
                .foregroundColor(.gray)
        }
        .frame(width: 120, height: 80)
        .background(Color.blue.opacity(0.2))
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    DocumentButton(title: "resume", date: "")
}
