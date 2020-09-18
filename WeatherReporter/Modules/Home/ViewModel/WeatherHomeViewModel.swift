//
//  WeatherHomeViewModel.swift
//  WeatherReporter
//
//  Created by Shekhar Dahore on 06/07/20.
//  Copyright © 2020 Shekkhar. All rights reserved.
//

import Foundation
import Moya

enum DataItem: Hashable {
    case summary(data: WeatherSummaryModel)
    case details(data: WeatherDetailModel)
}

final class WeatherHomeViewModel {
    private let networkProvider: MoyaProvider<WeatherReporterService>
    private var locationProvider: LocationProvider
    
    private var weatherModel: Weather? {
        didSet {
            self.weatherUpdated?()
        }
    }

    private(set) var alertMessage: String? {
        didSet {
            self.showAlertClosure?()
        }
    }
    
    var showAlertClosure: (()->())?
    var weatherUpdated: (()->())?

    init(networkProvider: MoyaProvider<WeatherReporterService>, locationProvider: LocationProvider) {
        self.networkProvider = networkProvider
        self.locationProvider = locationProvider
        self.locationProvider.delegate = self
    }
    
    /// Fetchs weather user's current location.
    func fetchWeatherForCurrentLocation() {
        locationProvider.retriveCurrentLocation()
    }
    
    private func fetchWeatherFor(latitude: String, longitude: String) {
        networkProvider.request(.getWeather(latitude: latitude, longitude: longitude)) { [unowned self] (result) in
            switch result {
            case .success(let response):
                do {
                    let weather = try JSONDecoder().decode(Weather.self, from: response.data)
                    self.weatherModel = weather
                } catch {
                    self.alertMessage = ErrorMessages.defaultError.rawValue
                }
            case .failure(_):
                self.alertMessage = ErrorMessages.serverFailed.rawValue
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

extension WeatherHomeViewModel {
    
    func getWeatherSummaryModel() -> WeatherSummaryModel {
        return WeatherSummaryModel(data: self.weatherModel)
    }

    /// Generates model for the deatils section in WeatherTableView
    /// - Returns: array of contating `DataItem` for the details section in WeatherTableView
     func getWeatherDetailModels() -> [DataItem] {
        var detailsViewModels: [DataItem] = []
        guard let weather = weatherModel else {
            return detailsViewModels
        }
        
        let model = WeatherDetailModel(type: .feelsLike(value: weather.currently.apparentTemperature))
        let model2 = WeatherDetailModel(type: .chanceOfPrecip(precipType: weather.currently.precipType, value: weather.currently.precipProbabilityPercentage))
        let model3 = WeatherDetailModel(type: .humidity(value: weather.currently.humitdityPercentage))
        let model4 = WeatherDetailModel(type: .wind(value: weather.currently.windSpeed))
        
        detailsViewModels = [.details(data: model2), .details(data: model3), .details(data: model4), .details(data: model)]        
        return detailsViewModels
    }
}
