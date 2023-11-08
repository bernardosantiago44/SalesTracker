//
//  ProductDetailView.swift
//  SalesTracker
//
//  Created by Bernardo Santiago Marin on 06/11/23.
//

import SwiftUI

struct ProductDetailView: View {
    let product: Product
    let currencyCode = Locale.current.currency?.identifier ?? "usd"
    let columns: [GridItem] = .init(repeating: .init(.flexible()), count: 2)
    
    var body: some View {
        ScrollView {
            VStack {
                #warning("Finish this UI")
                /* FIXME: Adapt this to dynamic type sizes.
                 *        Perhaps reorganize this UI.
                 */
                RatingVisualizer(rating: self.product.rating)
                HStack {
                    GroupBox {
                        Text(product.getPrice(), format: .currency(code: self.currencyCode))
                            .font(.title3)
                        Text("sales today: 15")
                    }
                    
                    GroupBox {
                        Text("category")
                        Text(product.category)
                    }
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
}

#Preview {
    NavigationStack {
        ProductDetailView(product: SalesModel().sampleProducts[0])
    }
}
