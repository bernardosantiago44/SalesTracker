//
//  EmailValidator.swift
//  SalesTracker
//
//  Created by Bernardo Santiago Marin on 19/11/23.
//

import Foundation

final class EmailValidator {
    static func isValidEmail(_ email: String) -> Bool {
        let regex = try! NSRegularExpression(pattern: "^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}$")
        let range = NSRange(location: 0, length: email.utf16.count)
        return regex.firstMatch(in: email, range: range) != nil
    }
}
