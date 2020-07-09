//
//  Date+Extensions.swift
//  WeatherReporter
//
//  Created by Shekhar Dahore on 09/07/20.
//  Copyright © 2020 Shekkhar. All rights reserved.
//

import Foundation

extension Date {
    
    /// Converts the date to string to display in the WeatherSummaryTableViewCell
    var inDisplaySummaryFormat: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMM d, yyyy"
        return dateFormatter.string(from: self)
    }
}
