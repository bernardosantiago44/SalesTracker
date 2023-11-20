//
//  ProductsTab.swift
//  SalesTracker
//
//  Created by Bernardo Santiago Marin on 19/11/23.
//

import SwiftUI

struct ProductsTab: View {
    @ObservedObject var salesModel: SalesModel
    @ObservedObject var appNavigation: AppNavigation
    
    var body: some View {
        NavigationStack(path: $appNavigation.productsNavigationPath) {
            ProductsList(salesModel: self.salesModel)
                .navigationDestination(for: Product.self) { product in
                    ProductDetailView(product: product)
                }
                .navigationTitle("products")
        }
    }
}

#Preview {
    ProductsTab(salesModel: SalesModel(), appNavigation: AppNavigation())
}
