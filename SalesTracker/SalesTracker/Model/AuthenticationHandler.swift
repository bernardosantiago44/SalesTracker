//
//  AuthenticationHandler.swift
//  SalesTracker
//
//  Created by Bernardo Santiago Marin on 12/11/23.
//

import Foundation
import FirebaseAuth

@Observable
final class AuthenticationHandler {
    var errorOccured = false
    var authenticationStatus: AuthenticationStatus = .notAuthenticated
    
    func registerUser(email: String, password: String) {
        self.errorOccured = false
        
        Auth.auth().createUser(withEmail: email, password: password) { _, error in
            if let error {
                self.errorOccured = true
                self.authenticationStatus = self.handleError(error, email: email, password: password)
                return
            }
            self.authenticationStatus = .authenticated
        }
    }
    
    func login(email: String, password: String) -> AuthenticationStatus {
        self.errorOccured = false
        var status: AuthenticationStatus = .Error(message: "unknown_error")
        
        Auth.auth().signIn(withEmail: email, password: password) { _, error in
            if let error {
                self.errorOccured = true
                self.authenticationStatus = .Error(message: error.localizedDescription)
                status = self.handleError(error, email: email, password: password)
            }
        }
        return status
    }
    
    private func handleError(_ error: Error, email: String, password: String) -> AuthenticationStatus {
        let errorCode = AuthErrorCode.Code(rawValue: error._code)
        
        if email.isEmpty {
            return .Error(message: "email_blank")
        }
        
        if password.isEmpty {
            return .Error(message: "password_blank")
        }
        
        switch errorCode {
        case .missingEmail:
            return .Error(message: "email_blank")
        case .invalidEmail:
            return .Error(message: "email_bad")
        case .emailAlreadyInUse:
            return login(email: email, password: password)
        case .wrongPassword:
            return .Error(message: "wrong_password")
        case .weakPassword:
            return .Error(message: "password_weak")
        
        default:
            return .Error(message: error.localizedDescription)
        }
    }
    
}
