//
//  AccountTab.swift
//  SalesTracker
//
//  Created by Bernardo Santiago Marin on 19/11/23.
//

import SwiftUI

struct AccountTab: View {
    @ObservedObject var appNavigation: AppNavigation
    
    var body: some View {
        NavigationStack {
            AccountManager(appNavigation: self.appNavigation)
                .navigationTitle("account")
        }
    }
}

#Preview {
    AccountTab(appNavigation: AppNavigation())
}
