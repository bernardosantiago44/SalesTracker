//
//  ProductDetailView.swift
//  SalesTracker
//
//  Created by Bernardo Santiago Marin on 06/11/23.
//

import SwiftUI

struct ProductDetailView: View {
    @Environment(\.dynamicTypeSize) var dynamicTypeSize
    let product: Product
    let currencyCode = Locale.current.currency?.identifier ?? "usd"
    var columns: [GridItem] {
        if self.dynamicTypeSize < .xxLarge {
            return .init(repeating: .init(.flexible()), count: 2)
        }
        return .init(repeating: .init(.flexible()), count: 1)
    }
    
    var body: some View {
        ScrollView {
            VStack {
                #warning("Finish this UI")
                /* FIXME: Adapt this to dynamic type sizes.
                 *        Perhaps reorganize this UI.
                 */
                RatingVisualizer(rating: self.product.rating)
                LazyVGrid(columns: self.columns) {
                    productPriceCard
                    
                    categoryCard
                }
                
                Divider()
                Text("active discounts")
                    .font(.headline)
                    .foregroundStyle(.secondary)
                Text("you don't have any active discounts at the moment.")
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal)
        }
        .navigationTitle(product.name)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    var productPriceCard: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color(uiColor: .secondarySystemBackground))
            VStack {
                Text(product.getPrice(), format: .currency(code: self.currencyCode))
                    .font(.title3)
                Text("sales today: 15")
            }
            .padding()
        }
    }
    
    var categoryCard: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color(uiColor: .secondarySystemBackground))
            VStack {
                Text("Category")
                    .font(.title3)
                Text(product.category)
            }
            .padding()
        }
    }
}

#Preview {
    NavigationStack {
        ProductDetailView(product: SalesModel().sampleProducts[0])
    }
}
