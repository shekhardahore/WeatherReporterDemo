
//
//  WeatherDetailType.swift
//  WeatherReporter
//
//  Created by Shekhar Dahore on 09/07/20.
//  Copyright © 2020 Shekkhar. All rights reserved.
//

import Foundation

/// Different types of details that would be shown in details table view
enum WeatherDetailType: Hashable {
    case chanceOfPrecip(precipType: String?, value: Int?)
    case humidity(value: Int?)
    case wind(value: Double?)
    case feelsLike(value: Double?)
}

extension WeatherDetailType {
    func getTitle() -> String {
        switch self {
        case .chanceOfPrecip(let precipType, _):
            return  "CHANCE OF \(precipType?.uppercased() ?? "RAIN")".localizedString
        case .humidity:
            return "HUMIDITY".localizedString
        case .wind:
            return "WIND".localizedString
        case .feelsLike:
            return "FEELS LIKE".localizedString
        }
    }
    func getValue() -> String {
        switch self {
        case .chanceOfPrecip( _, let value):
            guard let value = value else { return "--" }
            return "\(value)%"
        case .humidity(let value):
            guard let value = value else { return "--" }
            return "\(value)%"
        case .wind(let value):
            guard let value = value else { return "--" }
            return MeasurementFormatter.getLocalizedTextFor(windSpeed: value)
        case .feelsLike(let value):
            guard let value = value else { return "--" }
            return MeasurementFormatter.getLocalizedTextFor(temperature: value)
        }
    }
}
