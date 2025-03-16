//
//  DocumentButton.swift
//  investiGATE
//
//  Created by Raihana Zahra on 3/15/25.
//
// levelup.gitconnected.com/swift-ios-file-import-and-export-choose-destination-folder-filename-and-save-to-files-app-3-ways-240770633fe1

import SwiftUI
import UniformTypeIdentifiers

struct DocumentButton: View {
    var title: String
    
    @State private var showImporter = false
    @State private var importedText: String? = nil

    var body: some View {
        VStack {
            Button(action: {
                showImporter = true
            }) {
                VStack {
                    Text(title)
                        .bold()
                        .foregroundColor(Color.prim)
                }
                .frame(width: 125, height: 125)
                .background(Color.surface)
                .clipShape(RoundedRectangle(cornerRadius: 20))
            }
            
            // Display imported text inside a box
            if let importedText = importedText {
                Text("File Content:\n\(importedText)")
                    .font(.caption)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(RoundedRectangle(cornerRadius: 16).fill(Color.black))
                    .padding(.top, 10)
            }
        }
        .fileImporter(
            isPresented: $showImporter,
            allowedContentTypes: [.text],
            allowsMultipleSelection: false
        ) { result in
            switch result {
            case .success(let urls):
                guard let url = urls.first else { return }
                guard let fileContent = try? String(contentsOf: url, encoding: .utf8) else { return }
                self.importedText = fileContent
                print("Imported text: \(fileContent)")
            case .failure(let error):
                print("Failed with error: \(error.localizedDescription)")
            }
        }
    }
}

#Preview {
    DocumentButton(title: "Resume")
}
