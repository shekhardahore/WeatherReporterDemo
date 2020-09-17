//
//  AlertDisplayable.swift
//  WeatherReporter
//
//  Created by Shekhar Dahore on 08/07/20.
//  Copyright © 2020 Shekkhar. All rights reserved.
//

import UIKit


protocol AlertDisplayable {
    func displayAlertWith(title: String?, message: String?)
}

extension AlertDisplayable where Self: UIViewController {
    /// Display Alert
    ///
    /// - Parameters:
    ///   - title: title of alert
    ///   - message: message of alert
    func displayAlertWith(title: String?, message: String?) {
        let message: String = message ?? ErrorMessages.defaultError.rawValue
        if ErrorMessages(rawValue: message) == ErrorMessages.locationServiceDiabled {
            displayAlertWithSettingsOption()
        } else {
            let alertController = UIAlertController(title: nil, message: message.localizedString, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alertController.addAction(okAction)
            DispatchQueue.main.async {
                self.present(alertController, animated: true)
            }
        }
    }
    
    
    /// Display Alert with settings redirect.
    private func displayAlertWithSettingsOption() {
        let alertController = UIAlertController(title: title, message: ErrorMessages.locationServiceDiabled.rawValue.localizedString, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel".localizedString, style: .cancel, handler: nil)
        let settingsAction = UIAlertAction(title: "Open Settings".localizedString, style: .destructive) { (_) -> Void in
            let settingsUrl = NSURL(string: UIApplication.openSettingsURLString)
            if let url = settingsUrl {
                DispatchQueue.main.async {
                    UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
                }
            }
        }
        alertController.addAction(settingsAction)
        alertController.addAction(cancelAction)
        DispatchQueue.main.async {
            self.present(alertController, animated: true)
        }
    }
}
