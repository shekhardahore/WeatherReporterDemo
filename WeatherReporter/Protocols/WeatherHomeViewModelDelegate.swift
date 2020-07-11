//
//  WeatherHomeViewModelDelegate.swift
//  WeatherReporter
//
//  Created by Shekhar Dahore on 11/07/20.
//  Copyright © 2020 Shekkhar. All rights reserved.
//

import Foundation

protocol WeatherHomeViewModelDelegate: class {
    /// Asks WeatherHomeViewModel to update weather data.
    func updateWeatherData()
}
