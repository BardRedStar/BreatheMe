//
//  MainBreatheButton.swift
//  BreatheMe
//
//  Created by Denis Kovalev on 06.10.2021.
//

import UIKit

/// A button for breathe action on main screen
class MainBreatheButton: SetuppableButton {

    // MARK: - UI Lifecycle

    override func setup() {
        super.setup()

        setTitle("Main-Breathe-Button-Title".localized(), for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 20)
        titleLabel?.textColor = UIColor(named: "primary")

        layer.borderWidth = 1
        layer.borderColor = UIColor(named: "border")?.cgColor
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        layer.cornerRadius = bounds.height / 2
    }

}
