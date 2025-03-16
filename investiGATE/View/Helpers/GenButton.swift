//
//  GenButton.swift
//  investiGATE
//
//  Created by Lauren Indira on 3/15/25.
//

import SwiftUI

struct GenButton: View {
    var placeholder: String
    var backgroundColor: Color
    var foregroundColor: Color
    var imageRight: String?
    var imageLeft: String?
    var isSystemImage: Bool
    
    var body: some View {
        HStack (alignment: .center) {
            if (imageLeft != nil) {
                if isSystemImage {
                    Image(systemName: imageLeft ?? "")
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(foregroundColor)
                        .frame(width: 25)
                        .padding(.trailing, 5)
                } else {
                    Image(imageLeft ?? "")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25)
                        .padding(.trailing, 5)
                }
            }
            
            Text(placeholder)
                .foregroundStyle(foregroundColor)
                .font(.headline)
            
            if (imageRight != nil) {
                if isSystemImage {
                    Image(systemName: imageRight ?? "")
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(foregroundColor)
                        .frame(width: 20)
                        .padding(.leading, 5)
                } else {
                    Image(imageRight ?? "")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25)
                        .padding(.leading, 5)
                }
                
            }
        }
        .padding()
        .frame(maxWidth: UIScreen.main.bounds.width)
        .background {
            RoundedRectangle(cornerRadius: 20)
                .fill(backgroundColor)
        }
    }
}

#Preview {
    GenButton(placeholder: "some text", backgroundColor: Color.prim, foregroundColor: Color.white, imageRight: "xmark", isSystemImage: true)
}
