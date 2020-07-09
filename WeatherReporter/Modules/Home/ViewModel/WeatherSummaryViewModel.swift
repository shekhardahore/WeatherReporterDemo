//
//  WeatherSummaryViewModel.swift
//  WeatherReporter
//
//  Created by Shekhar Dahore on 08/07/20.
//  Copyright © 2020 Shekkhar. All rights reserved.
//

import Foundation

final class WeatherSummaryViewModel: WeatherViewModelItem {
    
    var summaryText: String
    var tempratureText: String = "--"
    var dateText: String
    var type: WeatherViewModelItemType {
        return .summary
    }
    
    init(data: Weather) {
        summaryText = data.currently?.summary ?? "--"
        if let temp = data.currently?.temperature {
            tempratureText = MeasurementFormatter.getLocalizedTextFor(temperature: temp)
        }
        dateText = Date().inDisplaySummaryFormat
    }
}
