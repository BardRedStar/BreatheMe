//
//  SessionListTableHeaderView.swift
//  BreatheMe
//
//  Created by Denis Kovalev on 16.10.2021.
//

import UIKit

/// A class for header on sessions list screen
class SessionListTableHeaderView: SetuppableTableHeaderFooterView {
    // MARK: - Definitions

    /// Constants
    enum Constants {
        /// A reuse identifier for current header class
        static let reuseIdentifier = "SessionListTableHeaderView"
        /// Inset for label content from borders
        static let contentInset = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
    }

    // MARK: - UI Controls

    private lazy var blurBackgroundView: UIVisualEffectView = {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .extraLight))
        view.alpha = 0.7
        view.clipsToBounds = true
        return view
    }()

    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.viaodaLibreRegular(ofSize: 17)
        label.numberOfLines = 1
        label.textColor = UIColor(named: "primary-dark")
        return label
    }()

    // MARK: - UI Lifecycle

    override func setup() {
        super.setup()

        backgroundView?.backgroundColor = .clear
        contentView.backgroundColor = .clear
        tintColor = .clear

        contentView.addSubview(blurBackgroundView)
        contentView.addSubview(dateLabel)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        let inset = Constants.contentInset

        dateLabel.sizeToFit()

        blurBackgroundView.frame.size = CGSize(width: inset.left + dateLabel.frame.size.width + inset.right,
                                               height: inset.top + dateLabel.frame.size.height + inset.bottom)

        dateLabel.center = contentView.center
        blurBackgroundView.center = contentView.center

        blurBackgroundView.layer.cornerRadius = blurBackgroundView.frame.size.height / 2
    }

    // MARK: - UI Methods

    /// Sets up header with `date`
    func configureWith(date: String) {
        dateLabel.text = date
    }
}
