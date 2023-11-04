//
//  ProductsList.swift
//  SalesTracker
//
//  Created by Bernardo Santiago Marin on 04/11/23.
//

import SwiftUI

struct ProductsList: View {
    @ObservedObject var sharedModel: SalesModel
    
    var body: some View {
        NavigationStack {
            ScrollView {
                ForEach(sharedModel.sampleProducts) { product in
                    ProductCard(product: product)
                }
            }
        }
    }
}

struct ProductCard: View {
    let product: Product
    let currencyCode = Locale.current.currency?.identifier ?? "USD"
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .foregroundStyle(product.color.opacity(0.15))
            HStack {
                Text(product.name)
                    .foregroundStyle(product.color)
                    .bold()
                Spacer()
                Text(product.getPrice(), format: .currency(code: self.currencyCode))
            }
            .padding()
        }
    }
}

#Preview {
    ProductsList(sharedModel: SalesModel())
}
