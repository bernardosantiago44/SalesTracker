//
//  AccountTab.swift
//  SalesTracker
//
//  Created by Bernardo Santiago Marin on 19/11/23.
//

import SwiftUI

struct LoginTab: View {
    @ObservedObject var appNavigation: AppNavigation
    
    var body: some View {
        NavigationStack(path: self.$appNavigation.loginPath) {
            LoginView(appNavigation: self.appNavigation)
                .navigationTitle("login")
        }
    }
}

#Preview {
    LoginTab(appNavigation: AppNavigation())
}
