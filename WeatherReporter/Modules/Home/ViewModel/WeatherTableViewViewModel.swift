////
////  WeatherTableViewViewModel.swift
////  WeatherReporter
////
////  Created by Shekhar Dahore on 11/07/20.
////  Copyright © 2020 Shekkhar. All rights reserved.
////
//
//import Foundation
//
//final class WeatherTableViewViewModel {
//    
//    var weatherModel: Weather? {
//        didSet {
//            self.updateDisplayViewModels()
//        }
//    }
//    private(set) var tableViewCellViewModels: [[WeatherViewModelItem]]? {
//        didSet {
//            self.updateTableView?()
//        }
//    }
//    weak var weatherHomeViewModelDelegate: WeatherHomeViewModelDelegate?
//    var updateTableView: (()->())?
//    
//    /// Generates viewmodel for the WeatherTableView
//    private func updateDisplayViewModels() {
//        guard let weather = weatherModel else {
//            tableViewCellViewModels = nil
//            return
//        }
//        var displayViewModels: [[WeatherViewModelItem]] = [[]]
//        let summaryModel = WeatherSummaryViewModel(data: weather)
//        displayViewModels.append([summaryModel])
//        displayViewModels.append(getDetailsViewModels())
//        tableViewCellViewModels = displayViewModels
//    }
//    
//    /// Generates viewmodel for the deatils section in WeatherTableView
//    /// - Returns: array of contating viewmodel for the details section in WeatherTableView
//    private func getDetailsViewModels() -> [WeatherViewModelItem] {
//        var detailsViewModels: [WeatherViewModelItem] = []
//        guard let weather = weatherModel else {
//            return detailsViewModels
//        }
//        for type in WeatherDetailType.allCases {
//            do {
//                let model = try WeatherDetailViewModel(type: type, model: weather)
//                detailsViewModels.append(model)
//            } catch let error {
//                //log error
//                print("\(error.localizedDescription): \(type)")
//            }
//        }
//        return detailsViewModels
//    }
//    
//    func updateWeather()  {
//        weatherHomeViewModelDelegate?.updateWeatherData()
//    }
//}
