//
//  ContentView.swift
//  SalesTracker
//
//  Created by Bernardo Santiago Marin on 02/11/23.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var salesModel: SalesModel
    @ObservedObject var appNavigation: AppNavigation
    
    var body: some View {
        TabView(selection: self.$appNavigation.selectedTab) {
            ProductsTab(salesModel: self.salesModel, appNavigation: self.appNavigation)
                .tabItem {
                    Label("products", systemImage: "rectangle.grid.2x2")
                }
                .tag(AppPages.productsList)
            
            AccountTab(appNavigation: self.appNavigation)
                .tabItem {
                   Label("account", systemImage: "person.circle")
                }
                .tag(AppPages.account)
        }
        
        // If no user is logged in
        // present the modal to authenticate
        //
        .fullScreenCover(isPresented: self.$appNavigation.askForLogin, content: {
            LoginTab(appNavigation: self.appNavigation)
        })
    }
}

#Preview {
    ContentView(salesModel: SalesModel(), appNavigation: AppNavigation())
}
