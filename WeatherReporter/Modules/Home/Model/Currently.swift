//
//  Currently.swift
//  WeatherReporter
//
//  Created by Shekhar Dahore on 07/07/20.
//  Copyright © 2020 Shekkhar. All rights reserved.
//

import Foundation

struct Currently: Codable {
    let time: Int?
    let summary, icon, precipType: String?
    let precipIntensity, precipProbability: Double?
    let temperature, apparentTemperature, dewPoint, humidity: Double?
    let pressure, windSpeed, windGust: Double?
    var precipProbabilityPercentage: Int? {
        guard let precipProb = precipProbability else {
            return nil
        }
        return Int(precipProb * 100.0)
    }
    var humitdityPercentage: Int? {
        guard let humidity = humidity else {
            return nil
        }
        return Int(humidity * 100.0)
    }
}
