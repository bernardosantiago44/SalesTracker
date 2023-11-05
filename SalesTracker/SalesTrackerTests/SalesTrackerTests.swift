//
//  SalesTrackerTests.swift
//  SalesTrackerTests
//
//  Created by Bernardo Santiago Marin on 05/11/23.
//

import XCTest
@testable import SalesTracker

final class SalesTrackerTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testProductPriceRejectsNegativeValues() throws {
        let MockProduct = Product(name: "Test", category: "testing", color: .black, price: 10)
        
        XCTAssertTrue(MockProduct.isValid())
        XCTAssertEqual(MockProduct.getPrice(), 10)
        XCTAssertEqual(MockProduct.setPrice(-5), 10)
        XCTAssertNotEqual(MockProduct.getPrice(), -5)
        XCTAssertEqual(MockProduct.setPrice(50), 10)
        XCTAssertEqual(MockProduct.getPrice(), 50)
        
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
