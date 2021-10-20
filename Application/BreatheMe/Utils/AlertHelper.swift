//
//  AlertHelper.swift
//  BreatheMe
//
//  Created by Denis Kovalev on 17.10.2021.
//

import UIKit

/// A helper class for presenting different alerts
class AlertHelper {

    /// Shows errror alert with "Something went wrong" title
    static func showErrorAlertWith(message: String? = nil,
                                   target: UIViewController,
                                   buttonTitle: String = "Alert-Button-OK".localized(),
                                   buttonAction: (() -> Void)? = nil) {
        let controller = UIAlertController(title: "Alert-Error-Title".localized(), message: message, preferredStyle: .alert)
        controller.addAction(UIAlertAction(title: buttonTitle, style: .default, handler: { _ in buttonAction?() }))
        target.present(controller, animated: true, completion: nil)
    }

}
