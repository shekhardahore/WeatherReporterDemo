//
//  AlertDisplayable.swift
//  WeatherReporter
//
//  Created by Shekhar Dahore on 08/07/20.
//  Copyright © 2020 Shekkhar. All rights reserved.
//

import UIKit

protocol AlertDisplayable {
    func displayAlertWith(title: String, message: String)
    func displaySettingsAlertWith(title: String, message: String)
}

extension AlertDisplayable where Self: UIViewController {
    /// Display Alert
    ///
    /// - Parameters:
    ///   - title: title of alert
    ///   - message: message of alert
    func displayAlertWith(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true)
    }
    
    
    /// Display Alert with settings redirect.
    ///
    /// - Parameters:
    ///   - title: title of alert
    ///   - message: message of alert
    func displaySettingsAlertWith(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let settingsAction = UIAlertAction(title: "Open Settings", style: .destructive) { (_) -> Void in
            let settingsUrl = NSURL(string: UIApplication.openSettingsURLString)
            if let url = settingsUrl {
                UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
            }
        }
        alertController.addAction(settingsAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }
}
