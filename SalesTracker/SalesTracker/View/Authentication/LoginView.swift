//
//  LoginView.swift
//  SalesTracker
//
//  Created by Bernardo Santiago Marin on 11/11/23.
//

import SwiftUI
import Firebase

struct LoginView: View {
    @State private var authViewModel = AuthenticationViewModel()
    @State private var authHandler = AuthenticationHandler()
    @ObservedObject var appNavigation: AppNavigation
    @ObservedObject var salesModel: ProductsModel
    
    @FocusState var focusField: AuthField?
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            // TODO: Add the logo of the App here when designed.
            // MARK: email and password fields
            Group {
                EmailTextField()
                PasswordField()
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
                .disabled(!authViewModel.isEmailValid || !authViewModel.isPasswordValid)
            }
            .padding(.horizontal)
        }
        .alert("error_while_creating_user", isPresented: self.$authViewModel.showErrorAlert) {
            Text("close")
        } message: {
            if case let AuthenticationStatus.Error(message) = authViewModel.authenticationStatus {
                Text(LocalizedStringKey(message))
            }
        }
        .navigationBarTitleDisplayMode(.inline)

    }
    
    var signupButton: some View {
        Group {
            if authViewModel.authenticationStatus == .authenticating {
                ProgressView()
            } else {
                Button {
                    Task {
                        await authViewModel.registerUser()
                        
                        if authViewModel.authenticationStatus == .Successful {
                            await salesModel.fetchProducts()
                            appNavigation.askForLogin = false
                        }
                    }
                    
                    #warning("Redo this logic using an authentication state listener")
                    //            if let response = authHandler.authenticationStatus, response == .Successful {
                    //                self.appNavigation.askForLogin = false
                    //                Task {
                    //                    await self.salesModel.fetchProducts()
                    //                    dismiss()
                    //                }
                    //            }
                } label: {
                    Text("signup")
                }
                .buttonStyle(.bordered)
            }
        }
    }
    
    var loginButton: some View {
        Group {
            if authViewModel.authenticationStatus == .authenticating {
                ProgressView()
            } else {
                Button {
                    Task {
                        await authViewModel.loginWithEmailPassword()
                        if authViewModel.authenticationStatus == .Successful {
                            // Success
                            print("Login successful")
                            appNavigation.askForLogin = false
                        }
                    }
                } label: {
                    Text("login")
                }
                .buttonStyle(.borderedProminent)
            }
        }
    }
    
    @ViewBuilder
    func EmailTextField() -> some View {
        let isValid = authViewModel.isEmailValid
        HStack {
            TextField("email", text: $authViewModel.emailField)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
                .keyboardType(.emailAddress)
                .textContentType(.username)
                .submitLabel(.next)
                .focused(self.$focusField, equals: .email)
                .onSubmit {
                    self.focusField = .password
                }
            Image(systemName: isValid ? "checkmark.circle.fill" : "xmark.circle.fill")
                .foregroundStyle(isValid ? .green : .red)
        }
    }
    
    @ViewBuilder
    func PasswordField() -> some View {
        let isValid = authViewModel.isPasswordValid
        HStack {
            SecureField("password", text: $authViewModel.passwordField)
                .autocorrectionDisabled()
                .keyboardType(.asciiCapable)
                .textContentType(.password)
                .submitLabel(.done)
                .focused(self.$focusField, equals: .password)
                .onSubmit {
                    self.focusField = nil
                }
            Image(systemName: isValid ? "checkmark.circle.fill" : "xmark.circle.fill")
                .foregroundStyle(isValid ? .green : .red)
        }
    }
}

#Preview {
    NavigationStack {
        LoginView(appNavigation: AppNavigation(), salesModel: ProductsModel())
    }
}
