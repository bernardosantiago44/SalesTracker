//
//  ActionReponse.swift
//  SalesTracker
//
//  Created by Bernardo Santiago Marin on 05/11/23.
//

import Foundation

enum ActionReponse: Equatable {
    case Successful
    case InProgress
    case Unsuccessful
}

enum AuthenticationStatus: Equatable {
    case authenticated
    case Error(message: String)
    case notAuthenticated
    case authenticating
}
