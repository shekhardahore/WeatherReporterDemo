//
//  WeatherSummaryCellViewModel.swift
//  WeatherReporter
//
//  Created by Shekhar Dahore on 08/07/20.
//  Copyright © 2020 Shekkhar. All rights reserved.
//

import Foundation

final class WeatherSummaryCellViewModel {
    
    var summaryText: String
    var tempratureText: String = "--"
    var dateText: String
    
    init(data: WeatherSummaryModel) {
        summaryText = data.summary ?? "--"
        if let temp = data.temperature {
            tempratureText = MeasurementFormatter.getLocalizedTextFor(temperature: temp)
        }
        dateText = Date().inDisplaySummaryFormat
    }
}
