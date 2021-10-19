//
//  MainViewController.swift
//  BreatheMe
//
//  Created by Denis Kovalev on 06.10.2021.
//

import UIKit

class MainViewController: UIViewController {
    // MARK: - Definitions

    enum Constants {
        static let storyboardName = "MainViewController"
    }

    // MARK: - Outlets

    @IBOutlet private var backgroundImageView: BlurredImageView!
    @IBOutlet private var breatheButton: MainBreatheButton!

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

        configureRecorder()
        configureProcessor()
    }

    // MARK: - UI Methods

    private func configureRecorder() {
        recorder.isFakeMode = false

        recorder.didRecordVolumeValue = { [weak self] value in
            self?.processor.processNewVolumeValue(value)
        }
    }

    private func configureProcessor() {
        processor.didChangeStage = { [weak self] stage in
            guard let self = self else { return }

            self.viewModel.processBreatheStage(stage)
        }
    }

    // MARK: - UI Callbacks

    @IBAction private func sessionsAction(_ sender: Any) {
        if viewModel.isBreathing {
            recorder.stopRecording()
            viewModel.endCurrentSession()
        }

        didTapSessions?()
    }

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

