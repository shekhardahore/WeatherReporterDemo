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

struct ErrorMessages {
    static let locationServiceDiabled = "We need your location. Please make sure in the Settings app you have given us permission to use your location details."
    static let dataParsing = "Cannot parse data.Please try again later."
    static let serverFailed = "There seems to be an issue with the service. Please try again."

}
