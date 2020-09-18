//
//  DependencyFactory.swift
//  WeatherReporter
//
//  Created by Shekhar Dahore on 18/09/20.
//  Copyright © 2020 Shekkhar. All rights reserved.
//

import Foundation
import Moya

protocol Factory {
    var networkManager: MoyaProvider<WeatherReporterService> { get }
    var locationManager: LocationProvider { get }
    func makeInitialViewController() -> WeatherHomeViewController
    func makeInitialViewModel() -> WeatherHomeViewModel
}

class DependencyFactory: Factory {
    
    func makeInitialViewController() -> WeatherHomeViewController {
        let viewModel = makeInitialViewModel()
        let initialViewController = WeatherHomeViewController(viewModel: viewModel)
        return initialViewController
    }
    
    var networkManager: MoyaProvider<WeatherReporterService> = ProcessInfo.processInfo.arguments.contains("UITesting") ? MoyaProvider<WeatherReporterService>(stubClosure: MoyaProvider.immediatelyStub) : MoyaProvider<WeatherReporterService>()
    var locationManager: LocationProvider = LocationService()
    
    func makeInitialViewModel() -> WeatherHomeViewModel {
        let viewModel = WeatherHomeViewModel(networkProvider: networkManager, locationProvider: locationManager)
        return viewModel
    }
}
