//
//  ViewController.swift
//  WeatherReporter
//
//  Created by Shekhar Dahore on 02/07/20.
//  Copyright © 2020 Shekkhar. All rights reserved.
//

import UIKit

class WeatherHomeViewController: UIViewController, AlertDisplayable {

    var viewModel: WeatherHomeViewModel
    var refreshControl = UIRefreshControl()
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
        setupDefaultUI()
        viewModel.weatherUpdated = { [weak self] () in
            guard let `self` = self else {
                return
            }
            self.activityIndicator.stopAnimating()
            self.setupWeatherUI()
            self.showWeather()
        }
        viewModel.showAlertClosure = { [weak self] () in
            self?.activityIndicator.stopAnimating()
            self?.displayAlertWith(title: "Error".localizedString, message: self?.viewModel.alertMessage ?? "")
        }
        viewModel.fetchWeatherForCurrentLocation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
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
    
    @objc func refresh(_ sender: AnyObject) {
        viewModel.fetchWeatherForCurrentLocation()
    }
}
