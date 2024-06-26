//
//  ProductsTab.swift
//  SalesTracker
//
//  Created by Bernardo Santiago Marin on 19/11/23.
//

import SwiftUI

struct ProductsTab: View {
    @ObservedObject var salesModel: ProductsModel
    @ObservedObject var appNavigation: AppNavigation
    
    var body: some View {
        NavigationStack(path: $appNavigation.productsNavigationPath) {
            ProductsList(salesModel: self.salesModel, appNavigation: self.appNavigation)
                .navigationDestination(for: Product.self) { product in
                    ProductDetailView(salesModel: self.salesModel, appNavigation: self.appNavigation, product: product)
                }
                .navigationTitle("products")
                .task {
                    guard salesModel.intialFetchPending else { return }
                        await salesModel.fetchProducts()
                        await salesModel.fetchCategories()
                        salesModel.intialFetchPending = false
                }
        }
    }
}

#Preview {
    ProductsTab(salesModel: ProductsModel(), appNavigation: AppNavigation())
}
