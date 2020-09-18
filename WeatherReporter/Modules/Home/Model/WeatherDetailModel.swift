//
//  WeatherDetailModel.swift
//  WeatherReporter
//
//  Created by Shekhar Dahore on 18/09/20.
//  Copyright © 2020 Shekkhar. All rights reserved.
//

import Foundation

struct WeatherDetailModel: Hashable {
    let id: UUID
    let type: WeatherDetailType
    
    init(type: WeatherDetailType) {
        id = UUID()
        self.type = type
    }
}
