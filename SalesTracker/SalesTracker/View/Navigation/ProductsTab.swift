//
//  ProductsTab.swift
//  SalesTracker
//
//  Created by Bernardo Santiago Marin on 19/11/23.
//

import SwiftUI

struct ProductsTab: View {
    @Bindable var productsModel: ProductsViewModel
    @ObservedObject var appNavigation: AppNavigation
    
    var body: some View {
        NavigationStack(path: $appNavigation.productsNavigationPath) {
            ProductsList()
                .navigationDestination(for: Product.self) { product in
                    ProductDetailView(productsModel: self.productsModel, appNavigation: self.appNavigation, product: product)
                }
                .navigationTitle("products")
                .task {
                    guard productsModel.initialFetchPending else { return }
                    await productsModel.downloadProducts()
                    await productsModel.downloadCategories()
                    productsModel.initialFetchPending = false
                }
        }
    }
}

#Preview {
    ProductsTab(productsModel: ProductsViewModel(), appNavigation: AppNavigation())
}
