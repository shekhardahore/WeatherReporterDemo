//
//  WeatherSummaryTableViewCell.swift
//  WeatherReporter
//
//  Created by Shekhar Dahore on 08/07/20.
//  Copyright © 2020 Shekkhar. All rights reserved.
//

import UIKit

class WeatherSummaryTableViewCell: UITableViewCell, Reusable {
 
    var lblSummary: UILabel = {
        let label: UILabel = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = label.font.withSize(14)
        label.numberOfLines = 1
        return label
    }()
    var lblTemperature: UILabel = {
        let label: UILabel = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = label.font.withSize(34)
        label.numberOfLines = 1
        return label
    }()
    var lblDate: UILabel = {
        let label: UILabel = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = label.font.withSize(14)
        label.numberOfLines = 1
        return label
    }()
    
    var cellModel: WeatherViewModelItem? {
        didSet {
            guard let model = cellModel as? WeatherSummaryViewModel else {
                return
            }
            lblSummary.text = model.summaryText
            lblTemperature.text = model.tempratureText
            lblDate.text = model.dateText
        }
    }
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        
        selectionStyle = .none
        contentView.addSubview(lblSummary)
        contentView.addSubview(lblTemperature)
        contentView.addSubview(lblDate)
        
        let marginGuide = contentView.layoutMarginsGuide
        
        lblSummary.centerXAnchor.constraint(equalTo: marginGuide.centerXAnchor).isActive = true
        lblSummary.topAnchor.constraint(equalTo: marginGuide.topAnchor, constant: 50).isActive = true
        
        lblTemperature.centerXAnchor.constraint(equalTo: marginGuide.centerXAnchor).isActive = true
        lblTemperature.topAnchor.constraint(equalTo: lblSummary.bottomAnchor, constant: 16).isActive = true
        
        lblDate.centerXAnchor.constraint(equalTo: marginGuide.centerXAnchor).isActive = true
        lblDate.topAnchor.constraint(equalTo: lblTemperature.bottomAnchor, constant: 16).isActive = true
        lblDate.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor, constant: -32).isActive = true
    }
}
