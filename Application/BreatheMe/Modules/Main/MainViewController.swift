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

    @IBOutlet private var welcomeLabel: UILabel!
    @IBOutlet private var backgroundImageView: BlurredImageView!
    @IBOutlet private var breatheButtonView: MainBreatheButtonView!
    @IBOutlet private var sessionsButtonView: BlurredButtonView!
    @IBOutlet private var statisticsView: MainBreatheSessionValuesView!

    @IBOutlet private var welcomeLabelTopConstraint: NSLayoutConstraint!

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
        backgroundImageView.blurAlpha = 0.6

        welcomeLabel.text = "Main-Welcome-Text".localized()

        sessionsButtonView.text = "Main-Sessions-Button-Title".localized()
        sessionsButtonView.textInset = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        sessionsButtonView.didTapButton = { [weak self] in
            self?.processSessionsAction()
        }

        breatheButtonView.title = "Main-Breathe-Button-Title-Start".localized()
        breatheButtonView.didTapButton = { [weak self] in
            self?.processBreatheAction()
        }
        
        configureRecorder()
        configureProcessor()

        performWelcomeAnimation()
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
            self.statisticsView.configureWith(model: self.viewModel.sessionValuesViewModel())
        }
    }

    private func performWelcomeAnimation() {
        welcomeLabel.alpha = 0
        breatheButtonView.alpha = 0
        sessionsButtonView.alpha = 0

        welcomeLabelTopConstraint.constant = 100
        view.layoutIfNeeded()

        UIView.animate(withDuration: 1.0, delay: 0.5, options: [.curveEaseOut]) { [weak self] in

            self?.welcomeLabel.alpha = 1

            self?.welcomeLabelTopConstraint.constant = 20
            self?.view.layoutIfNeeded()

        } completion: { finished in
            if finished {
                UIView.animate(withDuration: 1.0, delay: 1.0, options: [.curveEaseInOut]) { [weak self] in
                    self?.breatheButtonView.alpha = 1
                    self?.sessionsButtonView.alpha = 1
                }
            }
        }

    }

    private func setStatisticsVisible(_ isVisible: Bool) {
        viewModel.resetStatisticsValues()
        statisticsView.configureWith(model: viewModel.sessionValuesViewModel())

        statisticsView.isHidden = !isVisible
    }

    // MARK: - UI Callbacks

    /// Sessions button action
    private func processSessionsAction() {
        if viewModel.isBreathing {
            recorder.stopRecording()
            viewModel.endCurrentSession()
        }

        didTapSessions?()
    }

    /// Breathe button action
    private func processBreatheAction() {
        if viewModel.isBreathing {
            setStatisticsVisible(false)
            breatheButtonView.title = "Main-Breathe-Button-Title-Start".localized()
            recorder.stopRecording()
            viewModel.endCurrentSession()
        } else {
            setStatisticsVisible(true)
            breatheButtonView.title = "Main-Breathe-Button-Title-Stop".localized()
            recorder.startRecording()
            viewModel.startNewSession()
        }
        viewModel.isBreathing.toggle()
    }
}

