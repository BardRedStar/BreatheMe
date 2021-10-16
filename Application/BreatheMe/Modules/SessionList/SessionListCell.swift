//
//  SessionListCell.swift
//  BreatheMe
//
//  Created by Denis Kovalev on 16.10.2021.
//

import UIKit

class SessionListCell: SetuppableTableViewCell {
    // MARK: - Definitions

    struct ViewModel {
        let inhales: Int
        let exhales: Int
        let startDate: String
        let endDate: String
    }

    enum Constants {
        static let reuseIdentifier = "SessionListCell"

        static let contentInset = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        static let innerInset: CGFloat = 10
    }

    // MARK: - UI Controls


    private lazy var blurBackgroundView = UIVisualEffectView(effect: UIBlurEffect(style: .systemThickMaterial))

    private lazy var durationLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = .systemFont(ofSize: 12)
        label.numberOfLines = 1
        return label
    }()

    private lazy var inhalesCountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 12)
        label.numberOfLines = 1
        return label
    }()

    private lazy var exhalesCountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 12)
        label.numberOfLines = 1
        return label
    }()

    // MARK: - UI Lifecycle

    override func setup() {
        super.setup()

        selectedBackgroundView = nil

        contentView.addSubview(blurBackgroundView)
        contentView.addSubview(durationLabel)

        contentView.backgroundColor = .clear
        blurBackgroundView.layer.cornerRadius = 10
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        blurBackgroundView.frame = contentView.frame

        let (width, height) = (bounds.width, bounds.height)
        let topInset = Constants.contentInset.top
        let bottomInset = Constants.contentInset.bottom
        let leftInset = Constants.contentInset.left
        let rightInset = Constants.contentInset.right

        let inhalesLabelSize = inhalesCountLabel.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude,
                                                                     height: .greatestFiniteMagnitude))
        let exhalesLabelSize = exhalesCountLabel.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude,
                                                                     height: .greatestFiniteMagnitude))

        let verticalSpace = (height - inhalesLabelSize.height - Constants.innerInset - exhalesLabelSize.height) / 2

        inhalesCountLabel.frame = CGRect(origin: CGPoint(x: width - rightInset - inhalesLabelSize.width,
                                                         y: topInset + verticalSpace),
                                         size: inhalesLabelSize)

        exhalesCountLabel.frame = CGRect(origin: CGPoint(x: width - rightInset - exhalesLabelSize.width,
                                                         y: height - bottomInset - verticalSpace),
                                         size: exhalesLabelSize)

        let durationHeight = durationLabel.sizeThatFits(CGSize(width: width, height: .greatestFiniteMagnitude))
        durationLabel.frame = .zero
    }

    // MARK: - UI Methods

    func configureWith(model: ViewModel) {
        durationLabel.text = "\(model.startDate) - \(model.endDate)"
        inhalesCountLabel.text = "Inhales: \(model.inhales)"
        exhalesCountLabel.text = "Exhales: \(model.exhales)"
    }
}
