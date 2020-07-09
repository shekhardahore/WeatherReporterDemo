//
//  WeatherHomeViewModel.swift
//  WeatherReporter
//
//  Created by Shekhar Dahore on 06/07/20.
//  Copyright © 2020 Shekkhar. All rights reserved.
//

import Foundation
import Moya

typealias CompletionHandler = (Bool,String?)->()

final class WeatherHomeViewModel {
    let provider: MoyaProvider<WeatherReporterService>
    var weatherModel: Weather?
    
    init (_ provider: MoyaProvider<WeatherReporterService>) {
        self.provider = provider
    }
    
    /// Fetchs weather for given location.
    /// - Parameters:
    ///   - latitude: latitude of the location
    ///   - longitude: longitude of the loaction
    ///   - completionHandler: completion handler to update view of result
    func fetchWeatherForCurrentLocation(latitude: String, logintude: String, _ completionHandler : @escaping CompletionHandler){
        provider.request(.getWeather(latitude: latitude, longitude: latitude)) { [unowned self] (result) in
            switch result {
            case .success(let response):
                do {
                    let weather = try JSONDecoder().decode(Weather.self, from: response.data)
                    self.weatherModel = weather
                    completionHandler(true, nil)
                } catch let jsonError {
                    completionHandler(false, jsonError.localizedDescription)
                }
            case .failure(let error):
                completionHandler(false, error.errorDescription)
            }
        }
    }
    
    /// Generates viewmodel for the WeatherTableView
    /// - Returns: array of contating viewmodel for WeatherTableView
    func getDisplayViewModels() -> [[WeatherViewModelItem]] {
        var displayViewModels: [[WeatherViewModelItem]] = [[]]
        guard let weather = weatherModel else {
            return displayViewModels
        }
        let summaryModel = WeatherSummaryViewModel(data: weather)
        displayViewModels.append([summaryModel])
        displayViewModels.append(getDetailsViewModels())
        return displayViewModels
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
}
