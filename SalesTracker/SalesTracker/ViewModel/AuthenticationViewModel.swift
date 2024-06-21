//
//  AuthenticationViewModel.swift
//  SalesTracker
//
//  Created by Bernardo Santiago Marin on 21/06/24.
//

import Foundation
import FirebaseAuth

@Observable
final class AuthenticationViewModel {
    var emailField = ""
    var passwordField = ""
    var authenticationStatus = AuthenticationStatus.notAuthenticated
    
    var showErrorAlert = false
    
    var isEmailValid: Bool {
        return EmailValidator.isValidEmail(emailField)
    }
    
    var isPasswordValid: Bool {
        return passwordField.count > 6
    }
    
    func registerUser() async {
        authenticationStatus = .authenticating
        
        // Attempt to create the user
        // If call fails, show the error message and stop execution
        do {
            try await Auth.auth().createUser(withEmail: emailField, 
                                                          password: passwordField)
        } catch {
            showErrorAlert = true
            authenticationStatus = .Error(message: error.localizedDescription)
            return
        }
        self.authenticationStatus = .Successful
    }
    
    func loginWithEmailPassword() async {
        authenticationStatus = .authenticating
        
        do {
            try await Auth.auth().signIn(withEmail: emailField, password: passwordField)
        } catch {
            self.showErrorAlert = true
            self.authenticationStatus = .Error(message: error.localizedDescription)
            return
        }
        
        authenticationStatus = .Successful
    }
}
