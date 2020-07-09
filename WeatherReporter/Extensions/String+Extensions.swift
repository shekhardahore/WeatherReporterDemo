//
//  String+Extensions.swift
//  WeatherReporter
//
//  Created by Shekhar Dahore on 09/07/20.
//  Copyright © 2020 Shekkhar. All rights reserved.
//

import Foundation

extension String {
    var localizedString: String {
        return NSLocalizedString(self, comment: "")
    }
}
