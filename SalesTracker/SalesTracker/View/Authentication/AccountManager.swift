//
//  AccountManager.swift
//  SalesTracker
//
//  Created by Bernardo Santiago Marin on 19/11/23.
//

import SwiftUI
import FirebaseAuth

struct AccountManager: View {
    @ObservedObject var appNavigation: AppNavigation
    @State private var alertSignOutShown = false
    @Bindable var authViewModel: AuthenticationViewModel
    
    var body: some View {
        if let user = authViewModel.user {
            List {
                if user.email != nil {
                    Section {
                        Text(user.email ?? "unspecified")
                    } header: {
                        Text("email")
                    }
                }
                
                Section {
                    Button("signout", role: .destructive) {
                        self.alertSignOutShown.toggle()
                    }

                } header: {
                    Text("account")
                }
            }
            .alert("signout_question", isPresented: $alertSignOutShown) {
                Button("signout", role: .destructive) {
                    authViewModel.signOut()
                }
            }
        } else {
            GroupBox {
                Image(systemName: "exclamationmark.triangle.fill")
                Text("user.notFound")
            }
        }
    }
}

#Preview {
    ContentView(appNavigation: AppNavigation(), salesModel: SalesModel())
}
