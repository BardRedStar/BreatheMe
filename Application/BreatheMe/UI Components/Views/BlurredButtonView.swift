//
//  BlurredButtonView.swift
//  BreatheMe
//
//  Created by Denis Kovalev on 20.10.2021.
//

import UIKit

class BlurredButtonView: SetuppableView {

    // MARK: - UI Controls

    private lazy var blurBackgroundView: UIVisualEffectView = {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .extraLight))
        view.alpha = 0.65
        view.clipsToBounds = true
        return view
    }()

    private lazy var button: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        button.titleLabel?.font = Fonts.viaodaLibreRegular(ofSize: 25)
        button.setTitleColor(UIColor(named: "primary"), for: .normal)
        return button
    }()

    // MARK: - Output

    var didTapButton: (() -> Void)?

    // MARK: - Properties

    var textInset: UIEdgeInsets = .zero {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }

    var text: String? {
        get {
            button.title(for: .normal)
        }
        set {
            button.setTitle(newValue, for: .normal)
            invalidateIntrinsicContentSize()
        }
    }

    override var intrinsicContentSize: CGSize {
        let buttonSize = button.intrinsicContentSize
        return CGSize(width: textInset.left + buttonSize.width + textInset.right,
                      height: textInset.top + buttonSize.height + textInset.bottom)
    }

    // MARK: - UI Lifecycle

    override func setup() {
        super.setup()

        backgroundColor = .clear

        addSubview(blurBackgroundView)
        addSubview(button)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        blurBackgroundView.frame = bounds
        blurBackgroundView.layer.cornerRadius = bounds.height / 2

        button.sizeToFit()
        button.frame.origin = CGPoint(x: textInset.left, y: textInset.top)
    }

    // MARK: - UI Callbacks

    @objc private func buttonAction(_ sender: Any) {
        didTapButton?()
    }
}
