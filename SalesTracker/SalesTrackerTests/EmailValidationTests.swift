//
//  EmailValidationTests.swift
//  SalesTrackerTests
//
//  Created by Bernardo Santiago Marin on 19/11/23.
//

import XCTest
@testable import SalesTracker

final class EmailValidationTests: XCTest {
    func testCorrectlyFormatterEmails() throws {
        let correctEmails = [
            "john.doe@example.com",
            "alice.smith@emailprovider.net",
            "mike_jones123@email.org",
            "sarah.miller@emailservice.com",
            "info@companywebsite.com",
            "contact_us@businessco.org",
            "sales.department@emailcorp.net",
            "support.team@techcompany.com",
            "jane_doe@emailprovider.org",
            "customer.service@ecommercestore.com",
            "marketing@digitalagency.net",
            "admin@blogwebsite.com",
            "webmaster@techblog.org",
            "hr.department@companyinc.com",
            "feedback@usersupport.net"
        ]
        
        for email in correctEmails {
            XCTAssertTrue(EmailValidator.isValidEmail(email), "\(email) should be correct.")
        }
    }
    
    func testBadlyFormattedEmails() throws {
        let badlyFormattedEmails = [
            "john.doe@example",
            "alice.smith@.net",
            "mike_jones123@email",
            "sarah.miller@.com",
            "info@companywebsite",
            "contact_us@businessco.",
            "sales.department@.net",
            "support.team@techcompany>com",
            "jane_doe@emailprovider.",
            "customer.service@ecommercestore",
            "marketing@123",
            "admin@blogwebsite;co",
            "webmaster@techblog",
            "hr.department@companyinc",
            "feedback@usersupport."
        ]
        
        for email in badlyFormattedEmails {
            XCTAssertFalse(EmailValidator.isValidEmail(email), "\(email) should not be valid.")
        }
    }
}
