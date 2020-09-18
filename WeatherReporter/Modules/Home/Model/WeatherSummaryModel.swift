//
//  WeatherSummaryModel.swift
//  WeatherReporter
//
//  Created by Shekhar Dahore on 18/09/20.
//  Copyright © 2020 Shekkhar. All rights reserved.
//

import Foundation

struct WeatherSummaryModel: Hashable {
    let id: UUID
    let summary: String?
    let temperature: Double?
    
    init(data: Weather?) {
        id = UUID()
        summary = data?.currently.summary
        temperature = data?.currently.temperature
    }
}
