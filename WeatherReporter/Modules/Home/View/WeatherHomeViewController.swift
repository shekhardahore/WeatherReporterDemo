//
//  ViewController.swift
//  WeatherReporter
//
//  Created by Shekhar Dahore on 02/07/20.
//  Copyright © 2020 Shekkhar. All rights reserved.
//

import UIKit

final class WeatherHomeViewController: UIViewController, AlertDisplayable {

    var viewModel: WeatherHomeViewModel
    var lblInfo: UILabel = {
        let label: UILabel = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = label.font.withSize(17)
        label.numberOfLines = 0
        label.text = "Waiting for location...".localizedString
        return label
    }()
    
    var btnRefresh: WRButton = {
        let button = WRButton(title: "Refresh".localizedString)
        button.addTarget(self, action: #selector(WeatherHomeViewController.onRefresh(_:)), for: .touchUpInside)
        return button
    }()
    
    var tableView: WeatherTableView
    
    init(viewModel: WeatherHomeViewModel) {
        self.viewModel = viewModel
        self.tableView = WeatherTableView(viewModel: self.viewModel.weatherTableViewViewModel)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel.weatherUpdated = { [weak self] in
            guard let `self` = self else {
                return
            }
            self.hideSpinner()
            self.showWeather()
        }
        viewModel.showAlertClosure = { [weak self] in
            self?.hideSpinner()
            self?.btnRefresh.isHidden = false
            self?.displayAlertWith(title: "Error".localizedString, message: self?.viewModel.alertMessage ?? ErrorMessages.serverFailed)
        }
        viewModel.fetchWeatherForCurrentLocation()
    }
    
    /// Sets up the default UI
    func setupUI() {
        view.backgroundColor = .systemBackground
        showSpinner()
        view.addSubview(lblInfo)
        view.addSubview(tableView)
        view.addSubview(btnRefresh)
        btnRefresh.isHidden = true
        tableView.isHidden = true
        
        let margin = view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            lblInfo.leadingAnchor.constraint(equalTo: margin.leadingAnchor),
            lblInfo.trailingAnchor.constraint(equalTo: margin.trailingAnchor),
            lblInfo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            lblInfo.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -75),
            
            btnRefresh.topAnchor.constraint(equalTo: lblInfo.bottomAnchor, constant: 20),
            btnRefresh.leadingAnchor.constraint(equalTo: margin.leadingAnchor, constant: 20),
            btnRefresh.trailingAnchor.constraint(equalTo: margin.trailingAnchor, constant: -20),
            btnRefresh.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    /// Updates the UI with the weather data
    func showWeather() {
        tableView.isHidden = false
    }
    
    @objc func onRefresh(_ sender: UIButton) {
        viewModel.fetchWeatherForCurrentLocation()
        btnRefresh.isHidden = true
        showSpinner()
    }
}
