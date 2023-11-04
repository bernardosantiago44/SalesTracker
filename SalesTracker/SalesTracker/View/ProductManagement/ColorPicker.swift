//
//  IconPicker.swift
//  SalesTracker
//
//  Created by Bernardo Santiago Marin on 02/11/23.
//

import SwiftUI

struct ColorPicker: View {
    @Binding var selectedColor: Color
    @Environment(\.dynamicTypeSize) var typeSize
    
    let colors: [Color] = [.red, .orange, .yellow, .green, .mint, .teal, .blue, .purple, .pink, .brown]
    var columns: [GridItem] {
        if typeSize < .accessibility1 {
            return [.init(.adaptive(minimum: 40))]
        }
        return [.init(.adaptive(minimum: 55))]
    }
    
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
                .onTapGesture {
                    self.selectedColor = color
                }
            }
        }
    }
}

#Preview {
    ColorPicker(selectedColor: .constant(.green))
}
