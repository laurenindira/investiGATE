//
//  File.swift
//  investiGATE
//
//  Created by Cecilia Zaragoza on 3/15/25.
//

import SwiftUI

enum TagColor {
    case CMSI, BIOL, MATH, PHYS, CHEM, ONGOING, HIRING, CONCLUDED, NOTHIRING

    var color: Color {
        switch self {
        case .CMSI: return .blue
        case .BIOL: return .teal
        case .MATH: return .purple
        case .PHYS: return .orange
        case .CHEM: return .pink
        case .ONGOING: return .green
        case .HIRING: return .green
        case .CONCLUDED: return .red
        case .NOTHIRING: return .red
        }
    }
    
    static func from(_ major: String) -> Color {
        switch major.uppercased() {
        case "CMSI": return TagColor.CMSI.color
        case "BIOL": return TagColor.BIOL.color
        case "MATH": return TagColor.MATH.color
        case "PHYS": return TagColor.PHYS.color
        case "CHEM": return TagColor.CHEM.color
        case "ONGOING": return TagColor.ONGOING.color
        case "HIRING": return TagColor.HIRING.color
        case "CONCLUDED": return TagColor.CONCLUDED.color
        case "NOT HIRING": return TagColor.NOTHIRING.color
        default: return .gray // Default color for unknown majors
        }
    }
}
