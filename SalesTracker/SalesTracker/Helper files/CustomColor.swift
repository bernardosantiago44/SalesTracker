//
//  CustomColor.swift
//  SalesTracker
//
//  Created by Bernardo Santiago Marin on 04/01/24.
//

import Foundation
import SwiftUI

enum CustomColor: String {
    case red = "red"
    case orange = "orange"
    case yellow = "yellow"
    case green = "green"
    case teal = "teal"
    case cyan = "cyan"
    case blue = "blue"
    case purple = "purple"
    case pink = "pink"
    case brown = "brown"
    
    var color: Color {
        switch self {
        case .red:
            return .red
        case .orange:
            return .orange
        case .yellow:
            return .yellow
        case .green:
            return .green
        case .teal:
            return .teal
        case .cyan:
            return .cyan
        case .blue:
            return .blue
        case .purple:
            return .purple
        case .pink:
            return .pink
        case .brown:
            return .brown
        }
    }
}
