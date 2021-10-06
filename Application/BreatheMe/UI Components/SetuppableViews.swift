//
//  SetuppableViews.swift
//  BreatheMe
//
//  Created by Denis Kovalev on 06.10.2021.
//

import UIKit

// MARK: - UIView

class SetuppableView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    /// Proceeds view's initialization logic. override for basic configuration.
    func setup() {}
}

// MARK: - UI Button

class SetuppableButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    /// Proceeds view's initialization logic. override for basic configuration.
    func setup() {}
}
