//
//  ProductsList.swift
//  SalesTracker
//
//  Created by Bernardo Santiago Marin on 04/11/23.
//

import SwiftUI

struct ProductsList: View {
    @Environment(\.dynamicTypeSize) var dynamicTypeSize
    @State private var showNewProductSheet = false
    @ObservedObject var salesModel: SalesModel
    
    var columns: [GridItem] {
        if dynamicTypeSize > .xLarge {
            return [.init(.flexible())]
        }
        return .init(repeating: .init(.flexible()), count: 2)
    }
    var products: [String : [Product]] {
        Dictionary(grouping: self.salesModel.sampleProducts, by: \.category)
    }
    
    var body: some View {
        ScrollView {
            // TODO: Separate products into categories.
            LazyVGrid(columns: self.columns) {
                ForEach(salesModel.Products) { product in
                    ProductCard(dynamicTypeSize: self.dynamicTypeSize, product: product)
                }
            }
            .padding(.horizontal)
        }
        .navigationTitle("Products")
        .toolbar(content: {
            Button("createNewProduct", systemImage: "plus.circle.fill") {
                self.showNewProductSheet.toggle()
            }
        })
        .sheet(isPresented: self.$showNewProductSheet, content: {
            NewProductView(salesModel: self.salesModel)
        })
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
    NavigationStack {
        ProductsList(salesModel: SalesModel())
    }
}
