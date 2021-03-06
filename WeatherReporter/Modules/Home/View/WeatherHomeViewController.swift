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
    
    var dataSource: UICollectionViewDiffableDataSource<Section, DataItem>! = nil
        
    var homeCollectionView: UICollectionView = {
        var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout.init())
        collectionView.backgroundColor = .systemBackground
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        return collectionView
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
        setupUI()
        viewModel.weatherUpdated = { [weak self] in
            guard let `self` = self else { return }
            DispatchQueue.main.async {
                self.hideSpinner()
                self.showWeather()
            }
        }
        viewModel.showAlertClosure = { [weak self] in
            guard let `self` = self else { return }
            self.hideSpinner()
            self.btnRefresh.isHidden = false
            self.displayAlertWith(title: nil, message: self.viewModel.alertMessage)
        }
        viewModel.fetchWeatherForCurrentLocation()
    }
    
    /// Sets up the default UI
    func setupUI() {
        view.backgroundColor = .systemBackground
        showSpinner()
        view.addSubviews(lblInfo, btnRefresh)
        btnRefresh.isHidden = true
        
        let margin = view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            lblInfo.leadingAnchor.constraint(equalTo: margin.leadingAnchor),
            lblInfo.trailingAnchor.constraint(equalTo: margin.trailingAnchor),
            lblInfo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            lblInfo.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -75),
            
            btnRefresh.topAnchor.constraint(equalTo: lblInfo.bottomAnchor, constant: 20),
            btnRefresh.leadingAnchor.constraint(equalTo: margin.leadingAnchor, constant: 20),
            btnRefresh.trailingAnchor.constraint(equalTo: margin.trailingAnchor, constant: -20),
            btnRefresh.heightAnchor.constraint(equalToConstant: 50),
        ])
    }

    @objc func onRefresh(_ sender: UIButton) {
        viewModel.fetchWeatherForCurrentLocation()
        btnRefresh.isHidden = true
        showSpinner()
    }
}
