//
//  ProductDetailView.swift
//  SalesTracker
//
//  Created by Bernardo Santiago Marin on 06/11/23.
//

import SwiftUI

struct ProductDetailView: View {
    @Environment(\.dynamicTypeSize) var dynamicTypeSize
    @Bindable var productsModel: ProductsViewModel
    @ObservedObject var appNavigation: AppNavigation
    @State private var inventoryFollowup = false
    @State private var deleteProductConfirmationDialog = false
    
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
                // MARK: Header rating and summary
//                RatingVisualizer(rating: self.product.rating)
                LazyVGrid(columns: self.columns) {
                    productPriceCard
                    
                    categoryCard
                }
                
                // MARK: - Inventory
                Divider()
                Toggle("inventory_followup", isOn: self.$inventoryFollowup)
                Text(product.currentInventory, format: .number)
                
                // MARK: - Code
                if let barcode = product.barcode {
                    Divider()
                    Text("barcode: \(barcode)")
                }
                
                
                // MARK: - Delete product
                Divider()
                Button(role: .destructive) {
                    self.deleteProductConfirmationDialog.toggle()
                } label: {
                    if self.productsModel.isBusy {
                        ProgressView()
                    } else {
                        Label("delete_product", systemImage: "trash")
                    }
                }
                .buttonStyle(.borderedProminent)
                .disabled(self.productsModel.isBusy)

            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal)
            .confirmationDialog("delete_product_action_warning", isPresented: $deleteProductConfirmationDialog, titleVisibility: .visible) {
                Button(role: .cancel) {
                    self.deleteProductConfirmationDialog = false
                } label: {
                    Text("cancel")
                }
                
                Button(role: .destructive) {
                    Task {
//                        await self.salesModel.deleteProductFromCatalog(productId: self.product.id)
                        #warning("Allow to delete products")
                        self.appNavigation.goToMainView()
                    }
                    
                } label: {
                    Text("delete_product")
                }
                

            }
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
                Text("sales_today") + Text(" 15")
            }
            .padding()
        }
    }
    
    var categoryCard: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color(uiColor: .secondarySystemBackground))
            VStack {
                Text("category")
                    .font(.title3)
                Text(product.category.categoryName)
            }
            .padding()
        }
    }
}

#Preview {
    NavigationStack {
        ProductDetailView(productsModel: ProductsViewModel(), appNavigation: AppNavigation(), product: ProductsModel().sampleProducts[0])
    }
}
