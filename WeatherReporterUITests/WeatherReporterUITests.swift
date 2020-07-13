//
//  WeatherReporterUITests.swift
//  WeatherReporterUITests
//
//  Created by Shekhar Dahore on 02/07/20.
//  Copyright © 2020 Shekkhar. All rights reserved.
//

import XCTest

class WeatherReporterUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments.append("UITesting")
        app.launch()
    }

    override func tearDown() {
        app = nil
    }

    func testAppLaunch() {
        let tablesQuery = app.tables.cells
        XCTAssertEqual(tablesQuery.count, 5, "Failed to load data")
    }

    func testLaunchPerformance() {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}
