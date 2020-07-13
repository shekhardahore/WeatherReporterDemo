//
//  WeatherHomeViewModelTests.swift
//  WeatherReporterTests
//
//  Created by Shekhar Dahore on 12/07/20.
//  Copyright © 2020 Shekkhar. All rights reserved.
//

import XCTest
import Moya

class WeatherHomeViewModelTests: XCTestCase {
    
    var viewModel: WeatherHomeViewModel!
    override func setUp() {
        let provider = MoyaProvider<WeatherReporterService>(stubClosure: MoyaProvider.immediatelyStub)
        let location = LocationServiceMock()
        viewModel = WeatherHomeViewModel(networkProvider: provider, locationProvider: location)
    }

    override func tearDown() {
        viewModel = nil
    }

    func testFetchWeatherForCurrentLocation() {
        
        viewModel.weatherUpdated = { [weak self] in
            XCTAssertNotNil(self?.viewModel.weatherModel, "Failed to fetch weather")
        }
        viewModel.showAlertClosure = { [weak self] in
            XCTAssertNil(self?.viewModel.alertMessage, "Failed to fetch weather, because of \(self?.viewModel.alertMessage ?? "")")
        }
        viewModel.fetchWeatherForCurrentLocation()
    }
}
