//
//  WeatherHomeViewModel.swift
//  WeatherReporter
//
//  Created by Shekhar Dahore on 06/07/20.
//  Copyright © 2020 Shekkhar. All rights reserved.
//

import Foundation
import Moya

class WeatherHomeViewModel {
    let networkProvider: MoyaProvider<WeatherReporterService>
    var locationProvider: LocationProvider
    var weatherTableViewViewModel: WeatherTableViewViewModel
    var weatherModel: Weather? {
        didSet {
            self.weatherUpdated?()
            self.weatherTableViewViewModel.weatherModel = self.weatherModel
        }
    }
    var alertMessage: String? {
        didSet {
            self.weatherTableViewViewModel.weatherModel = self.weatherModel
            self.showAlertClosure?()
        }
    }
    var showAlertClosure: (()->())?
    var weatherUpdated: (()->())?

    init(networkProvider: MoyaProvider<WeatherReporterService>, locationProvider: LocationProvider) {
        self.networkProvider = networkProvider
        self.locationProvider = locationProvider
        self.weatherTableViewViewModel = WeatherTableViewViewModel()
        weatherTableViewViewModel.weatherHomeViewModelDelegate = self
        self.locationProvider.delegate = self
    }
    
    /// Fetchs weather user's current location.
    func fetchWeatherForCurrentLocation() {
        locationProvider.retriveCurrentLocation()
    }
    
    func fetchWeatherFor(latitude: String, longitude: String) {
        networkProvider.request(.getWeather(latitude: latitude, longitude: longitude)) { [unowned self] (result) in
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
}

extension WeatherHomeViewModel: LocationServiceDelegate {
    func didFetchLocation(latitude: String, longitude: String) {
        fetchWeatherFor(latitude: latitude, longitude: longitude)
    }
    
    func failedToFetchLocation(error: String) {
        alertMessage = error.localizedString
    }
}

extension WeatherHomeViewModel: WeatherHomeViewModelDelegate {
    func updateWeatherData() {
        fetchWeatherForCurrentLocation()
    }
}
