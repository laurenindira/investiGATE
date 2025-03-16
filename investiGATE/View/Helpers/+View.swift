//
//  +View.swift
//  investiGATE
//
//  Created by Lauren Indira on 3/15/25.
//

import Foundation
import SwiftUI

extension View {
    func getRootViewController() -> UIViewController {
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .init()
        }

        guard let root = screen.windows.first?.rootViewController else {
            return .init()
        }
            
        return root
    }
}
