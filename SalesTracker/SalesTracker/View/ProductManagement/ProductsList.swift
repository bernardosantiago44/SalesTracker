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
    @State private var presentedProducts = [Product]()
    @ObservedObject var salesModel: SalesModel
    
    var columns: [GridItem] {
        // If font size is too large,
        // display items vertically.
        // Otherwise, display a 2 x n grid.
        //
        if dynamicTypeSize > .xLarge {
            return [.init(.flexible())]
        }
        return .init(repeating: .init(.flexible()), count: 2)
    }
    
    var body: some View {
        ScrollView {
            // TODO: Separate products into categories.
            LazyVGrid(columns: self.columns) {
                ForEach(salesModel.sampleProducts) { product in
                    NavigationLink(value: product) {
                        ProductCard(dynamicTypeSize: self.dynamicTypeSize, product: product)
                            .tint(.primary)
                    }
                }
            }
            .padding(.horizontal)
        }
        .toolbar(content: {
            ToolbarItem(placement: .primaryAction) {
                Button("createNewProduct", systemImage: "plus.circle.fill") {
                    self.showNewProductSheet.toggle()
                }
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
            
            // Dynamic type sizes too large shoud
            // display data in a vertical layout.
            //
            if self.dynamicTypeSize >= .large {
                VStack {
                    Text(product.name)
                        .foregroundStyle(product.color)
                        .bold()
                        .lineLimit(3)
                        .accessibilityLabel(product.name)
                    Text(product.getPrice(), format: .currency(code: self.currencyCode))
                }
                .padding(.vertical, 12)
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
                .padding(12)
            }
        }
    }
}

#Preview {
    ProductsTab(salesModel: SalesModel(), appNavigation: AppNavigation())
}
