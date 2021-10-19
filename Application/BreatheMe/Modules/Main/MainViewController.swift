//
//  MainViewController.swift
//  BreatheMe
//
//  Created by Denis Kovalev on 06.10.2021.
//

import UIKit

/// A controller for main screen
class MainViewController: UIViewController {

    // MARK: - Definitions

    /// Constants
    enum Constants {
        /// A storyboard name which the current controller belongs to
        static let storyboardName = "MainViewController"
    }

    // MARK: - Outlets

    @IBOutlet private var backgroundImageView: BlurredImageView!
    @IBOutlet private var breatheButton: MainBreatheButton!
    @IBOutlet private var sessionsButton: UIButton!

    // MARK: - Output

    var didTapSessions: (() -> Void)?

    // MARK: - Properties

    private var viewModel: MainControllerViewModel!

    private lazy var recorder = BreatheRecorder(parentController: self)
    private lazy var processor = BreatheProcessor()

    // MARK: - Initialization

    class func instantiate(viewModel: MainControllerViewModel) -> MainViewController {
        let controller = UIStoryboard(name: Constants.storyboardName, bundle: nil).instantiateInitialViewController() as! MainViewController
        controller.viewModel = viewModel
        return controller
    }

    // MARK: - UI Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = ""

        backgroundImageView.image = UIImage(named: "background")
        backgroundImageView.blurAlpha = 0.75

        breatheButton.setTitle("Main-Breathe-Button-Title".localized(), for: .normal)
        sessionsButton.setTitle("Main-Sessions-Button-Title".localized(), for: .normal)
        
        configureRecorder()
        configureProcessor()
    }

    // MARK: - UI Methods

    /// Sets up the breathe recorder
    private func configureRecorder() {
        recorder.didRecordVolumeValue = { [weak self] value in
            self?.processor.processNewVolumeValue(value)
        }
    }

    /// Sets up the breathe processor
    private func configureProcessor() {
        processor.didChangeStage = { [weak self] stage in
            guard let self = self else { return }

            self.viewModel.processBreatheStage(stage)
        }
    }

    // MARK: - UI Callbacks

    /// Sessions button action
    @IBAction private func sessionsAction(_ sender: Any) {
        if viewModel.isBreathing {
            recorder.stopRecording()
            viewModel.endCurrentSession()
        }

        didTapSessions?()
    }

    /// Breathe button action
    @IBAction private func breatheAction(_ sender: Any) {
        if viewModel.isBreathing {
            recorder.stopRecording()
            viewModel.endCurrentSession()
        } else {
            recorder.startRecording()
            viewModel.startNewSession()
        }
        viewModel.isBreathing.toggle()
    }
}

