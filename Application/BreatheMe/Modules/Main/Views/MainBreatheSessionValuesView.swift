//
//  MainBreatheSessionValuesView.swift
//  BreatheMe
//
//  Created by Denis Kovalev on 20.10.2021.
//

import UIKit

/// A view with session statistics
class MainBreatheSessionValuesView: SetuppableView {

    // MARK: - Definitions

    struct ViewModel {
        let inhales: Int
        let exhales: Int
    }

    // MARK: - UI Controls

    private lazy var inhalesLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        label.textColor = UIColor(named: "primary")
        label.numberOfLines = 1
        return label
    }()

    private lazy var exhalesLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        label.textColor = UIColor(named: "primary")
        label.numberOfLines = 1
        return label
    }()

    // MARK: - UI Lifecycle

    override func setup() {
        super.setup()

        backgroundColor = .clear

        addSubview(inhalesLabel)
        addSubview(exhalesLabel)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        inhalesLabel.sizeToFit()
        exhalesLabel.sizeToFit()

        inhalesLabel.frame.origin = CGPoint(x: 10, y: 30)
        exhalesLabel.frame.origin = CGPoint(x: bounds.width - 10 - exhalesLabel.frame.width, y: 30)
    }

    // MARK: - UI Methods

    func configureWith(model: ViewModel) {
        inhalesLabel.text = "SessionList-Inhales-Label".localized() + "\(model.inhales)"
        exhalesLabel.text = "SessionList-Exhales-Label".localized() + "\(model.exhales)"

        setNeedsLayout()
        layoutIfNeeded()
    }
}
