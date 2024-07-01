//
//  ProductsList.swift
//  SalesTracker
//
//  Created by Bernardo Santiago Marin on 04/11/23.
//

import SwiftUI

struct ProductsList: View {
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize
    @Bindable var productsViewModel: ProductsViewModel
    
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
            CategoryPicker(salesModel: self.productsViewModel, selection: $productsViewModel.filterCategorySelection)
                .padding(.horizontal)
            if self.productsViewModel.products.isEmpty {
                // Display a message of absent data
                ContentUnavailableView {
                    Label("no_products", systemImage: "square.slash.fill")
                } description: {
                    Text("add_products_information")
                } actions: {
                    if self.productsViewModel.isBusy {
                        ProgressView()
                    } else {
                        Button("reload") {
                            Task {
                                await self.productsViewModel.downloadProducts()
                            }
                        }
                    }
                }
            } else {
                LazyVGrid(columns: self.columns) {
                    ForEach(self.productsViewModel.products) { product in
                        NavigationLink(value: product) {
                            ProductCard(product: product)
                                .tint(.primary)
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                newProductButton
            }
        }
        .sheet(isPresented: $productsViewModel.showNewProductSheet) {
            NewProductView(salesModel: self.productsViewModel)
        }
        .refreshable {
            await productsViewModel.downloadProducts()
        }
        .alert(Text("error"), isPresented: $productsViewModel.showErrorAlert) {
            
        } message: {
            Text(productsViewModel.error?.localizedDescription ?? "unexpected_error")
        }

    }
    
    private var newProductButton: some View {
        Button("createNewProduct", systemImage: "plus.circle.fill") {
            self.productsViewModel.showNewProductSheet = true
        }
    }
}

struct ProductCard: View {
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize: DynamicTypeSize
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
    ProductsTab(productsModel: ProductsViewModel(), appNavigation: AppNavigation())
}
