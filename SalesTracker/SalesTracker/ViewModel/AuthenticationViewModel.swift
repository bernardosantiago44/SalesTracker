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
    /// The user object associated with the authenticated account.
    var user: User?
    
    @ObservationIgnored
    private var authStateHandle: AuthStateDidChangeListenerHandle?
    
    init() {
        registerAuthStateHandler()
    }
    
    deinit {
        if self.authStateHandle != nil {
            Auth.auth().removeStateDidChangeListener(authStateHandle!)
        }
    }
    
    /// Create a user with the provided email and password fields.
    /// Fails is the current email is already registered.
    ///
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
        self.authenticationStatus = .authenticated
    }
    
    /// Signs in with the provided email and password fields.
    ///
    func loginWithEmailPassword() async {
        authenticationStatus = .authenticating
        
        do {
            try await Auth.auth().signIn(withEmail: emailField, password: passwordField)
        } catch {
            self.showErrorAlert = true
            self.authenticationStatus = .Error(message: error.localizedDescription)
            return
        }
        
        authenticationStatus = .authenticated
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
        } catch {
            self.showErrorAlert = true
            self.authenticationStatus = .Error(message: error.localizedDescription)
        }
        self.authenticationStatus = Auth.auth().currentUser == nil ? .notAuthenticated : .authenticated
    }
    
    private func registerAuthStateHandler() {
        guard authStateHandle == nil else { return }
        authStateHandle = Auth.auth().addStateDidChangeListener({ auth, user in
            self.user = user
            self.authenticationStatus = user == nil ? .notAuthenticated : .authenticated
        })
    }
    
    public func isUserAuthenticated() -> Bool {
        return self.user != nil && self.authenticationStatus == .authenticated
    }
}
