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
    var locationServiceManager: LocationService
    var weatherModel: Weather? {
        didSet {
            self.weatherUpdated?()
        }
    }
    var alertMessage: String? {
        didSet {
            self.showAlertClosure?()
        }
    }
    var showAlertClosure: (()->())?
    var weatherUpdated: (()->())?

    init(provider: MoyaProvider<WeatherReporterService>, locationServiceManager: LocationService) {
        self.provider = provider
        self.locationServiceManager = locationServiceManager
        locationServiceManager.delegate = self
    }
    
    /// Fetchs weather user's current location.
    func fetchWeatherForCurrentLocation() {
        locationServiceManager.retriveCurrentLocation()
    }
    
    func fetchWeatherFor(latitude: String, longitude: String) {
        provider.request(.getWeather(latitude: latitude, longitude: longitude)) { [unowned self] (result) in
            switch result {
            case .success(let response):
                do {
                    let weather = try JSONDecoder().decode(Weather.self, from: response.data)
                    self.weatherModel = weather
                } catch {
                    self.alertMessage = ErrorMessages.dataParsing
                }
            case .failure(_):
                self.alertMessage = ErrorMessages.serverFailed
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

extension WeatherHomeViewModel: LocationServiceDelegate {
    func didFetchLocation(latitude: String, longitude: String) {
        fetchWeatherFor(latitude: latitude, longitude: longitude)
    }
    
    func failedToFetchLocation(error: String) {
        alertMessage = error.localizedString
    }
}
