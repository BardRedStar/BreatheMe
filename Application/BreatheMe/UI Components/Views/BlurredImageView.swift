//
//  BlurredImageView.swift
//  BreatheMe
//
//  Created by Denis Kovalev on 17.10.2021.
//

import UIKit

/// An image view with blur effect
class BlurredImageView: SetuppableView {

    // MARK: - UI Controls

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        return imageView
    }()

    private lazy var blurEffectView: UIVisualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .light))

    // MARK: - Properties

    /// Image, which will be blurred
    var image: UIImage? {
        get {
            imageView.image
        }
        set {
            imageView.image = newValue
        }
    }

    /// Blur alpha level
    var blurAlpha: CGFloat {
        get {
            blurEffectView.alpha
        }
        set {
            blurEffectView.alpha = newValue
        }
    }

    // MARK: - UI Lifecycle

    override func setup() {
        super.setup()

        addSubview(imageView)
        addSubview(blurEffectView)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = bounds
        blurEffectView.frame = bounds
    }

}
