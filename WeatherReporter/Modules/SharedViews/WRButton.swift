//
//  WRButton.swift
//  WeatherReporter
//
//  Created by Shekhar Dahore on 17/09/20.
//  Copyright © 2020 Shekkhar. All rights reserved.
//

import UIKit

final class WRButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(backgroundColor: UIColor = .systemGreen, title: String) {
        self.init(frame: .zero)
        self.backgroundColor = backgroundColor
        setTitle(title, for: .normal)
    }
    
    private func configure() {
        layer.cornerRadius = 10
        layer.masksToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        setTitleColor(.systemFill, for: .highlighted)
    }
}
