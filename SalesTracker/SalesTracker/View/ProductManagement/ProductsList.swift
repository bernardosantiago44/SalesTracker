//
//  ProductsList.swift
//  SalesTracker
//
//  Created by Bernardo Santiago Marin on 04/11/23.
//

import SwiftUI

struct ProductsList: View {
    @ObservedObject var sharedModel: SalesModel
    @Environment(\.dynamicTypeSize) var dynamicTypeSize
    var columns: [GridItem] {
        if dynamicTypeSize > .xLarge {
            return [.init(.flexible())]
        }
        return .init(repeating: .init(.flexible()), count: 2)
    }
    var products: [String : [Product]] {
        Dictionary(grouping: self.sharedModel.sampleProducts, by: \.category)
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: self.columns) {
                    ForEach(sharedModel.sampleProducts) { product in
                        ProductCard(dynamicTypeSize: self.dynamicTypeSize, product: product)
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

struct ProductCard: View {
    let dynamicTypeSize: DynamicTypeSize
    let product: Product
    let currencyCode = Locale.current.currency?.identifier ?? "USD"
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .foregroundStyle(product.color.opacity(0.15))
            if self.dynamicTypeSize >= .large {
                VStack {
                    Text(product.name)
                        .foregroundStyle(product.color)
                        .bold()
                        .lineLimit(3)
                        .accessibilityLabel(product.name)
                    Spacer()
                    Text(product.getPrice(), format: .currency(code: self.currencyCode))
                }
                .padding(.vertical)
            } else {
                HStack {
                    Text(product.name)
                        .foregroundStyle(product.color)
                        .bold()
                        .lineLimit(3)
                        .accessibilityLabel(product.name)
                    Spacer()
                    Text(product.getPrice(), format: .currency(code: self.currencyCode))
                }
                .padding()
            }
        }
    }
}

#Preview {
    ProductsList(sharedModel: SalesModel())
}
