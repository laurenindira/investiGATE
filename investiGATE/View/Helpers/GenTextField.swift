//
//  GenTextFields.swift
//  investiGATE
//
//  Created by Lauren Indira on 3/15/25.
//

import SwiftUI

struct GenTextField: View {
    var placeholder: String
    @Binding var text: String
    var linelimit: Int?
    
    var body: some View {
        TextField(placeholder, text: $text, axis: .vertical)
            .autocorrectionDisabled()
            .textInputAutocapitalization(.never)
            .padding()
            .foregroundStyle(Color.secondaryText)
            .lineLimit((linelimit != nil ? linelimit : 1) ?? 1 , reservesSpace: true)
            .background {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.surface)
                    .stroke(Color.secondaryText.opacity(0.25), style: StrokeStyle(lineWidth: 0.5))
            }
    }
}
    
#Preview {
    GenTextField(placeholder: "test", text: .constant("THIS IS SOME TEXT"))
}
