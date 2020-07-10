//
//  WeatherDetailViewModel.swift
//  WeatherReporter
//
//  Created by Shekhar Dahore on 08/07/20.
//  Copyright © 2020 Shekkhar. All rights reserved.
//

import Foundation

final class WeatherDetailViewModel: WeatherViewModelItem {
    var type: WeatherViewModelItemType {
        return .detail
    }
    var rowCount: Int {
        return 0
    }
    
    var titleText: String = ""
    var valueText: String = ""
    
    init(type: WeatherDetailType, model: Weather) throws {
        switch type {
        case .feelsLike:
            guard let temp = model.currently?.apparentTemperature else {
                throw WRErrors.valueNotFound
            }
            titleText = "FEELS LIKE".localizedString
            valueText = MeasurementFormatter.getLocalizedTextFor(temperature: temp)
        case .humidity:
            guard let humidity = model.currently?.humitdityPercentage else {
                throw WRErrors.valueNotFound
            }
            titleText = "HUMIDITY".localizedString
            valueText = "\(humidity)%"
        case .wind:
            guard let wind = model.currently?.windSpeed else {
                throw WRErrors.valueNotFound
            }
            titleText = "WIND".localizedString
            valueText = MeasurementFormatter.getLocalizedTextFor(windSpeed: wind)
        case .chanceOfPrecip:
            guard let precipPercentage = model.currently?.precipProbabilityPercentage else {
                throw WRErrors.valueNotFound
            }
            let precipType = model.currently?.precipType ?? "RAIN"
            titleText = "CHANCE OF \(precipType.uppercased())".localizedString
            valueText = "\(precipPercentage)%"
        }
    }
}
