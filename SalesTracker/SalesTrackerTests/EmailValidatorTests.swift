//
//  EmailValidatorTests.swift
//  SalesTracker
//
//  Created by Bernardo Santiago Marin on 07/02/24.
//

import XCTest

final class EmailValidatorTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testCorrectlyFormattedEmail() throws {
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
