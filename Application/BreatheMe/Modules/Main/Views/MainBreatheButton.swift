//
//  MainBreatheButton.swift
//  BreatheMe
//
//  Created by Denis Kovalev on 06.10.2021.
//

import Foundation

class MainBreatheButton: SetuppableButton {

    // MARK: - UI Lifecycle

    override func setup() {
        super.setup()

        setTitle("Main-Breathe-Button-Title".localized(), for: .normal)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        layer.cornerRadius = bounds.height / 2
    }

}
