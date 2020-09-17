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

enum ErrorMessages: String {
    case locationServiceDiabled = "Uh oh, we need your location to give you accurate weather report. Please make sure in the Settings app you have given us permission to use your location."
    case locationServiceFailed = "Uh oh, we couldn't find your location."
    case defaultError = "Uh oh, something doesn't seem right. Please try again."
    case serverFailed = "Uh oh, we couldn't connect to our servers, please check the network or try again later."

}
