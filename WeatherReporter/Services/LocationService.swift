//
//  LocationService.swift
//  WeatherReporter
//
//  Created by Shekhar Dahore on 10/07/20.
//  Copyright © 2020 Shekkhar. All rights reserved.
//

import Foundation
import CoreLocation

class LocationService: NSObject {
    
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
    func retriveCurrentLocation(){
        let status = CLLocationManager.authorizationStatus()
        if status == .denied || status == .restricted || !CLLocationManager.locationServicesEnabled() {
            DispatchQueue.main.async { [weak self] in
                self?.delegate?.failedToFetchLocation(error: "We need your location. Please make sure in the Settings app you have given us permission to use your location details.".localizedString)
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
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            let latitude = "\(location.coordinate.latitude)"
            let longitude = "\(location.coordinate.longitude)"
            delegate?.didFetchLocation(latitude: latitude, longitude: longitude)
        }
    }
}
