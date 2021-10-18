//
//  AlertHelper.swift
//  BreatheMe
//
//  Created by Denis Kovalev on 17.10.2021.
//

import UIKit

class AlertHelper {

    static func showErrorAlertWith(message: String? = nil,
                                   target: UIViewController,
                                   buttonTitle: String = "OK",
                                   buttonAction: (() -> Void)? = nil) {
        let controller = UIAlertController(title: "Something went wrong", message: message, preferredStyle: .alert)
        controller.addAction(UIAlertAction(title: buttonTitle, style: .default, handler: { _ in buttonAction?() }))
        target.present(controller, animated: true, completion: nil)
    }

}
