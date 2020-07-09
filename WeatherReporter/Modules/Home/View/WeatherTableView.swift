//
//  WeatherTableView.swift
//  WeatherReporter
//
//  Created by Shekhar Dahore on 08/07/20.
//  Copyright © 2020 Shekkhar. All rights reserved.
//

import UIKit

class WeatherTableView: UITableView {
    
    var data: [[WeatherViewModelItem]]? {
        didSet {
            reloadData()
        }
    }
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        registerReusableCell(WeatherSummaryTableViewCell.self)
        registerReusableCell(WeatherDetailTableViewCell.self)
        dataSource = self
        estimatedRowHeight = 64.0
        rowHeight = UITableView.automaticDimension
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension WeatherTableView: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data?[section].count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let item = data?[indexPath.section][indexPath.row] else {
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
