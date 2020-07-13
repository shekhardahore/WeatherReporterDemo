//
//  WeatherTableViewViewModelTests.swift
//  WeatherReporterTests
//
//  Created by Shekhar Dahore on 12/07/20.
//  Copyright © 2020 Shekkhar. All rights reserved.
//

import XCTest
import Moya

class WeatherTableViewViewModelTests: XCTestCase, TestingStubbable {

    var viewModel: WeatherTableViewViewModel!
    override func setUp() {
        
        viewModel = WeatherTableViewViewModel()
    }

    override func tearDown() {
        viewModel = nil
    }

    func testUpdateTableViewWithGoodData() {
        viewModel.updateTableView = { [weak self] in
            XCTAssert(self?.viewModel.tableViewCellViewModels?.count ?? 0 > 0, "Failed to get tablveViewCellViewModels from weather model")
        }
        viewModel.weatherModel = getWeatherModelFrom(file: "weather")
    }
    
    func testUpdateTableViewWithNoData() {
        viewModel.updateTableView = { [weak self] in
            XCTAssertNil(self?.viewModel.tableViewCellViewModels, "Error: Got tableViewCellViewModels from empty data.")
        }
        viewModel.weatherModel = getWeatherModelFrom(file: "WeatherEmpty")
    }
    
    func testUpdateTableViewWithPartialData() {
        viewModel.updateTableView = { [weak self] in
            XCTAssertNotNil(self?.viewModel.tableViewCellViewModels)
            //Will only have viewmodel for "chance of rain" since rest of the data is not present.
            XCTAssert(self?.viewModel.tableViewCellViewModels![1].count == 1, "Error: Got more tableViewCellViewModels than expected")
        }
        viewModel.weatherModel = getWeatherModelFrom(file: "WeatherPartial")
    }
}
