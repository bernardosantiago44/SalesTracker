//
//  AccountTab.swift
//  SalesTracker
//
//  Created by Bernardo Santiago Marin on 19/11/23.
//

import SwiftUI

struct LoginTab: View {
    @ObservedObject var appNavigation: AppNavigation
    @ObservedObject var salesModel: ProductsModel
    
    var body: some View {
        NavigationStack(path: self.$appNavigation.loginPath) {
            LoginView(appNavigation: self.appNavigation, salesModel: salesModel)
                .navigationTitle("login")
        }
    }
}

#Preview {
    LoginTab(appNavigation: AppNavigation(), salesModel: ProductsModel())
}
