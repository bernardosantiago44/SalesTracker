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
    @ObservedObject var authHandler = AuthenticationHandler()
    @State private var authenticationStatus: AuthenticationStatus?
    
    var body: some View {
        VStack {
            // TODO: Add the logo of the App here when designed.
            // MARK: email and password fields
            Text(Auth.auth().currentUser?.email ?? "")
            Group {
                TextField("email", text: self.$email)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                    .keyboardType(.emailAddress)
                    .textContentType(.username)
                    .submitLabel(.next)
                
                SecureField("password", text: self.$password)
                    .autocorrectionDisabled()
                    .keyboardType(.asciiCapable)
                    .textContentType(.password)
                    .submitLabel(.done)
                
                
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
        .alert("error_while_creating_user", isPresented: self.$authHandler.errorOccured) {
            Text("close")
        } message: {
            if let authenticationStatus = authHandler.authenticationStatus, case let AuthenticationStatus.Error(message) = authenticationStatus {
                Text(LocalizedStringKey(message))
            }
        }
        .navigationBarTitleDisplayMode(.inline)

    }
    
    var signupButton: some View {
        Button {
            authHandler.registerUser(email: self.email, password: self.password)
        } label: {
            Text("signup")
        }
        .buttonStyle(.bordered)
    }
    
    var loginButton: some View {
        Button {
            authHandler.login(email: self.email, password: self.password)
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
