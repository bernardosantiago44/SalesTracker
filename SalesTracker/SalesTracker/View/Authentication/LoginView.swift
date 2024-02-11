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
    @StateObject var authHandler = AuthenticationHandler()
    @ObservedObject var appNavigation: AppNavigation
    @ObservedObject var salesModel: ProductsModel
    @FocusState var focusField: AuthField?
    @Environment(\.dismiss) private var dismiss
    
    var emailValidated: Bool {
        return EmailValidator.isValidEmail(email)
    }
    
    var passwordValidated: Bool {
        return password.count >= 6
    }
    
    var body: some View {
        VStack {
            // TODO: Add the logo of the App here when designed.
            // MARK: email and password fields
            Group {
                EmailTextField
                PasswordField
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
                .disabled(!emailValidated || !passwordValidated)
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
            if let response = authHandler.authenticationStatus, response == .Successful {
                self.appNavigation.askForLogin = false
                Task {
                    await self.salesModel.fetchProducts()
                    dismiss()
                }
            }
        } label: {
            Text("signup")
        }
        .buttonStyle(.bordered)
    }
    
    var loginButton: some View {
        Button {
            let response = authHandler.login(email: self.email, password: self.password)
            if response == .Successful {
                self.appNavigation.askForLogin = false
                Task {
                    await self.salesModel.fetchProducts()
                }
            }
        } label: {
            Text("login")
        }
        .buttonStyle(.borderedProminent)
    }
    
    var EmailTextField: some View {
        HStack {
            TextField("email", text: self.$email)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
                .keyboardType(.emailAddress)
                .textContentType(.username)
                .submitLabel(.next)
                .focused(self.$focusField, equals: .email)
                .onSubmit {
                    self.focusField = .password
                }
            Image(systemName: emailValidated ? "checkmark.circle.fill" : "xmark.circle.fill")
                .foregroundStyle(emailValidated ? .green : .red)
        }
    }
    
    var PasswordField: some View {
        HStack {
            SecureField("password", text: self.$password)
                .autocorrectionDisabled()
                .keyboardType(.asciiCapable)
                .textContentType(.password)
                .submitLabel(.done)
                .focused(self.$focusField, equals: .password)
                .onSubmit {
                    self.focusField = nil
                }
            Image(systemName: passwordValidated ? "checkmark.circle.fill" : "xmark.circle.fill")
                .foregroundStyle(passwordValidated ? .green : .red)
        }
    }
}

#Preview {
    NavigationStack {
        LoginView(appNavigation: AppNavigation(), salesModel: ProductsModel())
    }
}
