//
//  WeatherDetailTableViewCell.swift
//  WeatherReporter
//
//  Created by Shekhar Dahore on 08/07/20.
//  Copyright © 2020 Shekkhar. All rights reserved.
//

import UIKit

class WeatherDetailTableViewCell: UITableViewCell, Reusable {
    
    var lblTitle: UILabel = {
        let label: UILabel = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = label.font.withSize(14)
        label.textColor = .darkGray
        label.numberOfLines = 1
        return label
    }()
    
    var lblValue: UILabel = {
        let label: UILabel = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        label.font = label.font.withSize(14)
        label.numberOfLines = 1
        return label
    }()
    
    var cellModel: WeatherViewModelItem? {
        didSet {
            guard let model = cellModel as? WeatherDetailViewModel else {
                return
            }
            lblTitle.text = model.titleText
            lblValue.text = model.valueText
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
        contentView.addSubview(lblTitle)
        contentView.addSubview(lblValue)
        
        let marginGuide = contentView.layoutMarginsGuide
        
        lblTitle.centerYAnchor.constraint(equalTo: marginGuide.centerYAnchor).isActive = true
        lblTitle.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor, constant: 24).isActive = true
        
        lblValue.centerYAnchor.constraint(equalTo: marginGuide.centerYAnchor).isActive = true
        lblValue.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor, constant: -24).isActive = true
    }
}
