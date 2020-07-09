//
//  ViewController.swift
//  WeatherReporter
//
//  Created by Shekhar Dahore on 02/07/20.
//  Copyright © 2020 Shekkhar. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherHomeViewController: UIViewController, AlertDisplayable {
    
    let locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.desiredAccuracy = kCLLocationAccuracyKilometer
        return manager
    }()

    var viewModel: WeatherHomeViewModel
    var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()
    var infoLable: UILabel = {
        let label: UILabel = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        label.font = label.font.withSize(14)
        label.numberOfLines = 1
        label.text = "Waiting for location...".localizedString
        return label
    }()
    var tableView: WeatherTableView = {
        let tableView = WeatherTableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.insetsContentViewsToSafeArea = true
        tableView.tableFooterView = UIView()
        return tableView
    }()
    
    init(viewModel: WeatherHomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupDefaultUI()
        retriveCurrentLocation()
    }
    
    /// Requests for current location if available
    func retriveCurrentLocation(){
        let status = CLLocationManager.authorizationStatus()
        if status == .denied || status == .restricted || !CLLocationManager.locationServicesEnabled() {
            DispatchQueue.main.async { [weak self] in
                self?.displaySettingsAlert(with: "Location Error".localizedString, message: "We need your location. Please make sure in the Settings app you have given us permission to use your location details.".localizedString)
                self?.activityIndicator.stopAnimating()
                return
            }
        }
        if status == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
            return
        }
        locationManager.requestLocation()
    }
    
    /// Sets up the default UI
    func setupDefaultUI() {
        view.backgroundColor = .systemBackground
        activityIndicator.center = view.center
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
        view.addSubview(infoLable)
        
        infoLable.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        infoLable.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -32).isActive = true
    }
    
    /// Sets up the table view once data is avaliable
    func setupWeatherUI() {
        view.addSubview(tableView)
        activityIndicator.center = view.center
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    /// Updates the UI with the weather data
    func showWeather() {
        tableView.data = viewModel.getDisplayViewModels()
    }

    /// Fetches weather details from server and updates the viewModel
    ///
    /// - Parameters:
    ///   - latitude: latitude of the location
    ///   - longitude: longitude of the loaction
    func fetchWeather(latitude: String, longitude: String) {
        viewModel.fetchWeatherForCurrentLocation(latitude: latitude, logintude: longitude) { (success, error) in
            guard success else {
                DispatchQueue.main.async { [weak self] in
                    self?.activityIndicator.stopAnimating()
                    self?.displayAlert(with: "Error".localizedString, message: error ?? "")
                }
                return
            }
            DispatchQueue.main.async { [weak self] in
                guard let `self` = self else {
                    return
                }
                self.activityIndicator.stopAnimating()
                self.setupWeatherUI()
                self.showWeather()
            }
        }
    }
}

extension WeatherHomeViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if(status == .authorizedWhenInUse || status == .authorizedAlways){
            manager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            let latitude = "\(location.coordinate.latitude)"
            let longitude = "\(location.coordinate.longitude)"
            fetchWeather(latitude: latitude, longitude: longitude)
        }
    }
}
