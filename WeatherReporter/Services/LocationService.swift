//
//  LocationService.swift
//  WeatherReporter
//
//  Created by Shekhar Dahore on 10/07/20.
//  Copyright © 2020 Shekkhar. All rights reserved.
//

import Foundation
import CoreLocation

protocol LocationProvider {
    func retriveCurrentLocation()
    var delegate: LocationServiceDelegate? { get set }
}


class LocationService: NSObject, LocationProvider {
    
    weak var delegate: LocationServiceDelegate?
    let locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.desiredAccuracy = kCLLocationAccuracyKilometer
        return manager
    }()
    
    override init() {
        super.init()
        locationManager.delegate = self
    }
    
    /// Requests for current location if available
    func retriveCurrentLocation() {
        let status = CLLocationManager.authorizationStatus()
        if status == .denied || status == .restricted || !CLLocationManager.locationServicesEnabled() {
            DispatchQueue.main.async { [weak self] in
                self?.delegate?.failedToFetchLocation(error: ErrorMessages.locationServiceDiabled)
                return
            }
        }
        if status == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
            return
        }
        locationManager.requestLocation()
    }
    
}

extension LocationService: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if(status == .authorizedWhenInUse || status == .authorizedAlways){
            manager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        if let error = error as? CLError, error.code == .denied {
            DispatchQueue.main.async { [weak self] in
                self?.delegate?.failedToFetchLocation(error: ErrorMessages.locationServiceDiabled)
                return
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            let latitude = "\(location.coordinate.latitude)"
            let longitude = "\(location.coordinate.longitude)"
            delegate?.didFetchLocation(latitude: latitude, longitude: longitude)
        }
    }
}
