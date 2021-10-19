//
//  SessionListCell.swift
//  BreatheMe
//
//  Created by Denis Kovalev on 16.10.2021.
//

import UIKit

/// A cell class for session list screen
class SessionListCell: SetuppableTableViewCell {
    // MARK: - Definitions

    /// Data displaying on UI
    struct ViewModel {
        let inhales: Int
        let exhales: Int
        let startDate: String
        let endDate: String
    }

    /// Constants
    enum Constants {
        /// Reuse identifier for current cell class
        static let reuseIdentifier = "SessionListCell"

        /// Inser for content inside a card
        static let contentInset = UIEdgeInsets(top: 10, left: 30, bottom: 10, right: 30)
        /// Inser for a card relative to cell bounds
        static let cardInset = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        /// Inset between labels
        static let innerInset: CGFloat = 10
    }

    // MARK: - UI Controls

    private lazy var blurBackgroundView: UIVisualEffectView = {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .extraLight))
        view.alpha = 0.7
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        return view
    }()

    private lazy var durationLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = .systemFont(ofSize: 12)
        label.numberOfLines = 1
        return label
    }()

    private lazy var inhalesCountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = .systemFont(ofSize: 12)
        label.numberOfLines = 1
        return label
    }()

    private lazy var exhalesCountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = .systemFont(ofSize: 12)
        label.numberOfLines = 1
        return label
    }()

    // MARK: - UI Lifecycle

    override func setup() {
        super.setup()

        selectionStyle = .none
        selectedBackgroundView = nil

        contentView.addSubview(blurBackgroundView)
        contentView.addSubview(durationLabel)
        contentView.addSubview(exhalesCountLabel)
        contentView.addSubview(inhalesCountLabel)

        backgroundView?.backgroundColor = .clear
        contentView.backgroundColor = .clear
        backgroundColor = .clear
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        blurBackgroundView.frame = contentView.frame.inset(by: Constants.cardInset)

        let (width, height) = (bounds.width, bounds.height)
        let inset = Constants.contentInset
        let innerInset = Constants.innerInset

        inhalesCountLabel.sizeToFit()
        exhalesCountLabel.sizeToFit()

        let inhalesLabelSize = inhalesCountLabel.frame.size
        let exhalesLabelSize = exhalesCountLabel.frame.size

        let verticalSpace = (height - inhalesLabelSize.height - innerInset - exhalesLabelSize.height) / 2

        inhalesCountLabel.frame.origin = CGPoint(x: width - inset.right - inhalesLabelSize.width, y: inset.top + verticalSpace - inhalesLabelSize.height / 2)
        exhalesCountLabel.frame.origin = CGPoint(x: width - inset.right - exhalesLabelSize.width, y: height - inset.bottom - verticalSpace - exhalesLabelSize.height / 2)

        let durationMaxX = min(inhalesCountLabel.frame.origin.x, exhalesCountLabel.frame.origin.x)
        let durationHeight = durationLabel.sizeThatFits(CGSize(width: width, height: .greatestFiniteMagnitude)).height
        durationLabel.frame = CGRect(origin: CGPoint(x: inset.left, y: (height - durationHeight) / 2),
                                     size: CGSize(width: durationMaxX - inset.left, height: durationHeight))
    }

    // MARK: - UI Methods

    /// Sets up cell with UI `model`
    func configureWith(model: ViewModel) {
        durationLabel.text = "\(model.startDate) - \(model.endDate)"
        inhalesCountLabel.text = "SessionList-Inhales-Label".localized() + "\(model.inhales)"
        exhalesCountLabel.text = "SessionList-Exhales-Label".localized() + "\(model.exhales)"
    }
}
