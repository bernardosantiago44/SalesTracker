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
    @State private var authenticationStatus: AuthenticationStatus?
    @State private var errorOccured = false
    
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
        .alert("error_while_creating_user", isPresented: $errorOccured) {
            Text("close")
        } message: {
            if let authenticationStatus, case let AuthenticationStatus.Error(message) = authenticationStatus {
                Text(message)
            }
        }
        .navigationBarTitleDisplayMode(.inline)

    }
    
    var signupButton: some View {
        Button {
            register()
        } label: {
            Text("signup")
        }
        .buttonStyle(.bordered)
    }
    
    var loginButton: some View {
        Button {
            login()
        } label: {
            Text("login")
        }
        .buttonStyle(.borderedProminent)
    }
    
    func register() {
        self.errorOccured = false
        Auth.auth().createUser(withEmail: self.email, password: self.password) { _, error in
            if let error {
                self.errorOccured = true
                handleError(error)
            }
        }
    }
    
    func login() {
        self.errorOccured = false
        Auth.auth().signIn(withEmail: self.email, password: self.password) { _, error in
            if let error = error {
                
                print("Login error: \(error.localizedDescription)")
                self.errorOccured = true
                handleError(error)
            } else {
                print("Successful")
            }
        }
    }
    
    func handleError(_ error: Error) {
        let errorCode = AuthErrorCode.Code(rawValue: error._code)
        switch errorCode {
        case .emailAlreadyInUse:
            login()
            break
        case .missingEmail:
            self.authenticationStatus = .Error(message: "email_blank")
                break
        case .invalidEmail:
            self.authenticationStatus = .Error(message: "email_bad")
            break
        case .weakPassword:
            self.authenticationStatus = .Error(message: "password_weak")
            break
        default:
            self.authenticationStatus = .Error(message: error.localizedDescription)
            break
        }
    }
}

#Preview {
    NavigationStack {
        LoginView()
    }
}
