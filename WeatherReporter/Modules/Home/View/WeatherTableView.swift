//
//  WeatherTableView.swift
//  WeatherReporter
//
//  Created by Shekhar Dahore on 08/07/20.
//  Copyright © 2020 Shekkhar. All rights reserved.
//

import UIKit

final class WeatherTableView: UITableView {
    
    var viewModel: WeatherTableViewViewModel
    var weatherRefreshControl = UIRefreshControl()
    
    init(viewModel: WeatherTableViewViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero, style: .plain)
        setupTableView()
        viewModel.updateTableView = { [weak self] in
            guard let `self` = self else {
                return
            }
            self.weatherRefreshControl.endRefreshing()
            self.reloadData()
        }
    }
    
    func setupTableView() {
        dataSource = self
        translatesAutoresizingMaskIntoConstraints = false
        insetsContentViewsToSafeArea = true
        estimatedRowHeight = 64.0
        rowHeight = UITableView.automaticDimension
        tableFooterView = UIView()
        weatherRefreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        addSubview(weatherRefreshControl)
        registerReusableCell(WeatherSummaryTableViewCell.self)
        registerReusableCell(WeatherDetailTableViewCell.self)
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func refresh(_ sender: AnyObject) {
        viewModel.updateWeather()
    }

}

extension WeatherTableView: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.tableViewCellViewModels?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.tableViewCellViewModels?[section].count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let item = viewModel.tableViewCellViewModels?[indexPath.section][indexPath.row] else {
            let cell = UITableViewCell()
            return cell
        }
        switch item.type {
        case .summary:
            let cell = tableView.dequeueReusableCell(indexPath: indexPath) as WeatherSummaryTableViewCell
            cell.cellModel = item
            return cell
        case .detail:
            let cell = tableView.dequeueReusableCell(indexPath: indexPath) as WeatherDetailTableViewCell
            cell.cellModel = item
            return cell
        }
    }
}
