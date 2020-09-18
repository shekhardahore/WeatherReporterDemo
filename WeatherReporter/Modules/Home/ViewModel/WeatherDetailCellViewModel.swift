//
//  WeatherDetailCellViewModel.swift
//  WeatherReporter
//
//  Created by Shekhar Dahore on 18/09/20.
//  Copyright © 2020 Shekkhar. All rights reserved.
//

import Foundation

final class WeatherDetailCellViewModel {
    
    var titleText: String = ""
    var valueText: String = ""
    
    init(data: WeatherDetailModel) {
        titleText = data.type.getTitle()
        valueText = data.type.getValue()
    }
}
