//
//  String.swift
//  SalesTracker
//
//  Created by Bernardo Santiago Marin on 05/01/24.
//

import Foundation

extension String {
    var tidy: String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines).folding(options: [.caseInsensitive, .diacriticInsensitive], locale: nil).lowercased()
    }
}
