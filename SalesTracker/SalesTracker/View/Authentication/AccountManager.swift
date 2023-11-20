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
    
    let user = Auth.auth().currentUser
    var body: some View {
        if let user {
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
                    // TODO: Embed signout method in Auth Handler.
                    do {
                        try Auth.auth().signOut()
                        self.appNavigation.askForLogin = true
                        self.appNavigation.goToMainTab()
                    } catch {
                        print(error.localizedDescription)
                    }
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
    AccountManager(appNavigation: AppNavigation())
}
