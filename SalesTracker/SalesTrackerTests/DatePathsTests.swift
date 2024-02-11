//
//  DatePathsTests.swift
//  SalesTrackerTests
//
//  Created by Bernardo Santiago Marin on 07/02/24.
//

import XCTest

final class DatePathsTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testRelativePaths() throws {
            let timestamps: [TimeInterval] = [
                1433116800, // (2015-06-01 00:00:00)
                1467471600, // (2016-07-02 15:00:00)
                1501826400, // (2017-08-04 06:00:00)
                1536181200, // (2018-09-05 21:00:00)
                1570449600, // (2019-10-07 12:00:00)
                1604890800, // (2020-11-09 03:00:00)
                1639159200, // (2021-12-10 18:00:00)
                1673514000, // (2023-01-12 09:00:00)
                1707868800, // (2024-02-14 00:00:00)
                1742050800, // (2025-03-15 15:00:00)
                1776405600, // (2026-04-17 06:00:00)
                1810674000  // (2027-05-18 21:00:00)
            ]
            let reference: [String] = [
                "jun-2015",
                "jul-2016",
                "aug-2017",
                "sep-2018",
                "oct-2019",
                "nov-2020",
                "dec-2021",
                "jan-2023",
                "feb-2024",
                "mar-2025",
                "apr-2026",
                "may-2027"
            ]
            
            for i in 0..<timestamps.count {
                XCTAssertEqual(Date(timeIntervalSince1970: timestamps[i]).relativeReference, reference[i])
            }
        }
        
        func testAbsolutePaths() throws {
            let timestamps: [TimeInterval] = [
                1433116800, // (2015-06-01 00:00:00)
                1467471600, // (2016-07-02 15:00:00)
                1501826400, // (2017-08-04 06:00:00)
                1536181200, // (2018-09-05 21:00:00)
                1570449600, // (2019-10-07 12:00:00)
                1604890800, // (2020-11-09 03:00:00)
                1639159200, // (2021-12-10 18:00:00)
                1673514000, // (2023-01-12 09:00:00)
                1707868800, // (2024-02-14 00:00:00)
                1742050800, // (2025-03-15 15:00:00)
                1776405600, // (2026-04-17 06:00:00)
                1810674000  // (2027-05-18 21:00:00)
            ]
            let reference: [String] = [
                "01-06-2015",
                "02-07-2016",
                "04-08-2017",
                "05-09-2018",
                "07-10-2019",
                "09-11-2020",
                "10-12-2021",
                "12-01-2023",
                "14-02-2024",
                "15-03-2025",
                "17-04-2026",
                "18-05-2027"
            ]
            
            for i in 0..<timestamps.count {
                XCTAssertEqual(Date(timeIntervalSince1970: timestamps[i]).absoluteReference, reference[i])
            }
        }

}
