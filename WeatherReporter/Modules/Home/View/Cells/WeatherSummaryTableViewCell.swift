//
//  WeatherSummaryTableViewCell.swift
//  WeatherReporter
//
//  Created by Shekhar Dahore on 08/07/20.
//  Copyright © 2020 Shekkhar. All rights reserved.
//

import UIKit

final class WeatherSummaryTableViewCell: UICollectionViewCell, Reusable {
 
    private var lblSummary: UILabel = {
        let label: UILabel = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = label.font.withSize(14)
        label.numberOfLines = 1
        return label
    }()
    private var lblTemperature: UILabel = {
        let label: UILabel = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = label.font.withSize(34)
        label.numberOfLines = 1
        return label
    }()
    private var lblDate: UILabel = {
        let label: UILabel = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = label.font.withSize(14)
        label.numberOfLines = 1
        return label
    }()
    
    var cellModel: WeatherSummaryCellViewModel? {
        didSet {
            guard let model = cellModel else {
                return
            }
            lblSummary.text = model.summaryText
            lblTemperature.text = model.tempratureText
            lblDate.text = model.dateText
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
         setupUI()
    }
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        
        contentView.addSubviews(lblSummary, lblTemperature, lblDate)

        let marginGuide = contentView.layoutMarginsGuide
        
        NSLayoutConstraint.activate([
            lblSummary.centerXAnchor.constraint(equalTo: marginGuide.centerXAnchor),
            lblSummary.topAnchor.constraint(equalTo: marginGuide.topAnchor, constant: 50),
            
            lblTemperature.centerXAnchor.constraint(equalTo: marginGuide.centerXAnchor),
            lblTemperature.topAnchor.constraint(equalTo: lblSummary.bottomAnchor, constant: 16),
            
            lblDate.centerXAnchor.constraint(equalTo: marginGuide.centerXAnchor),
            lblDate.topAnchor.constraint(equalTo: lblTemperature.bottomAnchor, constant: 16),
            lblDate.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor, constant: -32)
        ])
    }
}
