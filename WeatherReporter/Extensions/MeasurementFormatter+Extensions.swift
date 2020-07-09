//
//  MeasurementFormatter+Extensions.swift
//  WeatherReporter
//
//  Created by Shekhar Dahore on 09/07/20.
//  Copyright © 2020 Shekkhar. All rights reserved.
//

import Foundation

extension MeasurementFormatter {
    
    /// Converts the given temperature to the format used by the device in current locale.
    /// - Parameters:
    ///   - temperature: temperatur in celcius.
    /// - Returns: temperature to be displayed.
    static func getLocalizedTextFor(temperature: Double) -> String {
        let measurement = Measurement(value: temperature, unit: UnitTemperature.celsius)
        let formatter = MeasurementFormatter()
        let n = NumberFormatter()
        n.maximumFractionDigits = 0
        formatter.numberFormatter = n
        return formatter.string(from: measurement)
    }
    
    /// Converts the given windSpeed to the format used by the device in current locale.
    /// - Parameters:
    ///   - windSpeed: windSpeed in km/h
    /// - Returns: windSpeed to be displayed.
    static func getLocalizedTextFor(windSpeed: Double) -> String {
        let measurement = Measurement(value: windSpeed, unit: UnitSpeed.kilometersPerHour)
        let formatter = MeasurementFormatter()
        return formatter.string(from: measurement)
    }
}
