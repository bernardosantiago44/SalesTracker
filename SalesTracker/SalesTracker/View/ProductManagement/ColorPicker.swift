//
//  IconPicker.swift
//  SalesTracker
//
//  Created by Bernardo Santiago Marin on 02/11/23.
//

import SwiftUI

struct ColorPicker: View {
    @Binding var selectedColor: Color
    let colors: [Color] = [.red, .orange, .yellow, .green]
    let columns: [GridItem] = [.init(.adaptive(minimum: 40))]
    
    var body: some View {
        LazyVGrid(columns: self.columns) {
            ForEach(colors, id: \.self) { color in
                ZStack {
                    Circle()
                        .foregroundStyle(color)
                    if self.selectedColor == color {
                        Circle()
                            .strokeBorder(Color.primary.opacity(0.5), lineWidth: 4)
                    }
                }
            }
        }
    }
}

#Preview {
    ColorPicker(selectedColor: .constant(.green))
}
