//
//  Tag.swift
//  investiGATE
//
//  Created by Cecilia Zaragoza on 3/15/25.
//

import SwiftUI

struct Tag: View {
    let keyword: String
    var body: some View {
        Text(keyword)
            .font(.caption)
            .foregroundColor(.white)
            .padding(7)
            .background(TagColor.from(keyword), in: Capsule())
    }
}


struct Tag_Previews: PreviewProvider {
    static let keywords = ["CMSI", "BIOL", "MATH", "PHYS", "CHEM", "UNKNOWN", "HIRING", "ONGOING", "CONCLUDED", "NOT HIRING"]
    static var previews: some View {
        VStack {
            ForEach(keywords, id: \.self) { word in
                Tag(keyword: word)
            }
        }
    }
}
