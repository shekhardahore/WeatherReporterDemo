//
//  Constants.swift
//  WeatherReporter
//
//  Created by Shekhar Dahore on 07/07/20.
//  Copyright © 2020 Shekkhar. All rights reserved.
//

import Foundation

struct DarkSkyAPI {
    static let token = "2bb07c3bece89caf533ac9a5d23d8417"
}

enum WRErrors: Error {
    case valueNotFound
}

extension WRErrors: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .valueNotFound:
            return "Requested value not found".localizedString
        }
    }
}
