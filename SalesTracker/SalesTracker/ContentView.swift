//
//  ContentView.swift
//  SalesTracker
//
//  Created by Bernardo Santiago Marin on 02/11/23.
//

import SwiftUI
import FirebaseAuth

struct ContentView: View {
    @ObservedObject var productsModel: ProductsModel
    @ObservedObject var appNavigation: AppNavigation
    @ObservedObject var salesModel: SalesModel
    @State private var authViewModel = AuthenticationViewModel()
    
    var body: some View {
        if !authViewModel.isUserAuthenticated() {
            // Show authentication view
            LoginTab(appNavigation: self.appNavigation, authViewModel: self.authViewModel)
        } else {
            TabView(selection: self.$appNavigation.selectedTab) {
                ProductsTab(salesModel: self.productsModel, appNavigation: self.appNavigation)
                    .tabItem {
                        Label("products", systemImage: "rectangle.grid.2x2")
                    }
                    .tag(AppPages.productsList)
                
                MonthlySalesTab(salesModel: self.salesModel)
                    .tabItem { Label("sales", systemImage: "chart.line.uptrend.xyaxis") }
                    .tag(AppPages.trends)
                
                AccountTab(appNavigation: self.appNavigation, authViewModel: self.authViewModel)
                    .tabItem {
                        Label("account", systemImage: "person.circle")
                    }
                    .tag(AppPages.account)
            }
        }
    }
}

#Preview {
    ContentView(productsModel: ProductsModel(), appNavigation: AppNavigation(), salesModel: SalesModel())
}
