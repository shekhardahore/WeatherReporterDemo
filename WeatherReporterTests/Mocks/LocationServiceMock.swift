//
//  LocationServiceMock.swift
//  WeatherReporter
//
//  Created by Shekhar Dahore on 12/07/20.
//  Copyright © 2020 Shekkhar. All rights reserved.
//

import Foundation

class LocationServiceMock: LocationProvider {
    weak var delegate: LocationServiceDelegate?
    
    func retriveCurrentLocation() {
        delegate?.didFetchLocation(latitude: "12.321", longitude: "421.421")
    }
}
