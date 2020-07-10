//
//  LocationDelegate.swift
//  WeatherReporter
//
//  Created by Shekhar Dahore on 10/07/20.
//  Copyright © 2020 Shekkhar. All rights reserved.
//

import Foundation

protocol LocationServiceDelegate: class {
    func didFetchLocation(latitude: String, longitude: String)
    func failedToFetchLocation(error: String) 
}
