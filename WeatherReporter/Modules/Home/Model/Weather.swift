//
//  Weather.swift
//  WeatherReporter
//
//  Created by Shekhar Dahore on 07/07/20.
//  Copyright © 2020 Shekkhar. All rights reserved.
//

import Foundation

struct Weather: Codable {
    let latitude, longitude: Double?
    let timezone: String?
    let currently: Currently?
}
