//
//  RatingPicker.swift
//  SalesTracker
//
//  Created by Bernardo Santiago Marin on 06/11/23.
//

import SwiftUI

struct RatingPicker: View {
    @Binding var rating: Float
    let starIcon = "star"
    let halfStarIcon = "star.leadinghalf.filled"
    
    var wholePart: UInt8 {
        return UInt8((rating * 2).rounded())
    }
    var decimal: Bool {
        return (rating * 2).rounded().truncatingRemainder(dividingBy: 2) == 1
    }
    
    var body: some View {
        VStack {
            Text(rating, format: .number)
            
            HStack {
                ForEach(1...self.wholePart / 2, id: \.self) { pos in
                    Image(systemName: starIcon)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .symbolVariant(.fill)
                        .foregroundStyle(.yellow)
                        .frame(width: 40)
                }
                if decimal {
                    Image(systemName: halfStarIcon)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundStyle(.yellow)
                        .frame(width: 40)
                }
            }
            Slider(value: $rating, in: 0...5)
                .padding(.horizontal)
            
        }
    }
}

#Preview {
    RatingPicker(rating: .constant(3.25))
}
