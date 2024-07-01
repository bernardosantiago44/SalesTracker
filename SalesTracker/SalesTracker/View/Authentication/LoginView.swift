//
//  LoginView.swift
//  SalesTracker
//
//  Created by Bernardo Santiago Marin on 11/11/23.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct LoginView: View {
    @Bindable var authViewModel: AuthenticationViewModel
    @ObservedObject var appNavigation: AppNavigation
    
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
                    }
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
        ContentView(appNavigation: AppNavigation(), salesModel: SalesModel())
    }
}
