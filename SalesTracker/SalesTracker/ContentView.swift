//
//  ContentView.swift
//  SalesTracker
//
//  Created by Bernardo Santiago Marin on 02/11/23.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var sharedModel: SalesModel
    @ObservedObject var appNavigation: AppNavigation
    
    var body: some View {
        NavigationStack(path: $appNavigation.path) {
            LoginView()
                .navigationDestination(for: AppPages.self) { page in
                    ProductsList(salesModel: self.sharedModel)
                }
        }
    }
}

#Preview {
    ContentView(sharedModel: SalesModel(), appNavigation: AppNavigation())
}
