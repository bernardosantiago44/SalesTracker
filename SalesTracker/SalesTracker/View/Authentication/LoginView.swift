//
//  LoginView.swift
//  SalesTracker
//
//  Created by Bernardo Santiago Marin on 11/11/23.
//

import SwiftUI
import Firebase

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        // TODO: Add the logo of the App here when designed.
        Group {
            TextField("email", text: self.$email)
            
            SecureField("password", text: self.$password)
            
        }
        .textFieldStyle(RoundedGroupTextFieldStyle())
        .padding(.horizontal)
    }
}

#Preview {
    NavigationStack {
        LoginView()
    }
}
