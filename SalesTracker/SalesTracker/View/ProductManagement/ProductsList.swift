//
//  ProductsList.swift
//  SalesTracker
//
//  Created by Bernardo Santiago Marin on 04/11/23.
//

import SwiftUI

struct ProductsList: View {
    @Environment(\.dynamicTypeSize) var dynamicTypeSize
    @ObservedObject var salesModel: ProductsModel
    @ObservedObject var appNavigation: AppNavigation
    @State private var showNewProductSheet = false
    @State private var presentedProducts = [Product]()
    @State private var filterCategorySelection: ProductCategory?
    
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
            CategoryPicker(salesModel: self.salesModel, selection: self.$filterCategorySelection)
                .padding(.horizontal)
            LazyVGrid(columns: self.columns) {
                ForEach(salesModel.Products) { product in
                    NavigationLink(value: product) {
                        ProductCard(dynamicTypeSize: self.dynamicTypeSize, product: product)
                            .tint(.primary)
                    }
                }
            }
            .padding(.horizontal)
            
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                newProductButton
            }
        }
        .sheet(isPresented: self.$showNewProductSheet, content: {
            NewProductView(salesModel: self.salesModel)
        })
        .refreshable {
            await salesModel.fetchProducts()
        }
        .alert("error", isPresented: self.$salesModel.showErrorMessage) {
            Button("dismiss") {
                self.salesModel.errorMessage = nil
                self.salesModel.actionResponse = nil
            }
        } message: {
            Text(self.salesModel.errorMessage ?? "unexpected_error")
        }
        .overlay {
            if self.salesModel.Products.isEmpty {
                ContentUnavailableView {
                    Label("no_products", systemImage: "square.slash.fill")
                } description: {
                    Text("add_products_information")
                } actions: {
                    if let response = salesModel.actionResponse, response == .InProgress {
                        ProgressView()
                    } else {
                        Button("reload") {
                            Task {
                                await self.salesModel.fetchProducts()
                            }
                        }
                    }
                }
            }
        }
        
    }
    
    var newProductButton: some View {
        Button("createNewProduct", systemImage: "plus.circle.fill") {
            self.showNewProductSheet.toggle()
        }
    }
}

struct ProductCard: View {
    let dynamicTypeSize: DynamicTypeSize
    let product: Product
    let currencyCode = Locale.current.currency?.identifier ?? "USD"
    var cardColor: Color {
        return CustomColor(rawValue: product.color)?.color ?? .primary
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .foregroundStyle(cardColor.opacity(0.15))
            
            // Dynamic type sizes too large shoud
            // display data in a vertical layout.
            //
            if self.dynamicTypeSize >= .large {
                VStack {
                    Text(product.name)
                        .foregroundStyle(cardColor)
                        .bold()
                        .lineLimit(3)
                        .accessibilityLabel(product.name)
                    Text(product.getPrice(), format: .currency(code: self.currencyCode))
                }
                .padding(.vertical, 12)
            } else {
                HStack {
                    Text(product.name)
                        .multilineTextAlignment(.leading)
                        .foregroundStyle(cardColor)
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
    ProductsTab(salesModel: ProductsModel(), appNavigation: AppNavigation())
}
