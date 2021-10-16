//
//  SessionListTableHeaderView.swift
//  BreatheMe
//
//  Created by Denis Kovalev on 16.10.2021.
//

import UIKit

class SessionListTableHeaderView: SetuppableTableHeaderFooterView {
    // MARK: - Definitions

    enum Constants {
        static let reuseIdentifier = "SessionListTableHeaderView"

        static let contentInset = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
    }

    // MARK: - UI Controls

    private lazy var backgroundBlurView = UIVisualEffectView(effect: UIBlurEffect(style: .systemThickMaterial))

    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.numberOfLines = 1
        label.textColor = .white
        return label
    }()

    // MARK: - UI Lifecycle

    override func setup() {
        super.setup()

        contentView.backgroundColor = .clear

        contentView.addSubview(backgroundBlurView)
        contentView.addSubview(dateLabel)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        backgroundBlurView.layer.cornerRadius = bounds.height / 2

        let inset = Constants.contentInset

        dateLabel.sizeToFit()

        backgroundBlurView.frame.size = CGSize(width: inset.left + dateLabel.frame.size.width + inset.right,
                                               height: inset.top + dateLabel.frame.size.height + inset.bottom)

        dateLabel.center = contentView.center
        backgroundBlurView.center = contentView.center
    }

    // MARK: - UI Methods

    func configureWith(date: String) {
        dateLabel.text = date
    }
}
