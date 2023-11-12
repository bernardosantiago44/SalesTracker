//
//  AuthenticationHandler.swift
//  SalesTracker
//
//  Created by Bernardo Santiago Marin on 12/11/23.
//

import Foundation
import FirebaseAuth

final class AuthenticationHandler: ObservableObject {
    @Published var errorOccured = false
    @Published var authenticationStatus: AuthenticationStatus?
    
    func registerUser(email: String, password: String) {
        self.errorOccured = false
        
        Auth.auth().createUser(withEmail: email, password: password) { _, error in
            if let error {
                self.errorOccured = true
                self.authenticationStatus = self.handleError(error, email: email, password: password)
            }
        }
    }
    
    func login(email: String, password: String) {
        self.errorOccured = false
        
        Auth.auth().signIn(withEmail: email, password: password) { _, error in
            if let error {
                self.errorOccured = true
                self.authenticationStatus = self.handleError(error, email: email, password: password)
            }
        }
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
            login(email: email, password: password)
            return .Successful
        case .wrongPassword:
            return .Error(message: "wrong_password")
        case .weakPassword:
            return .Error(message: "password_weak")
        
        default:
            return .Error(message: error.localizedDescription)
        }
    }
    
}
