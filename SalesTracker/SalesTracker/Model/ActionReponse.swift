//
//  ActionReponse.swift
//  SalesTracker
//
//  Created by Bernardo Santiago Marin on 05/11/23.
//

import Foundation

enum ActionReponse {
    case Successful
    case InProgress
    case Unsuccessful
}

enum AuthenticationStatus {
    case Successful
    case Error(message: String)
}
