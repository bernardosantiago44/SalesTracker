//
//  ContentView.swift
//  SalesTracker
//
//  Created by Bernardo Santiago Marin on 02/11/23.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var productsModel: ProductsModel
    @ObservedObject var appNavigation: AppNavigation
    @ObservedObject var salesModel: SalesModel
    
    var body: some View {
        TabView(selection: self.$appNavigation.selectedTab) {
            ProductsTab(salesModel: self.productsModel, appNavigation: self.appNavigation)
                .tabItem {
                    Label("products", systemImage: "rectangle.grid.2x2")
                }
                .tag(AppPages.productsList)
            
            MonthlySalesTab(salesModel: self.salesModel)
                .tabItem { Label("sales", systemImage: "chart.line.uptrend.xyaxis") }
                .tag(AppPages.trends)
            
            AccountTab(appNavigation: self.appNavigation)
                .tabItem {
                   Label("account", systemImage: "person.circle")
                }
                .tag(AppPages.account)
        }
        
        // If no user is logged in
        // present the modal to authenticate
        //
        .fullScreenCover(isPresented: self.$appNavigation.askForLogin, onDismiss: {
            Task {
                await productsModel.fetchProducts()
                await productsModel.fetchCategories()
            }
        }, content: {
            LoginTab(appNavigation: self.appNavigation, salesModel: self.productsModel)
        })
    }
}

#Preview {
    ContentView(productsModel: ProductsModel(), appNavigation: AppNavigation(), salesModel: SalesModel())
}
