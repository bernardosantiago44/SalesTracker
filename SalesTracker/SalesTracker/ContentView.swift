//
//  ContentView.swift
//  SalesTracker
//
//  Created by Bernardo Santiago Marin on 02/11/23.
//

import SwiftUI
import FirebaseAuth

struct ContentView: View {
    @State private var productsViewModel = ProductsViewModel()
    @ObservedObject var appNavigation: AppNavigation
    @ObservedObject var salesModel: SalesModel
    @State private var authViewModel = AuthenticationViewModel()
    @State private var ticketsViewModel = TicketsListViewModel()
    
    var body: some View {
        if !authViewModel.isUserAuthenticated() {
            // Show authentication view
            LoginTab(appNavigation: self.appNavigation, authViewModel: self.authViewModel)
        } else {
            TabView(selection: self.$appNavigation.selectedTab) {
                ProductsTab(productsModel: self.productsViewModel, appNavigation: self.appNavigation)
                    .tabItem {
                        Label("products", systemImage: "rectangle.grid.2x2")
                    }
                    .tag(AppPages.productsList)
                
                TicketsTab(ticketsViewModel: self.ticketsViewModel)
                    .tabItem {
                        Label("tickets", systemImage: AppPages.ticketsList.rawValue)
                    }
                    .tag(AppPages.ticketsList)

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
    ContentView(appNavigation: AppNavigation(), salesModel: SalesModel())
}
