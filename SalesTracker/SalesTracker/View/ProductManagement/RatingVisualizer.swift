//
//  RatingPicker.swift
//  SalesTracker
//
//  Created by Bernardo Santiago Marin on 06/11/23.
//

import SwiftUI

struct RatingVisualizer: View {
    let rating: Float
    let starIcon = "star"
    let halfStarIcon = "star.leadinghalf.filled"
    
    var wholePart: UInt8 {
        // Rating expressed in terms of half stars
        // 3.7 stars -> 3 whole stars
        //
        return UInt8((rating * 2).rounded()) / 2
    }
    var decimal: Bool {
        // Determines whether the provided value
        // requires a half star to be represented.
        // 3.8 -> 3 whole stars + 1 half star
        return (rating * 2).rounded().truncatingRemainder(dividingBy: 2) == 1
    }
    
    var empty: UInt8 {
        return decimal ? 4 - wholePart : 5 - wholePart
    }
    
    var body: some View {
        
        HStack {
            Text(rating, format: .number)
                .font(.title3)
            ForEach(1...self.wholePart, id: \.self) { pos in
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
            if empty >= 1 {
                ForEach(1...empty, id: \.self) { pos in
                    Image(systemName: starIcon)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundStyle(.yellow)
                        .frame(width: 40)
                }
            }
        }
        
    }
}

#Preview {
    RatingVisualizer(rating: 2.24)
}
