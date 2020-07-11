//
//  WeatherTableViewViewModel.swift
//  WeatherReporter
//
//  Created by Shekhar Dahore on 11/07/20.
//  Copyright © 2020 Shekkhar. All rights reserved.
//

import Foundation

class WeatherTableViewViewModel {
    
    var weatherModel: Weather? {
        didSet {
            self.updateDisplayViewModels()
        }
    }
    var tableViewCellViewModels: [[WeatherViewModelItem]]? {
        didSet {
            self.updateTableView?()
        }
    }
    weak var weatherHomeViewModelDelegate: WeatherHomeViewModelDelegate?
    var updateTableView: (()->())?
    
    /// Generates viewmodel for the WeatherTableView
    func updateDisplayViewModels() {
        var displayViewModels: [[WeatherViewModelItem]] = [[]]
        guard let weather = weatherModel else {
            tableViewCellViewModels = displayViewModels
            return
        }
        let summaryModel = WeatherSummaryViewModel(data: weather)
        displayViewModels.append([summaryModel])
        displayViewModels.append(getDetailsViewModels())
        tableViewCellViewModels = displayViewModels
    }
    
    /// Generates viewmodel for the deatils section in WeatherTableView
    /// - Returns: array of contating viewmodel for the details section in WeatherTableView
    private func getDetailsViewModels() -> [WeatherViewModelItem] {
        var detailsViewModels: [WeatherViewModelItem] = []
        guard let weather = weatherModel else {
            return detailsViewModels
        }
        for type in WeatherDetailType.allCases {
            do {
                let model = try WeatherDetailViewModel(type: type, model: weather)
                detailsViewModels.append(model)
            } catch let error {
                assertionFailure("\(error.localizedDescription): \(type) ")
            }
        }
        return detailsViewModels
    }
    
    func updateWeather()  {
        weatherHomeViewModelDelegate?.updateWeatherData()
    }
}
