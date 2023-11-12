//
//  RoundedGroupTextFieldStyle.swift
//  SalesTracker
//
//  Created by Bernardo Santiago Marin on 11/11/23.
//

import SwiftUI

struct RoundedGroupTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(5)
            .background(Color(uiColor: .secondarySystemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 15))
    }
}
