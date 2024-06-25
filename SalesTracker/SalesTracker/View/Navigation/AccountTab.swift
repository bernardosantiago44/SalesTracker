//
//  AccountTab.swift
//  SalesTracker
//
//  Created by Bernardo Santiago Marin on 19/11/23.
//

import SwiftUI

struct AccountTab: View {
    @ObservedObject var appNavigation: AppNavigation
    @Bindable var authViewModel: AuthenticationViewModel
    
    var body: some View {
        NavigationStack {
            AccountManager(appNavigation: self.appNavigation, authViewModel: self.authViewModel)
                .navigationTitle("account")
        }
    }
}

