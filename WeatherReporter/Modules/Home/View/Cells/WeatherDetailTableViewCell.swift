//
//  WeatherDetailTableViewCell.swift
//  WeatherReporter
//
//  Created by Shekhar Dahore on 08/07/20.
//  Copyright © 2020 Shekkhar. All rights reserved.
//

import UIKit

final class WeatherDetailTableViewCell: UICollectionViewCell, Reusable {
    
    private var lblTitle: UILabel = {
        let label: UILabel = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = label.font.withSize(14)
        label.textColor = .darkGray
        label.numberOfLines = 1
        return label
    }()
    
    private var lblValue: UILabel = {
        let label: UILabel = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        label.font = label.font.withSize(14)
        label.numberOfLines = 1
        return label
    }()
    
    var cellModel: WeatherDetailCellViewModel? {
        didSet {
            guard let model = cellModel else {
                return
            }
            lblTitle.text = model.titleText
            lblValue.text = model.valueText
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
        
        contentView.addSubviews(lblTitle, lblValue)
        
        let marginGuide = contentView.layoutMarginsGuide
        NSLayoutConstraint.activate([
            lblTitle.topAnchor.constraint(equalTo: marginGuide.topAnchor),
            lblTitle.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor, constant: 24),
            lblTitle.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor),
            lblValue.centerYAnchor.constraint(equalTo: lblTitle.centerYAnchor),
            lblValue.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor, constant: -24),
        ])
        let spacingConstraint = lblTitle.trailingAnchor.constraint(equalTo: lblValue.leadingAnchor, constant: 5)
        spacingConstraint.priority = UILayoutPriority(rawValue: 500)
        spacingConstraint.isActive = true
        lblValue.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        lblValue.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
    }
}
