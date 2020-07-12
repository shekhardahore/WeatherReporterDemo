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
    var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()
    var lblInfo: UILabel = {
        let label: UILabel = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        label.font = label.font.withSize(14)
        label.numberOfLines = 1
        label.text = "Waiting for location...".localizedString
        return label
    }()
    var btnRefresh: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Refresh", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.setTitleColor(.blue, for: .normal)
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
        viewModel.weatherUpdated = { [weak self] () in
            guard let `self` = self else {
                return
            }
            self.activityIndicator.stopAnimating()
            self.showWeather()
        }
        viewModel.showAlertClosure = { [weak self] () in
            self?.activityIndicator.stopAnimating()
            self?.btnRefresh.isHidden = false
            self?.displayAlertWith(title: "Error".localizedString, message: self?.viewModel.alertMessage ?? ErrorMessages.serverFailed)
        }
        viewModel.fetchWeatherForCurrentLocation()
    }
    
    /// Sets up the default UI
    func setupUI() {
        view.backgroundColor = .systemBackground
        activityIndicator.center = view.center
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
        view.addSubview(lblInfo)
        view.addSubview(btnRefresh)
        view.addSubview(tableView)
        btnRefresh.isHidden = true
        tableView.isHidden = true
        lblInfo.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        lblInfo.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -32).isActive = true
        btnRefresh.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        btnRefresh.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        btnRefresh.heightAnchor.constraint(equalToConstant: 44).isActive = true
        btnRefresh.widthAnchor.constraint(equalToConstant: 50).isActive = true

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
        activityIndicator.startAnimating()
    }
}
