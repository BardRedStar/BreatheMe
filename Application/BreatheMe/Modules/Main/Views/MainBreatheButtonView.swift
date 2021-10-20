//
//  MainBreatheButtonView.swift
//  BreatheMe
//
//  Created by Denis Kovalev on 06.10.2021.
//

import UIKit

/// A button for breathe action on main screen
class MainBreatheButtonView: SetuppableView {
    // MARK: - UI Controls

    private lazy var blurredBackgroundView: UIVisualEffectView = {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .systemMaterialLight))
        view.alpha = 0.65
        view.clipsToBounds = true
        return view
    }()

    private lazy var breatheButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.setTitleColor(UIColor(named: "primary"), for: .normal)
        return button
    }()

    // MARK: - Output

    var didTapButton: (() -> Void)?

    // MARK: - Properties

    var title: String = "" {
        didSet {
            breatheButton.setTitle(title, for: .normal)
            setNeedsLayout()
            layoutIfNeeded()
        }
    }

    // MARK: - UI Lifecycle

    override func setup() {
        super.setup()

        backgroundColor = .clear

        addSubview(blurredBackgroundView)
        addSubview(breatheButton)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        blurredBackgroundView.layer.cornerRadius = bounds.height / 2
        blurredBackgroundView.frame = bounds

        breatheButton.frame = bounds
    }

    // MARK: - UI Callbacks

    @objc private func buttonAction(_ sender: Any) {
        didTapButton?()
    }
}
