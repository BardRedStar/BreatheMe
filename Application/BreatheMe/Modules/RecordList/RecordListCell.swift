//
//  RecordListCell.swift
//  BreatheMe
//
//  Created by Denis Kovalev on 18.10.2021.
//

import UIKit

/// A cell class for records list screen
class RecordListCell: SetuppableTableViewCell {
    // MARK: - Definitions

    /// Data for displaying on UI
    struct ViewModel {
        let type: String
        let duration: String
    }

    /// Constants
    enum Constants {
        /// Reuse identifier for this cell type
        static let reuseIdentifier = "RecordListCell"

        /// Inset for content in card
        static let contentInset = UIEdgeInsets(top: 10, left: 30, bottom: 10, right: 30)
        /// Inset of the card relative to cell bounds
        static let cardInset = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
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

    private lazy var typeLabel: UILabel = {
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
        contentView.addSubview(typeLabel)

        backgroundView?.backgroundColor = .clear
        contentView.backgroundColor = .clear
        backgroundColor = .clear
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        blurBackgroundView.frame = contentView.frame.inset(by: Constants.cardInset)

        let (width, height) = (bounds.width, bounds.height)
        let inset = Constants.contentInset

        durationLabel.sizeToFit()
        let durationLabelSize = durationLabel.frame.size
        durationLabel.frame.origin = CGPoint(x: width - inset.right - durationLabelSize.width, y: (height - durationLabelSize.height) / 2)

        let typeLabelSize = typeLabel.sizeThatFits(CGSize(width: width - inset.left - durationLabel.frame.minX,
                                                            height: .greatestFiniteMagnitude))

        typeLabel.frame = CGRect(origin: CGPoint(x: inset.left, y: (height - typeLabelSize.height) / 2), size: typeLabelSize)
    }

    // MARK: - UI Methods

    /// Configures cell with UI `model`
    func configureWith(model: ViewModel) {
        typeLabel.text = model.type
        durationLabel.text = model.duration
    }
}
