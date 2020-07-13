//
//  Date+ExtensionsTest.swift
//  WeatherReporterTests
//
//  Created by Shekhar Dahore on 13/07/20.
//  Copyright © 2020 Shekkhar. All rights reserved.
//

import XCTest
class Date_ExtensionsTest: XCTestCase {
    
    func testSummaryDateStringFormat() {
        let date = Date(timeIntervalSince1970: 1593043200.0)
        let dateString = date.inDisplaySummaryFormat
        XCTAssertEqual(dateString, "Thursday, Jun 25", "Date format is incorrect.")
    }
}
