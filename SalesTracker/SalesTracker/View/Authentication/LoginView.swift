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
        // MARK: email and password fields
        Group {
            TextField("email", text: self.$email)
            
            SecureField("password", text: self.$password)
            
        }
        .textFieldStyle(RoundedGroupTextFieldStyle())
        .padding(.horizontal)
        
        // MARK: Login and signup buttons
        Group {
            ViewThatFits {
                HStack {
                    signupButton
                    
                    Spacer()
                    
                    loginButton
                }
                VStack {
                    signupButton
                    loginButton
                }
                .padding(.vertical, 20)
            }
        }
        .padding(.horizontal)
    }
    
    var signupButton: some View {
        Button {
            
        } label: {
            Text("signup")
        }
        .buttonStyle(.bordered)
    }
    
    var loginButton: some View {
        Button {
            
        } label: {
            Text("login")
        }
        .buttonStyle(.borderedProminent)
    }
    
    
}

#Preview {
    NavigationStack {
        LoginView()
    }
}
