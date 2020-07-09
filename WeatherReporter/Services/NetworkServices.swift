//
//  NetworkServices.swift
//  WeatherReporter
//
//  Created by Shekhar Dahore on 06/07/20.
//  Copyright © 2020 Shekkhar. All rights reserved.
//

import Moya

enum WeatherReporterService {
    case getWeather(latitude: String, longitude: String)
}

extension WeatherReporterService: TargetType {
        
    var baseURL: URL {
        switch self {
        case .getWeather(_):
            return URL(string: "https://api.darksky.net")!
        }
    }
    var path: String {
        switch self {
        case .getWeather(let latitude, let longitude):
            return "/forecast/\(DarkSkyAPI.token)/\(latitude),\(longitude)"
        }
    }
    var method: Method {
        switch self {
        case .getWeather(_):
            return .get
        }
    }
    var task: Task {
        switch self {
        default:
            return .requestParameters(parameters: ["units": "si"] , encoding: URLEncoding.queryString)
        }
    }
    var sampleData: Data {
        switch self {
        case .getWeather(_):
            var details: [String: Any] = [:]
            details["id"] = 3122
            details["profile_pic"] = ""
            details["favorite"] = false
            let contact = try? JSONSerialization.data(withJSONObject: details, options: .prettyPrinted)
            return contact ?? Data()
        }
    }
    var headers: [String : String]? {
        return ["Content-Type":"application/json"]
    }
    
    var validationType: ValidationType {
        return .successCodes
    }
}
